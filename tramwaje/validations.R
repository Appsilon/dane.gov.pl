source("utils.R")

api_url <- "https://api.um.warszawa.pl/api/action/wsstore_get/?id=c7238cfe-8b1f-4c38-bb4a-de386db7e776&apikey=f10fec28-bf17-4abd-94d7-7b42ac4ab33e"

tramwaje <- jsonlite::fromJSON(api_url)[[1]]

tramwaje %>%
  verify(title = "Każde pojedyncze zapytanie zwraca 8 wartości",
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
