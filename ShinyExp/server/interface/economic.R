source("server/implementation/economic.R")


observeEvent(input$readfile, {
  shinyjs::show(selector = "div.result-container")
})


df_economic = reactive({
  
  df() %>%
    economic_columns()
  
})

output$plot6 = renderPlot({
  
  df_economic() %>%
    econ_results_plot()
  
})

