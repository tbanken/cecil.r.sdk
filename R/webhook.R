#' config webhook
#'
#' @param id ID for AOI to use for subscription
#' @param url ID for dataset to use for subscription
#'
#' @returns Webhook
#' @export
#'
#' @examples
config_webhook <- function(url, secret) {
  model <- WebhookConfigure$new(
    url = url,
    secret = secret
  )
  resp <- cecil_request("/v0/webhooks", "POST", body = model$as_list())
  Webhook$new(
    resp$id, resp$url
  )
}

#' delete webhook
#'
#' @returns
#' @export
#'
#' @examples
delete_webhook <- function() {
  resp <- cecil_request("/v0/webhooks", "DELETE")
}
