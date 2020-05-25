
general_plot = function(x){
  
  x %>%
    filter(DAP %in% c(240, 270, 300, 330, 360)) %>%
    group_by(PDate_norm) %>%
    select(DAP, HWAD) %>%
    ggplot(aes(PDate_norm, HWAD, group = PDate_norm)) +
    geom_boxplot(outlier.shape = NA) +
    facet_wrap(~DAP, ncol = 1,
               labeller = labeller(DAP = c("240" = "8 Months",
                                           "270" = "9 Months",
                                           "300" = "10 Months",
                                           "330" = "11 Months",
                                           "360" = "12 Months"))) +
    scale_x_date(labels = function(x) month(x, label = T, 
                                            locale = "US"),
                 name = "Planting Date") +
    labs(y = "Dry Matter Yield (kg/ha)",
         x = "Planting Date") +
    scale_y_continuous(labels = scales::comma,
                       breaks = seq(0, 30500, by = 3000)) +
    theme_bw() +
    theme(legend.key.size = unit(15, unit = "mm"))
}



prob_plot = function(x, Pmonth){
  
  x %>%
    filter(DAP %in% c(240, 270, 300, 330, 360),
           lubridate::month(PDate_norm,
                            label = T) %in% Pmonth) %>%
    mutate(PMonth = lubridate::month(PDate_norm, label = T)) %>%
    ggplot(aes(HWAD, fill = PMonth)) +
    geom_density(color = "black") +
    facet_wrap(~DAP, ncol = 1,
               labeller = labeller(DAP = c("240" = "8 Months",
                                           "270" = "9 Months",
                                           "300" = "10 Months",
                                           "330" = "11 Months",
                                           "360" = "12 Months"))) +
    labs(y = "",
         x = "Dry Matter Yield (kg/ha)") +
    scale_x_continuous(labels = scales::comma,
                       breaks = seq(0, 30500, by = 2000)) +
    scale_fill_manual(name = "Month",
                      values = RColorBrewer::brewer.pal(name = "Set1", 
                                                        n = length(Pmonth))) +
    theme_bw() +
    theme(axis.text.y = element_blank())
}


prob_table = function(x, Pmonth){
  
  x %>%
    filter(DAP %in% c(240, 270, 300, 330, 360),
           lubridate::month(PDate_norm,
                            label = T) %in% Pmonth) %>%
    group_by(PMonth = lubridate::month(PDate_norm, label = T)) %>%
    summarise("0%" = quantile(HWAD)[1],
              "25%" = quantile(HWAD)[2],
              "50%" = quantile(HWAD)[3],
              "75%" = quantile(HWAD)[4],
              "100%" = quantile(HWAD)[5]) %>%
    pivot_longer(cols = -c(PMonth)) %>%
    pivot_wider(id_cols = c(name, PMonth),
                names_from = PMonth) %>%
    rename("Quantile" = name)
  
}