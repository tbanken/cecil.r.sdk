# load raster and vector

#' load terra
#'
#' @param data_request_id ID for data request to load
#'
#' @returns SpatRaster
#' @export
#' @examples
load_terra <- function(data_request_id) {
  full_endpoint <- paste0("/v0/data-requests/", data_request_id, "/metadata")
  resp <- cecil_request(full_endpoint)
  metadata <- DataRequestMetadata$new(
    resp$provider_name,
    resp$dataset_id,
    resp$dataset_name,
    resp$dataset_crs,
    resp$aoi_id,
    resp$data_request_id,
    resp$files
  )
  rast_from_metadata(metadata)
}

#TODO fix metadata etc
#' @importFrom terra rast metags
rast_from_metadata <- function(metadata) {
  raster <- rast(metadata$files$url)
  names(raster) <- metadata$files$bands[[1]]$variable_name
  #metags(raster) <- c(
  #  paste0("provider_name=", metadata$provider_name),
  #  paste0("dataset_id=", metadata$dataset_id),
  #  paste0("dataset_name=", metadata$dataset_name),
  #  paste0("dataset_crs=", metadata$dataset_crs),
  #  paste0("aoi_id=", metadata$aoi_id),
  #  paste0("data_request_id=", metadata$data_request_id)
  #)
  raster
}

#' load sf
#'
#' @param data_request_id ID for data request to load
#'
#' @returns sf
#' @export
#' @importFrom arrow read_parquet
#' @importFrom sf st_as_sfc st_sf st_geometrycollection
#' @importFrom jsonlite fromJSON toJSON
#' @examples
load_sf <- function(data_request_id) {
  full_endpoint <- paste0("/v0/data-requests/", data_request_id, "/parquet-files")
  resp <- cecil_request(full_endpoint)

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
