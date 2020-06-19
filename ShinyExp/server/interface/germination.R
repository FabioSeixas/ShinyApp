source("server/implementation/germination.R")$value


# ======= Reactives ============= #

observeEvent(input$file, {
  shinyjs::show(selector = "div.row")
})

df_germ = reactive({
  
  req(df())
  
  df() %>%
    germ_reactive()
  
})

df_germ_success = reactive({
  
  req(df_germ())
  
  df() %>%
    germ_success_reactive(df_germ())
  
})

df_germ_fails = reactive({
  
  req(df_germ())
  
  df() %>%
    germ_fails_reactive(df_germ())
  
})

# =========== Plots ============ #

output$germ_success_abs = renderPlot({
  
  df_germ_success() %>%
    germ_success_abs()
  
}, width = 300)

output$germ_success_perc = renderPlot({
  
  df_germ_success() %>%
    germ_success_perc()
  
}, width = 300)


output$germ_fails_abs = renderPlot({
  
  df_germ_fails() %>%
    germ_fails_abs()
  
}, width = 300)


output$germ_fails_perc = renderPlot({
  
  df_germ_fails() %>%
    germ_fails_perc()
  
}, width = 300)
