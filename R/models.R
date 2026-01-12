library(R6)

#TODO DataRequest obsolete, add new models

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

library(R6)

toCamel <- function(x) {
  gsub("_(.)", "\\U\\1", x, perl = TRUE)
}

# Bucket Model
Bucket <- R6Class("Bucket",
  public = list(
    name = NULL,
    prefix = NULL,
    initialize = function(name, prefix) {
      self$name <- name
      self$prefix <- prefix
    },
    as_list = function() {
      vals <- list(
        name = self$name,
        prefix = self$prefix
      )
      setNames(vals, toCamel(names(vals)))
    }
  )
)

# BucketCredentials Model
BucketCredentials <- R6Class("BucketCredentials",
  public = list(
    access_key_id = NULL,
    secret_access_key = NULL,
    session_token = NULL,
    region = NULL,
    expiration = NULL,
    initialize = function(access_key_id, secret_access_key, session_token, region, expiration) {
      self$access_key_id <- access_key_id
      self$secret_access_key <- secret_access_key
      self$session_token <- session_token
      self$region <- region
      self$expiration <- expiration
    },
    as_list = function() {
      vals <- list(
        access_key_id = self$access_key_id,
        secret_access_key = self$secret_access_key,
        session_token = self$session_token,
        region = self$region,
        expiration = self$expiration
      )
      setNames(vals, toCamel(names(vals)))
    }
  )
)

# Band Model
Band <- R6Class("Band",
  public = list(
    number = NULL,
    name = NULL,
    dtype = NULL,
    nodata = NULL,
    initialize = function(number, name, dtype, nodata = NULL) {
      self$number <- number
      self$name <- name
      self$dtype <- dtype
      self$nodata <- nodata
    },
    as_list = function() {
      vals <- list(
        number = self$number,
        name = self$name,
        dtype = self$dtype,
        nodata = self$nodata
      )
      setNames(vals, toCamel(names(vals)))
    }
  )
)

# File Model
File <- R6Class("File",
  public = list(
    bands = NULL,
    initialize = function(bands) {
      self$bands <- bands
    },
    as_list = function() {
      vals <- list(
        bands = lapply(self$bands, function(b) b$as_list())
      )
      setNames(vals, toCamel(names(vals)))
    }
  )
)

# SubscriptionListFiles Model
SubscriptionListFiles <- R6Class("SubscriptionListFiles",
  public = list(
    provider_name = NULL,
    dataset_id = NULL,
    dataset_name = NULL,
    aoi_id = NULL,
    subscription_id = NULL,
    bucket = NULL,
    credentials = NULL,
    allowed_actions = NULL,
    file_mapping = NULL,
    initialize = function(provider_name, dataset_id, dataset_name, aoi_id, subscription_id,
                         bucket, credentials, allowed_actions, file_mapping) {
      self$provider_name <- provider_name
      self$dataset_id <- dataset_id
      self$dataset_name <- dataset_name
      self$aoi_id <- aoi_id
      self$subscription_id <- subscription_id
      self$bucket <- bucket
      self$credentials <- credentials
      self$allowed_actions <- allowed_actions
      self$file_mapping <- file_mapping
    },
    as_list = function() {
      vals <- list(
        provider_name = self$provider_name,
        dataset_id = self$dataset_id,
        dataset_name = self$dataset_name,
        aoi_id = self$aoi_id,
        subscription_id = self$subscription_id,
        bucket = self$bucket$as_list(),
        credentials = self$credentials$as_list(),
        allowed_actions = self$allowed_actions,
        file_mapping = lapply(self$file_mapping, function(f) f$as_list())
      )
      setNames(vals, toCamel(names(vals)))
    }
  )
)

# SubscriptionParquetFiles Model
SubscriptionParquetFiles <- R6Class("SubscriptionParquetFiles",
  public = list(
    files = NULL,
    initialize = function(files) {
      self$files <- files
    },
    as_list = function() {
      vals <- list(
        files = self$files
      )
      setNames(vals, toCamel(names(vals)))
    }
  )
)

# Subscription Model
Subscription <- R6Class("Subscription",
  public = list(
    id = NULL,
    aoi_id = NULL,
    dataset_id = NULL,
    external_ref = NULL,
    created_at = NULL,
    created_by = NULL,
    initialize = function(id, aoi_id, dataset_id, external_ref = NULL, created_at, created_by) {
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

# SubscriptionCreate Model
SubscriptionCreate <- R6Class("SubscriptionCreate",
  public = list(
    aoi_id = NULL,
    dataset_id = NULL,
    external_ref = NULL,
    initialize = function(aoi_id, dataset_id, external_ref = NULL) {
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

# Dataset Model
Dataset <- R6Class("Dataset",
   public = list(
     id = NULL,
     name = NULL,
     provider_name = NULL,
     category = NULL,
     type = NULL,
     crs = NULL,
     version_number = NULL,
     version_date = NULL,
     initialize = function(id, name, provider_name, category, type, crs, version_number, version_date) {
       self$id <- id
       self$name <- name
       self$provider_name <- provider_name
       self$category <- category
       self$type <- type
       self$crs <- crs
       self$version_number <- version_number
       self$version_date <- version_date
     },
     as_list = function() {
       vals <- list(
         id = self$id,
         name = self$name,
         provider_name = self$provider_name,
         category = self$category,
         type = self$type,
         crs = self$crs,
         version_number = self$version_number,
         version_date = self$version_date
       )
       setNames(vals, toCamel(names(vals)))
     }
   )
)
