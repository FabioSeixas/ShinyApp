source("server/implementation/economic.R")


observeEvent(input$readfile, {
  shinyjs::show(selector = "div.row")
})


df_economic = reactive({
  
  df() %>%
    economic_columns()
  
})

output$grossMarginPlot = renderPlot({
  
  df_economic() %>%
    gross_margin_plot()
  
}, width = 350, height = 500)


output$econRelationPlot = renderPlot({
  
  df_economic() %>%
    margin_costs_rel_plot()
  
}, width = 350, height = 500)


output$econResultsPlot = renderPlot({
  
  df_economic() %>%
    econ_results_plot()
  
}, width = 500, height = 400)



output$yieldThreshold = renderPrint({
  
  df_economic() %>%
    filter(margem_bruta > 0) %>%
    pull(yield_FW_ton) %>%
    min() -> value
  
  sym(paste(value, "ton/ha"))
  
})

output$econPercent = renderPrint({
  
  (sum(df_economic()$resultado) / nrow(df_economic())) * 100 -> value
  
  sym(paste(round(value, 2), "%"))
  
})


df_econ_security = reactive({
  
  req(df_economic())
  
  df_economic() %>%
    security_columns()
  
})


output$econSecurityPlot = renderPlot({
  
  df_econ_security() %>%
    econ_security_plot()
  
}, width = 500, height = 400)


output$econSecurityText10 = renderPrint({
  
  df_econ_security() %>%
    security_percent_above(0.1)
  
})


output$econSecurityText30 = renderPrint({
  
  df_econ_security() %>%
    security_percent_above(0.3)
  
})


output$econSecurityText50 = renderPrint({
  
  df_econ_security() %>%
    security_percent_above(0.5)
  
})


