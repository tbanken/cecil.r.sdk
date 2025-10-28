# TODO test error checking
# TODO fix camelCase -> snake_case
# read in datetime correctly

set_auth <- function() {
  api_key <- Sys.getenv("CECIL_API_KEY")
  api_key
}


#' @importFrom utils packageVersion
get_package_version <- function(test=FALSE) {
  if(test) {
    desc <- read.dcf(file.path("..", "DESCRIPTION"))
    version <- desc[1, "Version"]
  } else {
    version <- as.character(packageVersion("cecil.r.sdk"))
  }
  version
}

#' @importFrom httr2 request req_auth_basic req_method req_headers req_body_json req_perform resp_body_json resp_status
cecil_request <- function(endpoint, method = "GET", body = NULL, skip_auth = FALSE) {
  base_url <- "https://api.cecil.earth"
  api_key <- set_auth()
  if (api_key == "") stop("Set your Cecil API key before using package functions")

  version <- get_package_version()

  req <- request(paste0(base_url, endpoint)) |>
    req_method(method) |>
    req_headers("cecil-r-sdk-version" = version)

  if (!skip_auth) {
    req <- req |>
      req_auth_basic(user = api_key, password = "")
  }


  if (!is.null(body)) req <- req |> req_body_json(body)
  res <- req |> req_perform()
  status <- res |> resp_status()

  if (status >= 400) {
    body <- res |> resp_body_string()
    stop(sprintf("Request failed [%d]: %s", status, body), call. = FALSE)
  }
  resp_body_json(res, simplifyVector = TRUE)
}





