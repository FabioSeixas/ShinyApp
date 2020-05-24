source("panels/import.R")$value

options(shiny.maxRequestSize=30*1024^2)

server <- function(input, output) {
    
    df = reactive({
        
        req(input$file)
        
        read_csv(input$file$datapath) %>%
            new_column()
        
    })
    
    # =========== General Panel ============ #
    
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
    
    
    # ============ Germination Panel =========== #
    
    source("server/germination.R", local = TRUE)
    
    # ========== Precipitation Panel =========== #
    
    output$plot3 = renderPlot({
        
        df() %>%
            yield_prec()
        
    }, width = 500)
    
    
    output$plot4 = renderPlot({
        
        df() %>%
            mean_cum_prec()
        
    }, width = 500)
    
    
    # ============= Irrigation Panel ============ #
    
    output$plot5 = renderPlot({
        
        df() %>%
            yield_irrigation()
        
    }, width = 500)
    
}
