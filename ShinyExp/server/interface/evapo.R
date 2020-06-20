source("server/implementation/evapo.R")
source("server/implementation/daily_plots.R")

observeEvent(input$file, {
  shinyjs::show(id = "evapo_panel")
})

observeEvent(input$daily_select_year, {
  if(!is.null(input$daily_select_year)){
    shinyjs::show(selector = "div.PlotsContainer")}
  else if(is.null(input$daily_select_year)){
    shinyjs::hide(selector = "div.PlotsContainer")
  }
}, ignoreNULL = FALSE)



daily_select_year = reactive({
  
  req(input$daily_select_year)
  
  input$daily_select_year
  
})

daily_select_month = reactive({
  
  req(input$daily_select_month)
  
  input$daily_select_month
  
})

df_evapo = reactive({
  
  df() %>%
    pull(PDate_norm) %>% 
    lubridate::month(label = T) %>%
    unique() -> valid_months
  
  validate(
    need(daily_select_month() %in% valid_months,
         paste0("'", daily_select_month(), "'",
                " is not an available planting month for the current data"))
  )
  
  df() %>%
    filter(Pyear %in% daily_select_year()) %>%
    evapo_new_columns() %>%
    filter(PMonth %in% daily_select_month())
  
})


output$PotETOPlot = renderPlot({
  
  df() %>%
    pull(DATE) %>% 
    lubridate::year() %>%
    unique() -> valid_years
  
  validate(
    need(daily_select_year() %in% valid_years,
         paste0("'", daily_select_year(), "'",
                " is not an available year for the current data"))
  )
  
  df_evapo() %>%
    var_plot("pot_eto", 
             "Potential Evapotranspiration (mm/day)",
             "Potential Evapotranspiration",
             seq = seq(0, 20, by = 1))
  
}, width = 800, height = 500)



output$AvgETOPlot = renderPlot({
  
  df_evapo() %>%
    var_plot("avg_eto", 
             "Average Evapotranspiration (mm/day)",
             "Average Evapotranspiration",
             seq = seq(0, 20, by = 1))
  
}, width = 800, height = 500)


output$PotTranspPlot = renderPlot({
  
  df_evapo() %>%
    var_plot("pot_transp", 
             "Potential Transpiration (mm/day)",
             "Potential Transpiration",
             seq = seq(0, 20, by = 1))
  
}, width = 800, height = 500)


output$AvgTranspPlot = renderPlot({
  
  df_evapo() %>%
    var_plot("avg_transp", 
             "Average Transpiration (mm/day)",
             "Average Transpiration",
             seq = seq(0, 20, by = 1))
  
}, width = 800, height = 500)