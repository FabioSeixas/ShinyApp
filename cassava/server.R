server <- function(input, output) {
  
  df = reactive({
    
    req(input$file)
    
    read_csv(input$file$datapath) %>%
      new_columns()
    
    
  })
  
  output$plot1 = renderPlot({
    
    df() %>%
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
                         breaks = seq(0, 30500, by = 4000)) +
      theme_bw() +
      theme(legend.key.size = unit(15, unit = "mm"))
    
  }, width = 500, height = 500)
  
  
  output$table1 = renderTable({
    
    df() %>%
      filter(cycle_w > 32 & cycle_w < 52) %>%
      group_by(Date = PDate_norm) %>%
      summarise("Successful Germinations" = n()) %>%
      mutate(Date = format(Date, "%B %d"))
  })
  
  
  output$plot2 = renderPlot({
    
    color = RColorBrewer::brewer.pal(name = "Set1", 
                                     n = 1)
    
    df() %>%
      filter((cycle_w < 5) & 
               (TRNO %in% useful_treatments(df()))) -> x
    
    max = x %>%
      group_by(Date = PDate_norm) %>%
      summarise(count = n()) %>% 
      pull(count) %>% 
      max()
    
    x %>% 
      ggplot(aes(PDate_norm)) +
      geom_histogram(fill = color[1], color = "black") +
      labs(y = "Germination fails frequency",
           x = "Planting Date") +
      scale_y_continuous(breaks = seq(0, 1000, by = ceiling(max / 4))) +
      theme_bw()
    
  }, width = 300)
  
  output$plot3 = renderPlot({
    
    df() %>%
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
    
  }, width = 500)
  
  output$plot4 = renderPlot({
    
    subtitle = sim_start(df())
    
    df() %>%
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
  }, width = 500)
  
  output$plot5 = renderPlot({
    
    df() %>%
      filter(cycle_w > 32 & cycle_w < 52) %>%
      ggplot(aes(IRCM, HWAM)) +
      geom_point(alpha = 0.3) +
      geom_smooth(method = "lm", se = F) +
      labs(x = "Cumulative Irrigation (mm)",
           y = "Dry Matter Yield (kg/ha)") +
      scale_y_continuous(labels = scales::comma,
                         breaks = seq(0, 20000, by = 3000)) +
      theme_bw()
    
  }, width = 500)
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
}
