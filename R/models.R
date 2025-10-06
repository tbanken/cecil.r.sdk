library(R6)

toCamel <- function(x) {
  gsub("_(.)", "\\U\\1", x, perl = TRUE)
}

# User Model
User <- R6Class("User",
  public = list(
    id = NULL,
    first_name = NULL,
    last_name = NULL,
    email = NULL,
    created_at = NULL,
    created_by = NULL,
    initialize = function(id, first_name, last_name, email, created_at, created_by) {
      self$id <- id
      self$first_name <- first_name
      self$last_name <- last_name
      self$email <- email
      self$created_at <- created_at
      self$created_by <- created_by
    },
    as_list = function() {
      vals <- list(
        id = self$id,
        first_name = self$first_name,
        last_name = self$last_name,
        email = self$email,
        created_at = self$created_at,
        created_by = self$created_by
      )
      setNames(vals, toCamel(names(vals)))
    }
  )
)

# UserCreate Model
UserCreate <- R6Class("UserCreate",
  public = list(
    first_name = NULL,
    last_name = NULL,
    email = NULL,
    initialize = function(first_name, last_name, email) {
      self$first_name <- first_name
      self$last_name <- last_name
      self$email <- email
    },
    as_list = function() {
      vals <- list(
        first_name = self$first_name,
        last_name = self$last_name,
        email = self$email
      )
      setNames(vals, toCamel(names(vals)))
    }
  )
)

# AOI Model
AOI <- R6Class("AOI",
  public = list(
    id = NULL,
    external_ref = NULL,
    geometry = NULL,
    hectares = NULL,
    created_at = NULL,
    created_by = NULL,
    initialize = function(id, external_ref, geometry, hectares, created_at, created_by) {
      self$id <- id
      self$external_ref <- external_ref
      self$geometry <- geometry
      self$hectares <- hectares
      self$created_at <- created_at
      self$created_by <- created_by
    },
    as_list = function() {
      vals <- list(
        id = self$id,
        external_ref = self$external_ref,
        geometry = self$geometry,
        hectares = self$hectares,
        created_at = self$created_at,
        created_by = self$created_by
      )
      setNames(vals, toCamel(names(vals)))
    }
  )
)

# AOIRecord Model
AOIRecord <- R6Class("AOIRecord",
  public = list(
    id = NULL,
    external_ref = NULL,
    hectares = NULL,
    created_at = NULL,
    created_by = NULL,
    initialize = function(id, external_ref, hectares, created_at, created_by) {
      self$id <- id
      self$external_ref <- external_ref
      self$hectares <- hectares
      self$created_at <- created_at
      self$created_by <- created_by
    },
    as_list = function() {
      vals <- list(
        id = self$id,
        external_ref = self$external_ref,
        hectares = self$hectares,
        created_at = self$created_at,
        created_by = self$created_by
      )
      setNames(vals, toCamel(names(vals)))
    }
  )
)

# AOICreate Model
AOICreate <- R6Class("AOICreate",
  public = list(
    external_ref = NULL,
    geometry = NULL,
    initialize = function(external_ref, geometry) {
      self$external_ref <- external_ref
      self$geometry <- geometry
    },
    as_list = function() {
      vals <- list(
        external_ref = self$external_ref,
        geometry = self$geometry
      )
      setNames(vals, toCamel(names(vals)))
    }
  )
)

# DataRequest Model
DataRequest <- R6Class("DataRequest",
  public = list(
    id = NULL,
    aoi_id = NULL,
    dataset_id = NULL,
    created_at = NULL,
    created_by = NULL,
    external_ref = NULL,
    initialize = function(id, aoi_id, dataset_id, external_ref, created_at, created_by) {
      self$id <- id
      self$aoi_id <- aoi_id
      self$dataset_id <- dataset_id
      self$external_ref <- external_ref
      self$created_at <- created_at
      self$created_by <- created_by
    },
    as_list = function() {
      vals <- list(
        id = self$id,
        aoi_id = self$aoi_id,
        dataset_id = self$dataset_id,
        external_ref = self$external_ref,
        created_at = self$created_at,
        created_by = self$created_by
      )
      setNames(vals, toCamel(names(vals)))
    }
  )
)

# DataRequestCreate Model
DataRequestCreate <- R6Class("DataRequestCreate",
  public = list(
    aoi_id = NULL,
    dataset_id = NULL,
    external_ref = NULL,
    initialize = function(aoi_id, dataset_id, external_ref) {
      self$aoi_id <- aoi_id
      self$dataset_id <- dataset_id
      self$external_ref <- external_ref
    },
    as_list = function() {
      vals <- list(
        aoi_id = self$aoi_id,
        dataset_id = self$dataset_id,
        external_ref = self$external_ref
      )
      setNames(vals, toCamel(names(vals)))
    }
  )
)

# DataRequestMetadata Model
DataRequestMetadata <- R6Class("DataRequestMetadata",
  public = list(
    provider_name = NULL,
    dataset_id = NULL,
    dataset_name = NULL,
    dataset_crs = NULL,
    aoi_id = NULL,
    data_request_id = NULL,
    files = NULL,
    initialize = function(provider_name,
                          dataset_id,
                          dataset_name,
                          dataset_crs,
                          aoi_id,
                          data_request_id,
                          files) {
      self$provider_name <- provider_name
      self$dataset_id <- dataset_id
      self$dataset_name <- dataset_name
      self$dataset_crs <- dataset_crs
      self$aoi_id <- aoi_id
      self$data_request_id <- data_request_id
      self$files <- files
    },
    as_list = function() {
      vals <- list(
        provider_name <- self$provider_name,
        dataset_id <- self$dataset_id,
        dataset_name <- self$dataset_name,
        dataset_crs <- self$dataset_crs,
        aoi_id <- self$aoi_id,
        data_request_id <- self$data_request_id,
        files <- self$files
      )
      setNames(vals, toCamel(names(vals)))
    }
  )
)


# OrganisationSettings Model
OrganisationSettings <- R6Class("OrganisationSettings",
  public = list(
    monthly_data_request_limit = NULL,
    initialize = function(monthly_data_request_limit = NULL) {
      self$monthly_data_request_limit <- monthly_data_request_limit
    },
    as_list = function() {
      vals <- list(
        monthly_data_request_limit = self$monthly_data_request_limit
      )
      setNames(vals, toCamel(names(vals)))
    }
  )
)

# RecoverAPIKey Model
RecoverAPIKey <- R6Class("RecoverAPIKey",
  public = list(
    message = NULL,
    initialize = function(message) {
      self$message <- message
    },
    as_list = function() {
      vals <- list(message = self$message)
      setNames(vals, toCamel(names(vals)))
    }
  )
)

# RecoverAPIKeyRequest Model
RecoverAPIKeyRequest <- R6Class("RecoverAPIKeyRequest",
  public = list(
    email = NULL,
    initialize = function(email) {
      self$email <- email
    },
    as_list = function() {
      vals <- list(email = self$email)
      setNames(vals, toCamel(names(vals)))
    }
  )
)

# RotateAPIKey Model
RotateAPIKey <- R6Class("RotateAPIKey",
  public = list(
    new_api_key = NULL,
    initialize = function(new_api_key) {
      self$new_api_key <- new_api_key
    },
    as_list = function() {
      vals <- list(new_api_key = self$new_api_key)
      setNames(vals, toCamel(names(vals)))
    }
  )
)

# RotateAPIKeyRequest Model
RotateAPIKeyRequest <- R6Class("RotateAPIKeyRequest",
  public = list(
    initialize = function() {},
    as_list = function() list()
  )
)
