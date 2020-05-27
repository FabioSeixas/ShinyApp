
dailyGeneral = tabPanel("General", )

dailyYield = tabPanel("Yield",
                      
                      br(),
                      
                      hidden(
                        div(id = "yield_panel",
                            div(
                              selectizeInput("yield_sel_year",
                                            "Select Year(s) (4 Max)",
                                            1980:2020,
                                            multiple = T,
                                            options = list(maxItems = 4))),
                            br(),
                          
                            hidden(
                              div(id = "PlotsContainer",
                                  br(),
                                  div(
                                      h4("Final yield summarised over all cycles lengths"),
                                      tableOutput("yieldTable")),
                                  
                                  br(),
                                  
                                  div(
                                      h4("Yield over time"),
                                      img(src="ajax-loader.gif", id = "plotSpinner"),
                                      plotOutput("yieldPlot")),
                                  
                                  br(),
                                  
                                  div(
                                      h4("Yield x Available Water"),
                                      img(src="ajax-loader.gif", id = "plotSpinner"),
                                      plotOutput("yieldWaterPlot")))))))