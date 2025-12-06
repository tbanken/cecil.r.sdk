# subscription
#TODO test changes to make sure all functions work as before
#' create subscription
#'
#' @param aoi_id ID for AOI to use for subscription
#' @param dataset_id ID for dataset to use for subscription
#' @param external_ref Optional name for subscription
#'
#' @returns Subscription
#' @export
#'
#' @examples
create_subscription <- function(aoi_id, dataset_id, external_ref = NULL) {
  model <- SubscriptionCreate$new(
    aoi_id = aoi_id,
    dataset_id = dataset_id,
    external_ref = external_ref
  )
  resp <- cecil_request("/v0/subscriptions", "POST", body = model$as_list())
  Subscription$new(
    resp$id, resp$aoiId, resp$datasetId, resp$externalRef, resp$createdAt, resp$createdBy
  )
}

#' list subscriptions
#'
#' @returns Subscription list
#' @export
#' @importFrom purrr pmap
#' @examples
list_subscriptions <- function() {
  resp <- cecil_request("/v0/subscriptions")
  pmap(resp$records, function(id, aoiId, datasetId, externalRef, createdAt, createdBy) {
    Subscription$new(
      id,
      aoiId,
      datasetId,
      externalRef,
      createdAt,
      createdBy
    )
  })
}

#' get subscription
#'
#' @param id Subscription ID
#'
#' @returns Subscription
#' @export
#'
#' @examples
get_subscription <- function(id) {
  full_endpoint <- paste0("/v0/subscriptions/", id)
  resp <- cecil_request(full_endpoint)
  Subscription$new(
    resp$id, resp$aoiId, resp$datasetId, resp$externalRef, resp$createdAt, resp$createdBy
  )
}
