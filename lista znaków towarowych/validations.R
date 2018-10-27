library(readr)
library(assertr)
library(dplyr)
validator <- Validator$new()

listaZnakowTowarowych <- read_delim("data/2018_10_26_listaZnakowTowarowych.csv", ";", escape_double = FALSE, trim_ws = TRUE)

listaZnakowTowarowych %>%
  verify(title = "Zmienna 'Data_Zgloszenia' posiada klasę 'Date'",
         class(Data_Zgloszenia) == "Date") %>%
  verify(title = "Zmienna 'Data_Publikacji_BUP' posiada klasę 'Date'",
         class(Data_Publikacji_BUP) == "Date") %>%
  verify(title = "Zmienna 'Data_Publikacji_WUP' posiada klasę 'Date'",
         class(Data_Publikacji_WUP) == "Date") %>%
  validator$add_validations("listaZnakowTowarowych")

validator$get_validations(type = "json")
