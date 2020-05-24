

sumGeneral = tabPanel("General", 
                      br(),
                      fluidRow(
                        column(6,
                               div(h4("Yield x Planting Date by cycle length"),
                                   plotOutput(outputId = "general_plot"))),
                        column(6,
                               div(h4("Basic Statistics"),
                                   tableOutput(outputId = "general_table")))),
                      br(),
                       
                      fluidRow(
                        column(6,
                               div(h4("Yield Results Probability"),
                                   plotOutput(outputId = "prob_plot"))),
                        column(6,
                               div(
                                 selectInput("sum_prob_month",
                                             "Select Planting Month",
                                             lubridate::month(1:12, label = T),
                                             multiple = T),
                                 p("Quantiles taken from all cycles lengths"),
                                 tableOutput(outputId = "prob_table")))))

sumGermination = tabPanel("Germination", 
                          
                          titlePanel("Germination Summary"),
                          
                          br(),
                          
                          fluidRow(column(6, div(
                            
                            h4("Successful Germinations by Month"),
                            
                            plotOutput(outputId = "germ_success_abs")
                            
                          )),
                          
                          column(6, div(
                            
                            h4("Successful Germinations by Month (%)"),
                            
                            plotOutput(outputId = "germ_success_perc") 
                            
                          ))),
                          
                          br(),
                          
                          fluidRow(column(6, div(
                            
                            h4("Germinations Fails by Month"),
                            
                            plotOutput(outputId = "germ_fails_abs")
                            
                          )),
                          
                          column(6, div(
                            
                            h4("Germinations Fails by Month (%)"),
                            
                            plotOutput(outputId = "germ_fails_perc")
                            
                          ))))

sumPrecipitation = tabPanel("Precipitation",
                            
                            titlePanel("Precipitation information"),
                            
                            br(),
                            
                            div(
                              
                              h4("Yield x Precipitation"),
                              
                              plotOutput(outputId = "plot3")
                              
                            ),
                            
                            br(),
                            
                            div(
                              
                              h4("By Planting Date"),
                              
                              plotOutput("plot4")))

sumIrrigation = tabPanel("Irrigation",
                         
                         titlePanel("Irrigation Information"),
                         
                         br(),
                         
                         div(h4("Yield x Irrigation"),
                             plotOutput("plot5")
                         ))