source("server/implementation/yield.R")

yield_sel_year = reactive({
  
  req(input$yield_sel_year)
  
  input$yield_sel_year
  
})

df_yield = reactive({
  
  df() %>%
    filter(Pyear %in% yield_sel_year()) %>%
    yield_new_columns()
  
})

output$yieldTable = renderTable({
  
  df() %>%
    filter(Pyear %in% yield_sel_year()) %>%
    yield_table()
  
})

output$yieldPlot = renderPlot({
  
  df() %>%
    pull(DATE) %>% 
    lubridate::year() %>%
    unique() -> valid_years
  
  validate(
    need(yield_sel_year() %in% valid_years,
         paste0("'", yield_sel_year(), "'",
                " is not an available year for the current data"))
  )
  
  df_yield() %>%
    yield_plot()
  
}, width = 800, height = 400)


output$yieldWaterPlot = renderPlot({
  
  df_yield() %>%
    yield_water_plot()
  
}, width = 800, height = 400)