source("server/implementation/yield.R")
source("server/implementation/daily_plots.R")

observeEvent(input$file, {
  shinyjs::show("yield_panel")
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

df_yield = reactive({
  
  df() %>%
    filter(Pyear %in% daily_select_year()) %>%
    yield_new_columns()
  
})

# output$yieldTable = renderTable({
#   
#   df() %>%
#     filter(Pyear %in% daily_select_year()) %>%
#     yield_table()
#   
# })

output$yieldPlot = renderPlot({
  
  df() %>%
    pull(DATE) %>% 
    lubridate::year() %>%
    unique() -> valid_years
  
  validate(
    need(daily_select_year() %in% valid_years,
         paste0("'", daily_select_year(), "'",
                " is not an available year for the current data"))
  )
  
  df_yield() %>%
    var_plot("yield", 
             "Dry Matter Yield (kg/ha)",
             "Yield over Time")
  
}, width = 800, height = 500)


output$yieldWaterPlot = renderPlot({
  
  df_yield() %>%
    var_water_plot("yield", 
                   "Dry Matter Yield (kg/ha)",
                   "Yield x Extractable Water")
  
}, width = 800, height = 500)


output$yieldWaterPhotoPlot = renderPlot({
  
  df_yield() %>%
    var_water_photo_plot("yield", 
                         "Dry Matter Yield (kg/ha)",
                         "Yield x Water Factor for Photosynthesis")
  
}, width = 800, height = 500)


output$yieldWaterGrowthPlot = renderPlot({
  
  df_yield() %>%
    var_water_growth_plot("yield", 
                          "Dry Matter Yield (kg/ha)",
                          "Yield x Water Factor for Growth")
  
}, width = 800, height = 500)


output$yieldTempPlot = renderPlot({
  
  df_yield() %>%
    var_temp_plot("yield",
                  "Dry Matter Yield (kg/ha)",
                  "Yield x Temperature")
  
}, width = 800, height = 500)


output$yieldTempPhotoPlot = renderPlot({
  
  df_yield() %>%
    var_temp_photo_plot("yield",
                        "Dry Matter Yield (kg/ha)",
                        "Yield x Temperature Factor for Photosynthesis")
  
}, width = 800, height = 500)


output$yieldTempGrowthPlot = renderPlot({
  
  df_yield() %>%
    var_temp_growth_plot("yield", 
                         "Dry Matter Yield (kg/ha)",
                         "Yield x Temperature Factor for Growth")
  
}, width = 800, height = 500)


output$harvIndexPlot = renderPlot({
  
  df_yield() %>%
    var_plot("harv_index",
             "Harvest Index",
             "Harvest Index",
             seq = seq(0, 10, 0.25))
  
}, width = 800, height = 500)