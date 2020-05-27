library(tidyverse)
library(lubridate)
library(shiny)
library(shinyjs)

source("ui/panels.R")
source("utils.R")$value

Sys.setlocale("LC_TIME", "C")

mycss = "

#general_panel {
  margin-top: 20px;
  margin-bottom: 20px;
}

#mainPlotContainer {
  position: relative;
}

#plotSpinner {
  position: absolute;
  left: 50%;
  top: 50%;
  margin-top: -50px;
  margin-left: -33px;
  z-index: -1;
}

#prob_plot {
  text-align: center;
  position: relative;
  z-index: 2;
}
#prob_plot.recalculating {
  z-index: -2;
}
"


ui <- fluidPage(
    
    useShinyjs(),
    
    tags$head(tags$style(HTML(mycss))),
    
    titlePanel("DSSAT Results"),
    
    sidebarLayout(
        
        sidebarPanel(
            
            fileInput("file", "Choose CSV File",
                      multiple = FALSE,
                      accept = ".csv")
            
        ),
        
        mainPanel(
            
            tabsetPanel(type = "pills",
                        id = "plotParamsTabs",
                tabPanel("Summary Results",
                         br(),
                         tabsetPanel(type = "pills",
                                     id = "plotParamsTabs",
                             sumGeneral,
                             sumGermination,
                             sumPrecipitation,
                             sumIrrigation)),
                tabPanel("Daily Results",
                         br(),
                         tabsetPanel(type = "pills",
                                     id = "plotParamsTabs",
                             dailyGeneral,
                             dailyYield))))))

