source("server/implementation/irrigation.R")

observeEvent(input$readfile, {
  shinyjs::show(selector = "div.plot-container.sum")
})

output$plot5 = renderPlot({
  
  df() %>%
    yield_irrigation()
  
}, width = 500)