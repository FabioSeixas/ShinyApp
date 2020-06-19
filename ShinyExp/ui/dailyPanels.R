
set_plot_container = function(plot_id) {
  return(div(class = "plot-container",
             div(class="img-container",
                 img(src="ajax-loader.gif", id = "plotSpinner"),
                 plotOutput(plot_id))))
}

yield = tabPanel("Yield",
                      br(),
                      hidden(
                        div(id = "yield_panel",
                            br(),
                            tabsetPanel(type = "pills",
                                        id = "dailyPlotParamsTabs",
                                        tabPanel("Yield Over Time",
                                                 hidden(
                                                   div(class = "PlotsContainer",
                                                       br(),
                                                  # div(h4("Final yield summarised over all cycles lengths"),
                                                  #       tableOutput("yieldTable")),
                                                  #     br(),
                                                       set_plot_container("yieldPlot")))),
                                        tabPanel("Yield and Water",
                                                 hidden(
                                                   div(class = "PlotsContainer",
                                                            br(),
                                                   set_plot_container("yieldWaterPlot"),
                                                   br(),
                                                   set_plot_container("yieldWaterPhotoPlot"),
                                                   br(),
                                                   set_plot_container("yieldWaterGrowthPlot")))),
                                        tabPanel("Yield and Temperature",
                                                 hidden(div(class = "PlotsContainer",
                                                            br(),
                                                            set_plot_container("yieldTempPlot"),
                                                            br(),
                                                            set_plot_container("yieldTempPhotoPlot"),
                                                            br(),
                                                            set_plot_container("yieldTempGrowthPlot")))),
                                        tabPanel("Harvest Index",
                                                 hidden(div(class = "PlotsContainer",
                                                            br(),
                                                            set_plot_container("harvIndexPlot"))))
                                        
                                        ))))

growth = tabPanel("Growth",
                  br(),
                  hidden(
                    div(id = "growth_panel",
                        br(),
                        tabsetPanel(type = "pills",
                                    id = "dailyPlotParamsTabs",
                                    tabPanel("Canopy Weight",
                                             hidden(
                                               div(class = "PlotsContainer",
                                                   br(),
                                                   set_plot_container("growthPlot")))),
                                    tabPanel("Canopy and Water",
                                             hidden(
                                               div(class = "PlotsContainer",
                                                    br(),
                                                    set_plot_container("growthWaterPlot"),
                                                    br(),
                                                    set_plot_container("growthWaterPhotoPlot"),
                                                    br(),
                                                    set_plot_container("growthWaterGrowthPlot")))),
                                    tabPanel("Canopy and Temperature",
                                             hidden(
                                               div(class = "PlotsContainer",
                                                   br(),
                                                   set_plot_container("growthTempPlot"),
                                                   br(),
                                                   set_plot_container("growthTempPhotoPlot"),
                                                   br(),
                                                   set_plot_container("growthTempGrowthPlot")))),
                                    tabPanel("LAI",
                                             hidden(
                                               div(class = "PlotsContainer",
                                                   br(),
                                                   set_plot_container("LaiPlot")))),
                                    tabPanel("Assimilation",
                                             hidden(div(class = "PlotsContainer",
                                                        br(),
                                                        set_plot_container("assProdPlot")))),
                                    tabPanel("Nodes",
                                             hidden(div(class = "PlotsContainer",
                                                        br(),
                                                        set_plot_container("nodesPlot"))))
                                    ))))
                  
                  

evapo = tabPanel("Evapotranspiration",
                 # EOAA x ETAA -> pot x avg evapotranspiration
                 # EOPA x EPAA -> pot x avg transpiration
                 )