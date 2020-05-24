library(tidyverse)
library(lubridate)
library(shiny)

source("ui/panels.R")
source("utils.R")$value

Sys.setlocale("LC_TIME", "C")


ui <- fluidPage(
    
    titlePanel("DSSAT Results"),
    
    sidebarLayout(
        
        sidebarPanel(
            
            fileInput("file", "Choose CSV File",
                      multiple = FALSE,
                      accept = ".csv")
            
        ),
        
        mainPanel(
            
            tabsetPanel(
                tabPanel("Summary Results",
                         tabsetPanel(
                             sumGeneral,
                             sumGermination,
                             sumPrecipitation,
                             sumIrrigation)),
                tabPanel("Daily Results",
                         tabsetPanel(
                             dailyGeneral))
                ))))

