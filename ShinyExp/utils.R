library(tidyverse)
library(lubridate)


make_norm_date = function(x){
  
  month = lubridate::month(x)
  
  if(lubridate::day(x) < 15){
    day = 1
  }
  else{
    day = 15
  }
  
  if(month < 3){
    
    return(lubridate::make_date(year = "2021",
                                month = month,
                                day = day))
  }
  
  return(lubridate::make_date(year = "2020",
                              month = month,
                              day = day))
  
}


set_Pyear = function(date){
  
  if(lubridate::month(date) < 3){
    return(lubridate::year(date) - 1)
  }
  return(lubridate::year(date))
}

new_column = function(x){
  
  x %>%
    group_by(TRAT, RUN) %>%
    filter(DAP == 0) %>%
    select(DATE) %>%
    mutate(PDate_norm = map(DATE, make_norm_date),
           Pyear = set_Pyear(DATE)) %>%
    unnest(cols = PDate_norm) %>%
    select(PDate_norm, Pyear) %>%
    left_join(x, by = c("TRAT", "RUN"))
  
}

