# load raster and vector
#TODO total overhaul using Subscription and Bucket
#' load terra
#'
#' @param subscription_id ID for subscription to load
#'
#' @returns SpatRaster
#' @export
#' @examples
load_terra <- function(subscription_id) {
  full_endpoint <- paste0("/v0/subscriptions/", subscription_id, "/files/tiff")
  resp <- cecil_request(full_endpoint)
  metadata <- SubscriptionListFiles$new(
    resp$providerName,
    resp$datasetId,
    resp$datasetName,
    resp$aoiId,
    resp$subscriptionId,
    resp$bucket,
    resp$credentials,
    resp$allowedActions,
    resp$fileMapping
  )
  rast_from_metadata(metadata)
}


#' @importFrom paws s3
#' @importFrom terra rast time setGDALconfig metags
rast_from_metadata <- function(metadata) {
  setGDALconfig("AWS_ACCESS_KEY_ID", metadata$credentials$accessKeyId)
  setGDALconfig("AWS_SECRET_ACCESS_KEY", metadata$credentials$secretAccessKey)
  setGDALconfig("AWS_SESSION_TOKEN", metadata$credentials$sessionToken)
  # Create S3 client with credentials
  s3 <- s3(
    config = list(
      credentials = list(
        creds = list(
          access_key_id = metadata$credentials$accessKeyId,
          secret_access_key = metadata$credentials$secretAccessKey,
          session_token = metadata$credentials$sessionToken
        )
      ),
      region = metadata$credentials$region
    )
  )

  # List all objects in the bucket with the prefix
  objects <- s3$list_objects_v2(
    Bucket = metadata$bucket$name,
    Prefix = metadata$bucket$prefix
  )

  # Filter for .tif/.tiff files
  tiff_keys <- Filter(function(obj) {
    grepl("\\.tiff?$", obj$Key, ignore.case = TRUE)
  }, objects$Contents)

  if (length(tiff_keys) == 0) {
    stop("No TIFF files found in bucket")
  }

  all_bands <- list()

  for (i in seq_along(tiff_keys)) {
    key <- tiff_keys[[i]]$Key

    # Load raster from S3 via GDAL
    url<-paste0("/vsis3/",metadata$bucket$name,"/",key)
    raster <- rast(url)

    file_name <- gsub('"|\'|\\.tiff?$', '', names(metadata$file_mapping)[i], ignore.case = TRUE)

    for (j in seq_along(metadata$file_mapping)) {

      #get correct band and name

      band <- raster[[metadata$file_mapping[[j]]$bands$number]]

      name <- metadata$file_mapping[[j]]$bands$name

      if(name != file_name) {
        next
      }

      names(band) <- name

      #check if time dimension and assign if needed

      timestamp_match <- regexpr("\\d{4}/\\d{2}/\\d{2}/\\d{2}/\\d{2}/\\d{2}", key)
      band_timestamp <- NA

      if (timestamp_match != -1) {
        timestamp_str <- regmatches(key, timestamp_match)

        # Only parse if not the zero timestamp
        if (timestamp_str != "0000/00/00/00/00/00") {
          band_timestamp <- as.POSIXct(timestamp_str, format = "%Y/%m/%d/%H/%M/%S", tz = "UTC")
          time(band) <- band_timestamp
        }
      }
      all_bands[[length(all_bands) + 1]] <- band
    }
  }
  result <- rast(all_bands)
  metags(result) <- c(
   paste0("provider_name=", metadata$provider_name),
   paste0("dataset_id=", metadata$dataset_id),
   paste0("dataset_name=", metadata$dataset_name),
   paste0("dataset_crs=", metadata$dataset_crs),
   paste0("aoi_id=", metadata$aoi_id),
   paste0("data_request_id=", metadata$data_request_id)
  )
  result
}











#' #TODO fix metadata etc
#' #' @importFrom terra rast metags time
#' rast_from_metadata <- function(metadata) {
#'
#'   all_bands <- list()
#'   urls <- metadata$files$url
#'   bands <- metadata$files$bands
#'
#'   for (url in urls) {
#'     r <- rast(url)
#'
#'     for (band_info in bands) {
#'
#'       band <- r[[band_info$number]]
#'       names(band) <- band_info$variable_name
#'       # Set time if present
#'       if (
#'         length(band_info$time) > 0 &&
#'         length(band_info$time_pattern) > 0 &&
#'         !all(band_info$time == "") &&
#'         !all(band_info$time_pattern == "") &&
#'         !all(is.na(band_info$time)) &&
#'         !all(is.na(band_info$time_pattern))
#'       ) {
#'         time(band) <- as.POSIXct(strptime(band_info$time, band_info$time_pattern))
#'       }
#'
#'
#'       all_bands[[length(all_bands) + 1]] <- band
#'     }
#'   }
#'
#'   # Combine all bands
#'   result <- rast(all_bands)
#'
#'   # Sort by time only if time coordinates exist
#'   if (!is.null(time(result)) && any(!is.na(time(result)))) {
#'     # Get time values
#'     time_vals <- time(result)
#'
#'     # Sort by time (NA times will go to the end)
#'     time_order <- order(time_vals, na.last = TRUE)
#'     result <- result[[time_order]]
#'   }
#'
#'
#'
#'
#'   result
#' }

#' load sf
#'
#' @param subscription_id ID for subscription to load
#'
#' @returns sf
#' @export
#' @importFrom arrow read_parquet
#' @importFrom sf st_as_sfc st_sf st_geometrycollection
#' @importFrom jsonlite fromJSON toJSON
#' @examples
load_sf <- function(subscription_id) {
  full_endpoint <- paste0("/v0/subscriptions/", subscription_id, "/parquet-files")
  resp <- cecil_request(full_endpoint)
  metadata <- SubscriptionParquetFiles$new(resp$files)
  df_ls <- lapply(metadata$files, read_parquet)
  df <- do.call(cbind,df_ls)

  geoms <- lapply(df$geojson, function(gj) {
    if (is.na(gj) || gj == "") return(st_geometrycollection())
    st_read(fromJSON(gj, simplifyVector = FALSE) |> toJSON(auto_unbox = TRUE), quiet = TRUE)
  })

  # Ensure each element is of class sfc
  geoms <- lapply(geoms, st_geometry)
  sfc <- do.call(c, geoms)

  st_sf(df[ , !(names(df) %in% "geojson")], geometry = sfc)
}
