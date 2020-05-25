source("server/implementation/irrigation.R")

output$plot5 = renderPlot({
  
  df() %>%
    yield_irrigation()
  
}, width = 500)