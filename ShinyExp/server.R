source("panels/import.R")$value

options(shiny.maxRequestSize=30*1024^2)

server <- function(input, output) {
    
    df = reactive({
        
        req(input$file)
        
        read_csv(input$file$datapath)
        
    })
    
    # =========== General Panel ============ #
    
    output$plot1 = renderPlot({
        
        df() %>% 
            general_plot()
        
    }, width = 500, height = 400)
    
    
    output$table1 = renderTable({
        
        df() %>%
            probabilities_table()
        
    }, digits = 0)
    
    
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
