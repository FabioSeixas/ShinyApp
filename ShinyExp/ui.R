library(tidyverse)
library(lubridate)
library(shiny)
library(shinyjs)
library(shinythemes)

source("ui/panels.R")
source("utils.R")$value

Sys.setlocale("LC_TIME", "C")


ui <- fluidPage(theme = shinytheme("sandstone"),
    
    useShinyjs(),
    
    includeCSS("www/style.css"),
    
    titlePanel("DSSAT Results"),
    
    sidebarLayout(
        
        sidebarPanel(id = "inputPanel", width = 3,
            
            fileInput("file", "Choose CSV File",
                      multiple = FALSE,
                      accept = ".csv")
            
        ),
        
        mainPanel(
            
            tabsetPanel(type = "pills",
                        id = "plotParamsTabs",
                tabPanel("Summary Results",
                         br(),
                         div(id = "panel-container",
                             tabsetPanel(type = "pills",
                                         id = "plotParamsTabs",
                                         sumGeneral,
                                         sumGermination,
                                         sumPrecipitation,
                                         sumIrrigation))),
                tabPanel("Daily Results",
                         br(),
                         div(selectizeInput("daily_select_year",
                                            "Select Year(s) (4 Max)",
                                            1980:2020,
                                            multiple = T,
                                            options = list(maxItems = 4))),
                         tabsetPanel(type = "pills",
                                     id = "plotParamsTabs",
                                     yield,
                                     growth,
                                     evapo))))))

