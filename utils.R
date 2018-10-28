library(readr)
library(assertr)
library(dplyr)

common_date_format <- "%Y-%m-%d"

check_date_format <- function(date) {
  tryCatch(!is.na(as.Date(date, common_date_format)),
    error = function(err) {FALSE})
}
attr(check_date_format,"assertr_vectorized") <- TRUE

sum_up <- function(validation_result) {
  disp_summary <- function(data_row) {
    if (data_row$result == "Passed") {
      color <- crayon::green
      result <- "Poprawny!"
    } else {
      color <- crayon::red
      result <- "Niepoprawny!"
    }
    cat(data_row$title, ". Wynik walidacji: ", color(result), "\n", sep = "")
  }

  purrr::walk(1:nrow(validation_result), ~ disp_summary(validation_result[., ]))
}

validator <- Validator$new()

