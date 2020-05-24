
yield_irrigation = function(x){
  
  x %>%
    filter(cycle_w > 32 & cycle_w < 52) %>%
    ggplot(aes(IRCM, HWAM)) +
    geom_point(alpha = 0.3) +
    geom_smooth(method = "lm", se = F) +
    labs(x = "Cumulative Irrigation (mm)",
         y = "Dry Matter Yield (kg/ha)") +
    scale_y_continuous(labels = scales::comma,
                       breaks = seq(0, 20000, by = 3000)) +
    theme_bw()
  
}