source("server/implementation/precipitation.R")

output$plot3 = renderPlot({
  
  df() %>%
    yield_prec()
  
}, width = 400)


output$plot4 = renderPlot({
  
  df() %>%
    mean_cum_prec()
  
}, width = 400)
