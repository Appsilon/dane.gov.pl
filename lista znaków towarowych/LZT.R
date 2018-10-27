library(readr)
library(assertr)
library(dplyr)
listaZnakowTowarowych <- read_delim("data/2018_10_26_listaZnakowTowarowych.csv", ";", escape_double = FALSE, trim_ws = TRUE)

validator <- Validator$new()

listaZnakowTowarowych %>%
  chain_start() %>%
  verify(title = "Zmienne określające datę posiadają klasę 'Date'",
         v_class(Data_Zgloszenia, Data_Publikacji_BUP, Data_Publikacji_WUP) == "Date") %>%
  chain_end(error_fun = error_append) %>%
  validator$add_validations(., "listaZnakowTowarowych")
