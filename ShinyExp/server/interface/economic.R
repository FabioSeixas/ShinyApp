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

### Water Applied and Efficiency

output$waterAppliedPlot = renderPlot({
  
  df_economic() %>%
    water_applied_plot()
  
}, width = 350, height = 500)

output$waterEficPlot = renderPlot({
  
  df_economic() %>%
    water_efic_plot()
  
}, width = 350, height = 500)


### Gross Margins and Cost-Benefit Relation

output$grossMarginPlot = renderPlot({
  
  df_economic() %>%
    gross_margin_plot()
  
}, width = 350, height = 500)


output$econRelationPlot = renderPlot({
  
  df_economic() %>%
    margin_costs_rel_plot()
  
}, width = 350, height = 500)


# Inputs for specific Planting Months and Cycle Lengths

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


output$econCostsPlot = renderPlot({
  
  df_econ_filtered() %>%
    econ_costs_plot()
  
}, width = 500, height = 400)


output$econResultsPlot = renderPlot({
  
  df_econ_filtered() %>%
    econ_results_plot()
  
}, width = 500, height = 400)


output$econPercent = renderPrint({
  
  (sum(df_econ_filtered()$resultado) / nrow(df_econ_filtered())) * 100 -> value
  
  sym(paste(round(value, 2), "%"))
  
})


output$econSecurityPlot = renderPlot({
  
  df_econ_filtered() %>%
    security_plot()
  
}, width = 500, height = 400)

