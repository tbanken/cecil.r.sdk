# TODO implement skip auth, errors
# TODO fix camelCase -> snake_case
# read in datetime correctly

set_auth <- function() {
  # Sys.setenv(CECIL_API_KEY = key)
  api_key <- Sys.getenv("CECIL_API_KEY")
  api_key
}


#' @importFrom utils packageVersion
get_package_version <- function(test=FALSE) {
  if(test) {
    desc <- read.dcf(file.path("..", "DESCRIPTION"))
    version <- desc[1, "Version"]
  } else {
    version <- as.character(packageVersion("cecil"))
  }
  version
}

#' @importFrom httr2 request req_auth_basic req_method req_headers req_body_json req_perform resp_body_json
cecil_request <- function(endpoint, method = "GET", body = NULL) {
  base_url <- "https://api.cecil.earth"
  api_key <- set_auth()
  if (api_key == "") stop("Set your API key with set_cecil_api_key()")

  version <- get_package_version()

  req <- request(paste0(base_url, endpoint)) |>
    req_auth_basic(user = api_key, password = "") |>
    req_method(method) |>
    req_headers("cecil-r-sdk-version" = version)

  if (!is.null(body)) req <- req |> req_body_json(body)
  res <- req |> req_perform()
  resp_body_json(res, simplifyVector = TRUE)
}




# Some useful keyboard shortcuts for package authoring:
#
#   Install Package:           'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'
