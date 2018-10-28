source("utils.R")

tramwaje <- jsonlite::fromJSON("data/tramwaje.json")[[1]]

tramwaje %>%
  verify(title = "Zbiór danych zawiera 8 kolumn",
         ncol(.) == 8, mark_data_corrupted_on_failure = TRUE) %>%
  assert(title = "Zmienna 'Time' jest formatu 'yyyy-mm-dd HH:MM:SS'",
         check_datetime_format, Time) %>%
  assert(title = "Dane nie są starsze niż 5 minut",
         check_data_last_5min, Time) %>%
  assert(title = "Długość geograficzna jest w granicach Warszawy",
         check_lat_in_warsaw, Lat) %>%
  assert(title = "Szerokosć geograficzna jest w granicach Warszawy",
         check_lon_in_warsaw, Lon) %>%
  validator$add_validations("tramwaje")

validator$get_validations(type = "data.frame") %>%
  sum_up()
