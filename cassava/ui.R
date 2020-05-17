library(tidyverse)
library(lubridate)
library(shiny)

source("utils.R")$value

Sys.setlocale("LC_TIME", "C")

# Define UI for application that draws a histogram
ui <- fluidPage(
    
    # Título do app.
    titlePanel("DSSAT Results"),
    
    # Barra lateral com as definições do input e do output.
    sidebarLayout(
        
        # Barra lateral para os inputs.
        sidebarPanel(
            
            fileInput("file", "Choose CSV File",
                      multiple = FALSE,
                      accept = ".csv")
            
        ),
        
        
        # Painel principal para mostrar os outputs.
        mainPanel(
            
            tabsetPanel(
                tabPanel("General", 
                         
                         br(),
                         
                         div(
                            
                             h4("Yield x Planting Date by cycle length"),
                             
                             plotOutput(outputId = "plot1")
                             
                             )
                         ),
                
                tabPanel("Germination", 
                         
                         titlePanel("Germination Summary"),
                         
                         br(),
                         
                         fluidRow(
                             
                             column(6,
                         
                                     div(
                                         
                                         h4("Successful Germinations by Date"),
                                         
                                         tableOutput(outputId = "table1")
                                     )
                             ),
                             
                             column(6,
                                    
                                    div(
                                         
                                         h4("Germinations Fails by Date"),
                                         
                                         plotOutput(outputId = "plot2")
                                         
                                         )
                                    
                                    )
                         )
                ),
                
                tabPanel("Precipitation",
                         
                         titlePanel("Precipitation information"),
                         
                         br(),
                         
                         div(
                             
                             h4("Yield x Precipitation"),
                             
                             plotOutput(outputId = "plot3")
                             
                             ),
                         
                         br(),
                         
                         div(
                             
                             h4("By Planting Date"),
                             
                             plotOutput("plot4")
                             
                             ),
                         
                         ),
                
                tabPanel("Irrigation",
                         
                         titlePanel("Irrigation Information"),
                         
                         br(),
                         
                         div(
                             
                             h4("Yield x Irrigation"),
                             
                             plotOutput("plot5")
                             
                         )
                         
                         
                         )
            )
            
        )
    )
)
