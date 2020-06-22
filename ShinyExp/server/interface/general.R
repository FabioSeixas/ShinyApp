source("server/implementation/general.R")


observeEvent(input$readfile, {
  shinyjs::show(selector = "div.row")
})

output$general_plot = renderPlot({
  
  df() %>% 
    general_plot()
  
}, width = 500, height = 500)


output$general_table = renderTable({
  
  df() %>%
    probabilities_table()
  
}, digits = 0)

# === Probability Section === #

prob_month = reactive({
  
  req(input$sum_prob_month)
  
  input$sum_prob_month
  
})

observeEvent(input$sum_prob_month, {
  
  if(is.null(input$sum_prob_month)){
    shinyjs::hide("mainPlotContainer")
  } else if (!is.null(input$sum_prob_month)){
      shinyjs::show("mainPlotContainer")
  }
}, ignoreNULL = FALSE)
  

output$prob_plot = renderPlot({
  
  df() %>%
    pull(PDate_norm) %>% 
    lubridate::month(label = T) %>%
    unique() -> valid_months
  
  validate(
    need(prob_month() %in% valid_months,
         paste0("'", prob_month(), "'",
                " is not an available planting month for the current data"))
  )
  
  df() %>%
    prob_plot(prob_month())
  
}, width = 400, height = 400)

output$prob_table = renderTable({
  
  df() %>%
    pull(PDate_norm) %>% 
    lubridate::month(label = T) %>%
    unique() -> valid_months
  
  validate(
    need(prob_month() %in% valid_months,
         paste0("'", prob_month(), "'",
                " is not an available planting month for the current data"))
  )
  
  df() %>%
    prob_table(prob_month())
  
})