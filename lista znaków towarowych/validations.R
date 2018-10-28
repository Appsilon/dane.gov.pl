source("utils.R")

listaZnakowTowarowych <- read_delim("lista znaków towarowych/2018_10_26_listaZnakowTowarowych_demo_2.csv", ";",
                                    escape_double = FALSE,
                                    col_types = cols(.default = col_character()))

listaZnakowTowarowych %>%
  verify(title = "Zbiór danych zawiera 16 kolumn",
         ncol(.) == 16, mark_data_corrupted_on_failure = TRUE) %>%
  assert(title = "Zmienna 'Data_Zgloszenia' jest formatu 'yyyy-mm-dd'",
         check_date_format, Data_Zgloszenia) %>%
  assert(title = "Zmienna 'Data_Publikacji_BUP' jest formatu 'yyyy-mm-dd'",
         check_date_format, Data_Publikacji_BUP) %>%
  assert(title = "Zmienna 'Data_Publikacji_WUP' jest formatu 'yyyy-mm-dd'",
         check_date_format, Data_Publikacji_WUP) %>%
  validator$add_validations("listaZnakowTowarowych")

validator$get_validations(type = "data.frame") %>%
  sum_up()
