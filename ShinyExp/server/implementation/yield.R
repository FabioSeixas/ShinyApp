
yield_new_columns = function(x){
  
  x %>%
    group_by(Pyear,
             PMonth = lubridate::month(PDate_norm,
                                       label = T),
             DATE) %>%
    summarise(Tmean = mean(TMEAN),
              yield = mean(HWAD),
              soil_water = mean(SWXD),
              water_photo = mean(WFPD),
              water_grow = mean(WFGD),
              temp_photo = mean(TFPD),
              temp_grow = mean(TFGD),
              harv_index = mean(HIAD))
}

# 
# yield_table = function(x){
#   
#   x %>%
#     filter(DAP %in% c(240, 270, 300, 330, 360)) %>%
#     group_by(Pyear,
#              PDate_norm) %>%
#     summarise(yield = mean(HWAD, na.rm = T)) %>%
#     rename("Date" = PDate_norm,
#            "Year" = Pyear) %>%
#     ungroup() %>%
#     mutate(Date = format(Date, "%b %d"),
#            Year = as.integer(Year)) %>%
#     pivot_wider(id_cols = Year, names_from = Date, 
#                 values_from = yield)
#   
#   
# }
