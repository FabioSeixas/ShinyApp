source("server/implementation/growth.R")
source("server/implementation/daily_plots.R")

observeEvent(input$file, {
  shinyjs::show(id = "growth_panel")
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

df_growth = reactive({
  
  df() %>%
    filter(Pyear %in% daily_select_year()) %>%
    growth_new_columns()
  
})


output$growthPlot = renderPlot({
  
  df() %>%
    pull(DATE) %>% 
    lubridate::year() %>%
    unique() -> valid_years
  
  validate(
    need(daily_select_year() %in% valid_years,
         paste0("'", daily_select_year(), "'",
                " is not an available year for the current data"))
  )
  
  df_growth() %>%
    var_plot("canopy", "Canopy Dry Matter (kg/ha)")
  
}, width = 800, height = 400)


output$growthWaterPlot = renderPlot({
  
  df_growth() %>%
    var_water_plot("canopy", "Canopy Dry Matter (kg/ha)")
  
}, width = 800, height = 400)


output$growthWaterPhotoPlot = renderPlot({
  
  df_growth() %>%
    var_water_photo_plot("canopy", "Canopy Dry Matter (kg/ha)")
  
}, width = 800, height = 400)


output$growthWaterGrowthPlot = renderPlot({
  
  df_growth() %>%
    var_water_growth_plot("canopy", "Canopy Dry Matter (kg/ha)")
  
}, width = 800, height = 400)

output$growthTempPhotoPlot = renderPlot({
  
  df_growth() %>%
    var_temp_photo_plot("canopy", "Canopy Dry Matter (kg/ha)")
  
}, width = 800, height = 400)


output$growthTempGrowthPlot = renderPlot({
  
  df_growth() %>%
    var_temp_growth_plot("canopy", "Canopy Dry Matter (kg/ha)")
  
}, width = 800, height = 400)