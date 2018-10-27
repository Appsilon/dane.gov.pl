library(readr)
library(assertr)
library(dplyr)
listaZnakowTowarowych <- read_delim("data/2018_10_26_listaZnakowTowarowych.csv", ";", escape_double = FALSE, trim_ws = TRUE)

validator <- Validator$new()

validation_rules <- function(data) {
  data %>%
    chain_start() %>%
    verify(title = "Zmienna 'Data_Zgloszenia' posiada klasę 'Date'",
           v_class(Data_Zgloszenia) == "Date") %>%
    verify(title = "Zmienna 'Data_Publikacji_BUP' posiada klasę 'Date'",
           v_class(Data_Publikacji_BUP) == "Date") %>%
    verify(title = "Zmienna 'Data_Publikacji_WUP' posiada klasę 'Date'",
           v_class(Data_Publikacji_WUP) == "Date")
}

listaZnakowTowarowych %>%
  validation_rules() %>%
  validator$add_validations(., "listaZnakowTowarowych")
