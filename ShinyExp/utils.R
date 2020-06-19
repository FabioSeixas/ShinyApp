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

# Não funcionando
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


useful_treatments = function(df){
  treatments = c()
  
  for(n in unique(df$TRNO)){
  
      if(filter(df, TRNO == n & cycle_m > 7 & cycle_m < 13) %>%
       nrow() > 0){
        
      treatments = c(treatments, n)
    }
  }
  return(treatments)
}

sim_start = function(df){
  
  if((mutate(df, 
             diff = PDAT - SDAT) %>%
      pull(diff) %>% 
      sum()) == 0){
    
    return("Cumulative Precipitation since planting date")
  }
  else{
    return(paste0("Cumulative Precipitation since simulation start (", 
                      format(df$SDAT[1], "%b %d"),
                      ")"))
  }
}

