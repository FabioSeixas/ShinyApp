
general_plot = function(x){
  
  x %>%
    filter(cycle_w > 32 & cycle_w < 52) %>%
    ggplot(aes(PDate_norm, HWAM, group = PDate_norm)) +
    geom_boxplot(outlier.shape = NA) +
    geom_jitter(alpha = 0.1) +
    facet_wrap(~cycle_m, ncol = 1,
               labeller = labeller(cycle_m = c("8" = "8 Months",
                                               "9" = "9 Months",
                                               "10" = "10 Months",
                                               "11" = "11 Months",
                                               "12" = "12 Months"))) +
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


above_5000 = function(x){
  
  final = c()
  
  for(i in (1:length(x))){
    
    if(x[i] > 5000){
      final = c(final, i)
    }
  }
  return((length(final) / length(x)) * 100)
}


above_7500 = function(x){
  
  final = c()
  
  for(i in (1:length(x))){
    
    if(x[i] > 7500){
      final = c(final, i)
    }
  }
  return((length(final) / length(x)) * 100)
}

above_10000 = function(x){
  
  final = c()
  
  for(i in (1:length(x))){
    
    if(x[i] > 10000){
      final = c(final, i)
    }
  }
  return((length(final) / length(x)) * 100)
}

probabilities_table = function(x){
  
  x %>%
    filter(cycle_w > 32 & cycle_w < 52) %>%
    filter(cycle_m %in% c(8, 12)) %>%
    group_by(Month = month(PDate_norm,
                           label = T),
             "Cycle Length" = cycle_m) %>%
    summarise("Above 5t/ha (%)" = above_5000(HWAM),
              "Above 7.5t/ha (%)" = above_7500(HWAM),
              "Above 10t/ha (%)" = above_10000(HWAM))
  
}