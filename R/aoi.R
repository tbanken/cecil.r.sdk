# aoi
library(purrr)
#' Title
#'
#' @param external_ref
#' @param geometry
#'
#' @returns
#' @export
#'
#' @examples
create_aoi <- function(external_ref, geometry) {
  if (geometry$type != "Polygon" &&
    geometry$type != "MultiPolygon") {
    stop(paste0(geometry$type, " is not a valid geometry type.
                Polygon and Multipolygon are the only valid geometry types."))
  }
  model <- AOICreate$new(external_ref = external_ref, geometry = geometry)
  resp <- cecil_request("/v0/aois", "POST", body = model$as_list())
  AOIRecord$new(
    resp$id,
    resp$externalRef,
    resp$hectacres,
    resp$createdAt,
    resp$createdBy
  )
}

#' Title
#'
#' @returns
#' @export
#' @importFrom purrr pmap
#' @examples
list_aois <- function() {
  resp <- cecil_request("/v0/aois")
  pmap(resp$records, function(id, externalRef, hectares, createdAt, createdBy) {
    AOIRecord$new(
      id,
      externalRef,
      hectares,
      createdAt,
      createdBy
    )
  })
}

#' Title
#'
#' @param id
#'
#' @returns
#' @export
#'
#' @examples
get_aoi <- function(id) {
  full_endpoint <- paste0("/v0/aois/", id)
  resp <- cecil_request(full_endpoint)
  AOI$new(
    resp$id,
    resp$externalRef,
    resp$geometry,
    resp$hectacres,
    resp$createdAt,
    resp$createdBy
  )
}
