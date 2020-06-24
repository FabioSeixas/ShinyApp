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
                     br(),
        
                         radioButtons("period",
                         "Choose the Period",
                         choices = c("Dry (Ago to Fev)", "Wet (Mar to Jul)"),
                         selected = "Dry (Ago to Fev)"),
            radioButtons("management",
                         "Choose the Management",
                         choices = c("Fully Irrigated", "Rainfed"),
                         selected = "Fully Irrigated"),
            radioButtons("soil",
                         "Choose the Soil",
                         choices = c("Default"),
                         selected = "Default"),
            actionButton("readfile",
                         "Load",
                         width = 100)
            
            
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
                                         sumIrrigation,
                                         sumEconomic))),
                tabPanel("Daily Results",
                         br(),
                         div(id = "dailyInputs",
                             selectizeInput("daily_select_year",
                                            "Select Year(s) (4 Max)",
                                            1980:2020,
                                            multiple = T,
                                            options = list(maxItems = 4)),
                             selectizeInput("daily_select_month",
                                            label = "Select Month(s)",
                                            choices = str_to_title(lubridate::month(1:12,
                                                                          label = T)),
                                            multiple = T,
                                            selected = str_to_title(lubridate::month(1:12,
                                                                                     label = T))),
                         tabsetPanel(type = "pills",
                                     id = "dailyPlotParamsTabs",
                                     yield,
                                     growth,
                                     evapo)))))))

