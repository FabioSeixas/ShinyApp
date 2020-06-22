
yield_new_columns = function(x){
  
  x %>%
    group_by(Pyear,
             PMonth = lubridate::month(PDate_norm,
                                       label = T),
             DATE) %>%
    summarise(DAP = mean(DAP),
              Tmean = mean(TMEAN),
              yield = mean(HWAD),
              soil_water = mean(SWXD),
              water_photo = mean(WFPD),
              water_grow = mean(WFGD),
              temp_photo = mean(TFPD),
              temp_grow = mean(TFGD),
              harv_index = mean(HIAD),
              radiation = mean(SRAA))
}

