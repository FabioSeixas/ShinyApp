

yield_prec = function(x){
  
  x %>%
    filter(cycle_w > 32 & cycle_w < 52) %>%
    ggplot(aes(PRCM, HWAM, color = as.factor(month(PDate_norm,
                                                   label = T)))) +
    geom_point(alpha = 0.7, shape = 21) +
    geom_smooth(method = "lm", se = F) +
    labs(y = "Dry Matter Yield (kg/ha)",
         x = "Cumulative Precipitation (mm)") +
    scale_y_continuous(labels = scales::comma,
                       breaks = seq(0, 30500, by = 2000)) +
    scale_x_continuous(labels = scales::comma,
                       breaks = seq(0, 30500, by = 500)) +
    ggsci::scale_color_locuszoom(name = "Planting Months") +
    theme_bw()
  
}

mean_cum_prec = function(x){
  
  subtitle = sim_start(x)
  
  x %>%
    filter(cycle_w > 32 & cycle_w < 52) %>%
    group_by(Date = month(PDate_norm, label = T)) %>%
    summarise(MeanPrec = mean(PRCM)) %>%
    ggplot(aes(Date, MeanPrec)) +
    geom_col(fill = "blue", color = "black") +
    labs(y = "Mean Cumulative Precipitation (mm)",
         x = "Planting Month",
         subtitle = paste0(subtitle, ". Averaged over all cycle lengths.")) +
    scale_y_continuous(labels = scales::comma,
                       breaks = seq(0, 3000, by = 300)) +
    theme_bw()
  
}