
yield_new_columns = function(x){
  
  x %>%
    group_by(Pyear,
             PMonth = lubridate::month(PDate_norm,
                                       label = T),
             DATE) %>%
    summarise(yield = mean(HWAD),
              soil_water = mean(SWXD),
              water_photo = mean(WFPD),
              water_grow = mean(WFGD),
              temp_photo = mean(TFPD),
              temp_grow = mean(TFGD),
              ass_prod = mean(AWAD),
              rain = mean(PREC),
              irrig = mean(IRRC))
}


yield_table = function(x){
  
  x %>%
    filter(DAP %in% c(240, 270, 300, 330, 360)) %>%
    group_by(Pyear,
             PDate_norm) %>%
    summarise(yield = mean(HWAD, na.rm = T)) %>%
    rename("Date" = PDate_norm,
           "Year" = Pyear) %>%
    ungroup() %>%
    mutate(Date = format(Date, "%b %d"),
           Year = as.integer(Year)) %>%
    pivot_wider(id_cols = Year, names_from = Date, 
                values_from = yield)
  
  
}

yield_plot = function(x){
  
  x %>%
    ggplot(aes(DATE, yield, color = PMonth)) +
    geom_line() +
    facet_wrap(~Pyear, ncol = 2,
               scales = "free_x") +
    scale_x_date(labels = function(x) month(x, label = T, 
                                            locale = "US"),
                 date_breaks = "2 month",
                 name = "Date") +
    scale_y_continuous(name = "Dry Matter Yield (kg/ha)",
                       labels = scales::comma,
                       breaks = seq(0, 30500, by = 2000)) +
    scale_color_manual(values = RColorBrewer::brewer.pal(name = "Set1", 
                                                         n = 8),
                       name = "Planting Month") +
    theme_bw() +
    theme(axis.title.y = element_text(size = 11, vjust = 3),
          axis.title.y.right = element_text(size = 11, 
                                            vjust = -2,
                                            angle = 90),
          axis.title.x = element_text(size = 11, vjust = -3),
          axis.text = element_text(size = 11),
          legend.text = element_text(size = 11),
          legend.position = "bottom",
          legend.title.align = 0.5,
          legend.title = element_text(face = "bold", size = 11),
          strip.text = element_text(size = 11))
  
  
}

yield_water_plot = function(x){
  
  x %>% 
    ggplot(aes(DATE, yield, color = PMonth)) +
    geom_line() +
    geom_line(aes(DATE, soil_water * 50, group = PMonth), 
              color = "blue", alpha = 0.2) +
    facet_wrap(~Pyear, ncol = 2,
               scales = "free_x") +
    scale_x_date(labels = function(x) month(x, label = T, 
                                            locale = "US"),
                 date_breaks = "2 month",
                 name = "Date") +
    scale_y_continuous(name = "Dry Matter Yield (kg/ha)",
                       labels = scales::comma,
                       breaks = seq(0, 30500, by = 2000),
                       sec.axis = sec_axis(~. / 50,
                                           name = expression(Soil~Extractable~Water~(mm)),
                                           breaks = seq(0, 1000, by = 50))) +
    scale_color_manual(values = RColorBrewer::brewer.pal(name = "Set1", 
                                                         n = 8),
                       name = "Planting Month") +
    theme_bw() +
    theme(axis.title.y = element_text(size = 11, vjust = 3),
          axis.title.y.right = element_text(size = 11, 
                                            vjust = -2,
                                            angle = 90),
          axis.title.x = element_text(size = 11, vjust = -3),
          axis.text = element_text(size = 11),
          legend.text = element_text(size = 11),
          legend.position = "bottom",
          legend.title.align = 0.5,
          legend.title = element_text(face = "bold", size = 11),
          strip.text = element_text(size = 11))
  
}