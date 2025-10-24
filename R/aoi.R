# aoi

#' create aoi
#'
#' @param external_ref Optional name for AOI
#' @param geometry geometry as list of lists or JSON
#'
#' @returns AOIRecord
#' @export
#' @importFrom jsonlite fromJSON
#' @examples
create_aoi <- function(external_ref, geometry) {
  if (is.character(geometry)) {
    geometry <- fromJSON(geometry)
  }

  if (!geometry$type %in% c("Polygon", "MultiPolygon")) {
    stop(paste0(
      geometry$type,
      " is not a valid geometry type. ",
      "Polygon and MultiPolygon are the only valid geometry types."
    ))
  }
  model <- AOICreate$new(external_ref = external_ref, geometry = geometry)
  resp <- cecil_request("/v0/aois", "POST", body = model$as_list())
  AOIRecord$new(
    resp$id,
    resp$externalRef,
    resp$hectares,
    resp$createdAt,
    resp$createdBy
  )
}

#' list aois
#'
#' @returns AOIRecord list
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

#' get aoi
#'
#' @param id AOI ID
#'
#' @returns AOI
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
    resp$hectares,
    resp$createdAt,
    resp$createdBy
  )
}
