# account management
library(purrr)
#' Title
#'
#' @param first_name
#' @param last_name
#' @param email
#'
#' @returns
#' @export
#'
#' @examples
create_user <- function(first_name, last_name, email) {
  model <- UserCreate$new(
    first_name = first_name,
    last_name = last_name,
    email = email
  )
  resp <- cecil_request("/v0/users", "POST", body = model$as_list())
  User$new(
    resp$id,
    resp$firstName,
    resp$lastName,
    resp$email,
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
list_users <- function() {
  resp <- cecil_request("/v0/users")
  pmap(resp$records, function(id, firstName, lastName, email, createdAt, createdBy) {
    User$new(
      id,
      firstName,
      lastName,
      email,
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
get_user <- function(id) {
  full_endpoint <- paste0("/v0/users/", id)
  resp <- cecil_request(full_endpoint)
  print(resp)
  User$new(
    resp$id,
    resp$firstName,
    resp$lastName,
    resp$email,
    resp$createdAt,
    resp$createdBy
  )
}

# update organization settings
#' Title
#'
#' @returns
#' @export
#'
#' @examples
get_organisation_settings <- function() {
  resp <- cecil_request("/v0/organisation/settings")
  OrganisationSettings$new(monthly_data_request_limit = resp$monthlyDataRequestLimit)
}

#' Title
#'
#' @param monthly_data_request_limit
#'
#' @returns
#' @export
#'
#' @examples
update_organisation_settings <- function(monthly_data_request_limit = 50000) {
  model <- OrganisationSettings$new(monthly_data_request_limit = monthly_data_request_limit)
  resp <- cecil_request("/v0/organisation/settings", method = "POST", body = model$as_list())
  OrganisationSettings$new(monthly_data_request_limit = resp$monthlyDataRequestLimit)
}
