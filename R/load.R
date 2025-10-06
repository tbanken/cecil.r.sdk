# load raster
library(terra)
library(nanoparquet)

# TODO finish and test load dataframe

#' Title
#'
#' @param data_request_id
#'
#' @returns
#' @export
#'
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

rast_from_metadata <- function(metadata) {
  raster <- rast(metadata$files$url)
  metags(raster) <- c(
    paste0("provider_name=", metadata$provider_name),
    paste0("dataset_id=", metadata$dataset_id),
    paste0("dataset_name=", metadata$dataset_name),
    paste0("dataset_crs=", metadata$dataset_crs),
    paste0("aoi_id=", metadata$aoi_id),
    paste0("data_request_id=", metadata$data_request_id)
  )
  raster
}

# TODO finish and test
#' Title
#'
#' @param data_request_id
#'
#' @returns
#' @export
#'
#' @examples
load_dataframe <- function(data_request_id) {
  full_endpoint <- paste0("/v0/data-requests/", data_request_id, "/parquet-files")
  resp <- cecil_request(full_endpoint)
  #datarequest parquet files object
  df_ls <- lapply(metadata$files, read_parquet)
  do.call(cbind,df_ls)
}
