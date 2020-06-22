source("server/implementation/growth.R")
source("server/implementation/daily_plots.R")

observeEvent(input$readfile, {
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

daily_select_month = reactive({
  
  req(input$daily_select_month)
  
  input$daily_select_month
  
})

df_growth = reactive({
  
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
    growth_new_columns() %>%
    filter(PMonth %in% daily_select_month())
  
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
    var_plot("canopy", 
             "Canopy Dry Matter (kg/ha)",
             "Canopy Weight over Time")
  
}, width = 800, height = 500)


output$growthWaterPlot = renderPlot({
  
  df_growth() %>%
    var_water_plot("canopy", 
                   "Canopy Dry Matter (kg/ha)",
                   "Canopy x Extractable Water")
  
}, width = 800, height = 500)


output$growthWaterPhotoPlot = renderPlot({
  
  df_growth() %>%
    var_water_photo_plot("canopy", 
                         "Canopy Dry Matter (kg/ha)",
                         "Canopy x Water Factor for Photosynthesis")
  
}, width = 800, height = 500)


output$growthWaterGrowthPlot = renderPlot({
  
  df_growth() %>%
    var_water_growth_plot("canopy", 
                          "Canopy Dry Matter (kg/ha)",
                          "Canopy x Water Factor for Growth")
  
}, width = 800, height = 500)


output$growthTempPlot = renderPlot({
  
  df_growth() %>%
    var_temp_plot("canopy",
                  "Canopy Dry Matter (kg/ha)",
                  "Canopy x Temperature")
  
}, width = 800, height = 500)


output$growthTempPhotoPlot = renderPlot({
  
  df_growth() %>%
    var_temp_photo_plot("canopy",
                        "Canopy Dry Matter (kg/ha)",
                        "Canopy x Temperature Factor for Photosynthesis")
  
}, width = 800, height = 500)


output$growthTempGrowthPlot = renderPlot({
  
  df_growth() %>%
    var_temp_growth_plot("canopy", 
                         "Canopy Dry Matter (kg/ha)",
                         "Canopy x Temperature Factor for Growth")
  
}, width = 800, height = 500)


output$growthRadPlot = renderPlot({
  
  df_growth() %>%
    var_rad_plot("canopy",
                 "Canopy Dry Matter (kg/ha)",
                 "Canopy x Radiation")
  
}, width = 800, height = 500)


output$LaiPlot = renderPlot({
  
  df_growth() %>%
    var_plot("lai",
             "Leaf Area Index",
             "Leaf Area Index",
             seq = seq(0, 10, 0.5))
  
}, width = 800, height = 500)


output$assProdPlot = renderPlot({
  
  df_growth() %>%
    var_plot("ass_prod",
             "Assimilate Production (kg/ha/day)",
             "Assimilate Production",
             seq = seq(0, 30500, by = 25))
  
}, width = 800, height = 500)


output$nodesPlot = renderPlot({
  
  df_growth() %>%
    var_plot("nodes",
             "Total Nodes number (Leafs + Scars)",
             "Total Nodes number",
             seq = seq(0, 30500, by = 50))
  
}, width = 800, height = 500)