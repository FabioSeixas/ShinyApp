

evapo_new_columns = function(x){
  
  x %>%
    group_by(Pyear,
             PMonth = lubridate::month(PDate_norm,
                                       label = T),
             DATE) %>%
    summarise(DAP = mean(DAP),
              soil_water = mean(SWXD),
              pot_eto = mean(EOAA),
              avg_eto = mean(ETAA),
              pot_transp = mean(EOPA),
              avg_transp = mean(EPAA))
}

