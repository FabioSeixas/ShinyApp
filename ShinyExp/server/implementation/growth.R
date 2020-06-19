

growth_new_columns = function(x){
  
  x %>%
    group_by(Pyear,
             PMonth = lubridate::month(PDate_norm,
                                       label = T),
             DATE) %>%
    summarise(soil_water = mean(SWXD),
              water_photo = mean(WFPD),
              water_grow = mean(WFGD),
              temp_photo = mean(TFPD),
              temp_grow = mean(TFGD),
              ass_prod = mean(AWAD),
              nos = mean(`L#SD`),
              lai = mean(LAID),
              canopy = mean(CWAD),
              radiation = mean(SRAA),
              harv_index = mean(HIAD))
              
}