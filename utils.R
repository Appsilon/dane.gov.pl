library(readr)
library(assertr)
library(dplyr)

common_date_format <- "%Y-%m-%d"
common_time_format <- "%Y-%m-%dT%H:%M:%S"

check_date_format <- function(date) {
  tryCatch(!is.na(as.Date(date, common_date_format)),
    error = function(err) {FALSE})
}
attr(check_date_format, "assertr_vectorized") <- TRUE

check_datetime_format <- function(date) {
  tryCatch(!is.na(as.POSIXct(date, common_time_format)),
           error = function(err) {FALSE})
}
attr(check_datetime_format, "assertr_vectorized") <- TRUE

check_data_last_5min <- function(time) {
  as.POSIXct(time, common_time_format) <= Sys.time() - 5 * 60
}

sum_up <- function(validation_result) {
  disp_summary <- function(data_row) {
    additional_info <- ""
    if (data_row$result == "Passed") {
      color <- crayon::green
      result <- "Poprawny!"
    } else {
      color <- crayon::red
      result <- "Niepoprawny!"
      if (data_row$is_obligate) {
        additional_info <- " Reguła kluczowa do przeprowadzenia dalszej walidacji."
      }
    }
    cat(data_row$title, ". Wynik walidacji: ", color(result), additional_info, "\n", sep = "")
  }

  purrr::walk(1:nrow(validation_result), ~ disp_summary(validation_result[., ]))
}

validator <- Validator$new()
