source("server/implementation/general.R")


output$general_plot = renderPlot({
  
  df() %>% 
    general_plot()
  
}, width = 350, height = 400)


output$general_table = renderTable({
  
  df() %>%
    probabilities_table()
  
}, digits = 0)

# === Probability Section === #

prob_month = reactive({
  
  req(input$sum_prob_month)
  
  input$sum_prob_month
  
})

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