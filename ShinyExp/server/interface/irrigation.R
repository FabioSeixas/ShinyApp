source("server/implementation/irrigation.R")

observeEvent(input$file, {
  shinyjs::show("result-container")
})

output$plot5 = renderPlot({
  
  df() %>%
    yield_irrigation()
  
}, width = 500)