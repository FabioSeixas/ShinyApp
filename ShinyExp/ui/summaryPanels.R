

sumGeneral = tabPanel("General", 
                      br(),
                      hidden(
                        fluidRow(id = "general_panel",
                          column(6,
                                 div(h4("Yield x Planting Date by cycle length"),
                                     img(src="ajax-loader.gif", id = "plotSpinner"),
                                     plotOutput(outputId = "general_plot"))),
                          column(6,
                                 div(h4("Basic Statistics"),
                                     tableOutput(outputId = "general_table")))),
                        br(),
                         
                        fluidRow(id = "general_panel2",
                                 br(),
                          column(6,
                                 br(),
                                 hidden(
                                   div(id = "mainPlotContainer",
                                       img(src="ajax-loader.gif", id = "plotSpinner"),
                                       #h4("Yield Results Probability"),
                                       plotOutput(outputId = "prob_plot")))),
                          column(6,
                                 br(),
                                 div(
                                   selectInput("sum_prob_month",
                                               "Select Planting Month",
                                               str_to_title(lubridate::month(1:12,
                                                                             label = T)),
                                               multiple = T),
                                   br(),
                                   p("Quantiles taken from all cycles lengths"),
                                   tableOutput(outputId = "prob_table")),
                                 br()))))

sumGermination = tabPanel("Germination",
                          
                          br(),
                          
                          hidden(
                            fluidRow(id = "germ_panel",
                                     column(6, div(
                              
                              h4("Successful Germinations by Month"),
                              img(src="ajax-loader.gif", id = "plotSpinner"),
                              plotOutput(outputId = "germ_success_abs")
                              
                            )),
                            
                            column(6, div(
                              
                              h4("Successful Germinations by Month (%)"),
                              img(src="ajax-loader.gif", id = "plotSpinner"),
                              plotOutput(outputId = "germ_success_perc") 
                              
                            ))),
                            
                            br(),
                            
                            fluidRow(id = "germ_panel2",
                                     column(6, div(
                              
                              h4("Germinations Fails by Month"),
                              img(src="ajax-loader.gif", id = "plotSpinner"),
                              plotOutput(outputId = "germ_fails_abs")
                              
                            )),
                            
                            column(6, div(
                              
                              h4("Germinations Fails by Month (%)"),
                              img(src="ajax-loader.gif", id = "plotSpinner"),
                              plotOutput(outputId = "germ_fails_perc")
                              
                            )))))

sumPrecipitation = tabPanel("Precipitation",
                            
                            br(),
                            
                            hidden(
                              fluidRow(id = "prec_panel",
                                column(6,
                                       div(
                                         
                                         h4("Yield x Precipitation"),
                                         img(src="ajax-loader.gif", id = "plotSpinner"),
                                         plotOutput(outputId = "plot3")
                                         
                                       )),
                                column(6,
                                       div(
                                         
                                         h4("By Planting Date"),
                                         img(src="ajax-loader.gif", id = "plotSpinner"),
                                         plotOutput("plot4")))),
                              br()))

sumIrrigation = tabPanel("Irrigation",
                         
                         br(),
                         hidden(
                           div(id = "irrig_panel",
                               h4("Yield x Irrigation"),
                               img(src="ajax-loader.gif", id = "plotSpinner"),
                               plotOutput("plot5")
                           )))