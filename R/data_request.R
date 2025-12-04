# data request
#TODO obsolete, remove file when others are done
#' create data request
#'
#' @param aoi_id ID for AOI to use for data request
#' @param dataset_id ID for dataset to use for data request
#' @param external_ref Optional name for data request
#'
#' @returns DataRequest
#' @export
#'
#' @examples
create_data_request <- function(aoi_id, dataset_id, external_ref = NULL) {
  model <- DataRequestCreate$new(
    aoi_id = aoi_id,
    dataset_id = dataset_id,
    external_ref = external_ref
  )
  resp <- cecil_request("/v0/data-requests", "POST", body = model$as_list())
  DataRequest$new(
    resp$id, resp$aoiId, resp$datasetId, resp$externalRef, resp$createdAt, resp$createdBy
  )
}

#' list data requests
#'
#' @returns DataRequest list
#' @export
#' @importFrom purrr pmap
#' @examples
list_data_requests <- function() {
  resp <- cecil_request("/v0/data-requests")
  pmap(resp$records, function(id, aoiId, datasetId, externalRef, createdAt, createdBy) {
    DataRequest$new(
      id,
      aoiId,
      datasetId,
      externalRef,
      createdAt,
      createdBy
    )
  })
}

#' get data request
#'
#' @param id Data request ID
#'
#' @returns DataRequest
#' @export
#'
#' @examples
get_data_request <- function(id) {
  full_endpoint <- paste0("/v0/data-requests/", id)
  resp <- cecil_request(full_endpoint)
  DataRequest$new(
    resp$id, resp$aoiId, resp$datasetId, resp$externalRef, resp$createdAt, resp$createdBy
  )
}
