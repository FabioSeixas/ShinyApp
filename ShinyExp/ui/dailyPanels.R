
dailyGeneral = tabPanel("General", )

dailyYield = tabPanel("Yield",
                      
                      br(),
                      
                      div(selectizeInput("yield_sel_year",
                                        "Select Year(s) (4 Max)",
                                        1980:2020,
                                        multiple = T,
                                        options = list(maxItems = 4))),
                      br(),
                      
                      div(h4("Final yield summarised over all cycles lengths"),
                          tableOutput("yieldTable")),
                      
                      br(),
                      
                      div(h4("Yield over time"),
                          plotOutput("yieldPlot")),
                      
                      br(),
                      
                      div(h4("Yield x Available Water"),
                          plotOutput("yieldWaterPlot")))