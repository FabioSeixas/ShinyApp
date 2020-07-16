source("server/implementation/economic.R")


observeEvent(input$readfile, {
  shinyjs::show(selector = "div.row")
})

observeEvent(input$readfile, {
  shinyjs::show("dailyInputs")
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



econ_select_month = reactive({
  
  req(input$econ_select_month)
  
  input$econ_select_month
  
})

econ_select_cycle = reactive({
  
  req(input$econ_select_cycle)
  
  dict = c("8" = 240,
           "9" = 270,
           "10" = 300,
           "11" = 330,
           "12" = 360)
  
  dict[input$econ_select_cycle]
  
})

df_econ_filtered = reactive({
  
  df() %>%
    pull(PDate_norm) %>% 
    lubridate::month(label = T) %>%
    unique() -> valid_months
  
  validate(
    need(econ_select_month() %in% valid_months,
         paste0("'", econ_select_month(), "'",
                " is not an available planting month for the current data"))
  )
  
  df_economic() %>%
    economic_columns() %>%
    filter(PMonth %in% econ_select_month(),
           DAP %in% econ_select_cycle())
  
})

yieldThreshold = reactive({
  
  df_econ_filtered() %>%
    pull(custo_ha) %>%
    mean() -> custo_ha
  
  round(custo_ha / 320, 1)
  
})


output$econResultsPlot = renderPlot({
  
  df_econ_filtered() %>%
    econ_results_plot()
  
}, width = 500, height = 400)


output$yieldThresholdFirst = renderPrint({
  
  # R$ 7446 / 320 (R$/ton) = 23.26
  sym(paste(yieldThreshold() + 23.26, "ton/ha"))
  
})

output$yieldThreshold = renderPrint({
  
  sym(paste(yieldThreshold(), "ton/ha"))
  
})

output$econPercent = renderPrint({
  
  (sum(df_econ_filtered()$resultado) / nrow(df_econ_filtered())) * 100 -> value
  
  sym(paste(round(value, 2), "%"))
  
})


df_econ_security = reactive({
  
  df_econ_filtered() %>%
    security_columns(yieldThreshold())
  
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


