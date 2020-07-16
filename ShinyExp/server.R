
options(shiny.maxRequestSize=30*2024^2)

server <- function(input, output) {
    
    df = eventReactive(input$readfile, {
        
        dict = c("Dry (Ago to Fev)" = "D",
                 "Wet (Mar to Jul)" = "W",
                 "Irrigated auto" = "I00",
                 "Irrigated > 100" = "I01",
                 "Irrigated = 80" = "I02",
                 "Rainfed" = "R00",
                 "Default" = "A")
        
        filename = paste0(dict[input$period],
                          dict[input$management],
                          dict[input$soil],
                          ".csv")
        
        path = here::here("data",
                          filename)
        
        read_csv(path) %>%
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
    
    # ============= Economic Panel ============ #
    
    source("server/interface/economic.R", local = TRUE)
    
    
    
    # Daily Outputs
    
    # ========== Yield Panel ======== #
    
    source("server/interface/yield.R", local = TRUE)
    
    # ========== Growth Panel ======== #
    
    source("server/interface/growth.R", local = TRUE)

    # ========== Evapotranspiration Panel ======== #
    
    source("server/interface/evapo.R", local = TRUE)
    
}





