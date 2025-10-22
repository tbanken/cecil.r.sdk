# TODO test both


#' rotate api key
#'
#' @returns RotateAPIKey
#' @export
#'
#' @examples
rotate_api_key <- function() {
  model <- RotateAPIKeyRequest$new()
  resp <- cecil_request("/v0/api-key/rotate", "POST", model$as_list(),TRUE)
  RotateAPIKey$new(resp$newApiKey)
}

#' recover api key
#'
#' @param email Cecil user email
#'
#' @returns RecoverAPIKey
#' @export
#'
#' @examples
recover_api_key <- function(email) {
  model <- RecoverAPIKeyRequest$new(email = email)
  resp <- cecil_request("/v0/api-key/recover", body = model$as_list())
  RecoverAPIKey(resp$message)
}
