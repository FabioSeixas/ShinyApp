

growth_new_columns = function(x){
  
  x %>%
    group_by(Pyear,
             PMonth = lubridate::month(PDate_norm,
                                       label = T),
             DATE) %>%
    summarise(DAP = mean(DAP),
              Tmean = mean(TMEAN),
              soil_water = mean(SWXD),
              water_photo = mean(WFPD),
              water_grow = mean(WFGD),
              temp_photo = mean(TFPD),
              temp_grow = mean(TFGD),
              ass_prod = mean(AWAD),
              nodes = mean(`L#SD`),
              lai = mean(LAID),
              canopy = mean(CWAD),
              radiation = mean(SRAA))
              
}

