# TODO test both

# rotate api key
#' Title
#'
#' @returns
#' @export
#'
#' @examples
rotate_api_key <- function() {
  model <- RotateAPIKeyRequest$new()
  resp <- cecil_request("/v0/api-key/rotate", "POST", model$as_list())
  RotateAPIKey$new(resp$newApiKey)
}
# recover api key
#' Title
#'
#' @param email
#'
#' @returns
#' @export
#'
#' @examples
recover_api_key <- function(email) {
  model <- RecoverAPIKeyRequest$new(email = email)
  resp <- cecil_request("/v0/api-key/recover", body = model$as_list())
  RecoverAPIKey(resp$message)
}
