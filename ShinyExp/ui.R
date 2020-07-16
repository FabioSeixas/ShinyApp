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
        
        sidebarPanel(id = "inputPanel", width = 2,
                     br(),
        
                         radioButtons("period",
                         "Choose the Season",
                         choices = c("Dry (Ago to Fev)", "Wet (Mar to Jul)"),
                         selected = "Dry (Ago to Fev)"),
            radioButtons("management",
                         "Choose the Management",
                         choices = c("Irrigated auto",
                                     "Irrigated > 100",
                                     "Irrigated = 80",
                                     "Rainfed"),
                         selected = "Fully Irrigated"),
            radioButtons("soil",
                         "Choose the Soil",
                         choices = c("Default"),
                         selected = "Default"),
            actionButton("readfile",
                         "Load",
                         width = 100)
            
            
        ),
        
        mainPanel(width = 9,
            
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
                                            choices = c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul",
                                                        "Aug", "Sep", "Oct", "Nov", "Dec"),
                                            multiple = T,
                                            selected = c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul",
                                                         "Aug", "Sep", "Oct", "Nov", "Dec")),
                         tabsetPanel(type = "pills",
                                     id = "dailyPlotParamsTabs",
                                     yield,
                                     growth,
                                     evapo)))))))

