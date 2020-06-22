

yield_prec = function(x){
  
  x %>%
    filter(DAP == 0) %>%
    mutate(initPREC = PREC) %>%
    select(initPREC) %>%
    right_join(x, by = c("TRAT", "RUN")) %>%
    filter(DAP %in% c(240, 270, 300, 330, 360)) %>%
    mutate(PREC = PREC - initPREC) %>%
    ggplot(aes(PREC, HWAD, 
               color = lubridate::month(PDate_norm,
                                        label = T))) +
    geom_point(alpha = 0.7, shape = 21) +
    geom_smooth(method = "lm", se = F) +
    labs(y = "Dry Matter Yield (kg/ha)",
         x = "Cumulative Precipitation (mm)") +
    scale_y_continuous(labels = scales::comma,
                       breaks = seq(0, 30500, by = 2000)) +
    scale_x_continuous(labels = scales::comma,
                       breaks = seq(0, 30500, by = 500)) +
    ggsci::scale_color_locuszoom(name = "Planting Months") +
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

mean_cum_prec = function(x){
  
  color = RColorBrewer::brewer.pal(name = "Set1", n = 1)
  
  x %>%
    filter(DAP == 0) %>%
    mutate(initPREC = PREC) %>%
    select(initPREC) %>%
    right_join(x, by = c("TRAT", "RUN")) %>%
    filter(DAP %in% c(240, 270, 300, 330, 360)) %>%
    mutate(PREC = PREC - initPREC) %>%
    group_by(Date = PDate_norm) %>%
    ggplot(aes(Date, PREC, group = Date)) +
    geom_boxplot(fill = color[2]) +
    labs(y = "Cumulative Precipitation (mm)",
         x = "Planting Date") +
    scale_y_continuous(labels = scales::comma,
                       breaks = seq(0, 3000, by = 300)) +
    scale_x_date(labels = function(x) month(x, label = T, 
                                            locale = "US"),
                 date_breaks = "1 month",
                 name = "Planting Date") +
    theme_bw()
  
}