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
  
  return(lubridate::make_date(year = "2020",
                              month = month,
                              day = day))
}


new_column = function(x){
  
  x %>%
    group_by(TRAT, RUN) %>%
    filter(DAP == 0) %>%
    select(DATE) %>%
    mutate(PDate_norm = map(DATE, make_norm_date)) %>%
    unnest(cols = PDate_norm) %>%
    select(PDate_norm) %>%
    left_join(x, by = c("TRAT", "RUN"))
  
}

# new_columns = function(df){
#   
#   df %>%
#     mutate(PDOY = yday(PDAT),
#            HDOY = yday(HDAT),
#            cycle_w = difftime(HDAT, PDAT, units = "weeks"),
#            cycle_m = floor(as.integer(cycle_w) / 4),
#            PDate_norm = as.Date('2020-01-01') + (PDOY - 1) + 1) -> df
#   
#   return(df)
# }


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

