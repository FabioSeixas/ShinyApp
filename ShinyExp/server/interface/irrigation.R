source("server/implementation/irrigation.R")

observeEvent(input$file, {
  shinyjs::toggle("irrig_panel")
})

output$plot5 = renderPlot({
  
  df() %>%
    yield_irrigation()
  
}, width = 500)