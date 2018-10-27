library(readr)
library(assertr)
library(dplyr)
listaZnakowTowarowych <- read_delim("data/2018_10_26_listaZnakowTowarowych.csv", ";", escape_double = FALSE, trim_ws = TRUE)

validator <- Validator$new()

listaZnakowTowarowych %>%
  chain_start() %>%
  verify(title = "Zmienna 'Data_Zgloszenia' posiada klasę 'Date'",
         class(Data_Zgloszenia) == "Date") %>%
  verify(title = "Zmienna 'Data_Publikacji_BUP' posiada klasę 'Date'",
         class(Data_Publikacji_BUP) == "Date") %>%
  verify(title = "Zmienna 'Data_Publikacji_WUP' posiada klasę 'Date'",
         class(Data_Publikacji_WUP) == "Date") %>%
  validator$add_validations(., "listaZnakowTowarowych")
