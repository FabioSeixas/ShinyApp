source("server/implementation/irrigation.R")

observeEvent(input$readfile, {
  shinyjs::show("result-container")
})

output$plot5 = renderPlot({
  
  df() %>%
    yield_irrigation()
  
}, width = 500)