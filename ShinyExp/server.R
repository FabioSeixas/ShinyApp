
options(shiny.maxRequestSize=30*1024^2)

server <- function(input, output) {
    
    df = reactive({
        
        req(input$file)
        
        read_csv(input$file$datapath) %>%
            new_column()
        
    })
    
    # Summary Outputs
    
    # =========== General Panel ============ #
    
    source("server/interface/general.R", local = TRUE)
    
    # ============ Germination Panel =========== #
    
    source("server/interface/germination.R", local = TRUE)
    
    # ========== Precipitation Panel =========== #
    
    source("server/interface/precipitation.R", local = TRUE)
    
    # ============= Irrigation Panel ============ #
    
    source("server/interface/irrigation.R", local = TRUE)
    
    
    
    # Daily Outputs
    
    # ========== Yield Panel ======== #
    
    source("server/interface/yield.R", local = TRUE)
    
}





