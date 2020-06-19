
sumGeneral = tabPanel("General",
                      br(),
                      hidden(
                        fluidRow(id = "row-container",
                          column(12,
                                 div(id = "result-container",
                                     img(src="ajax-loader.gif", id = "plotSpinner"),
                                     plotOutput(outputId = "general_plot")))),
                        br(),
                         
                        fluidRow(id = "row-container",
                                 br(),
                                 h4(strong("Yield Distribution by Month")),
                          column(6,
                                 hidden(
                                   div(id = "mainPlotContainer",
                                       img(src="ajax-loader.gif", id = "plotSpinner"),
                                       #h4("Yield Results Probability"),
                                       plotOutput(outputId = "prob_plot")))),
                          column(6,
                                 br(),
                                 div(id = "result-container",
                                   selectInput("sum_prob_month",
                                               "Select Planting Month",
                                               str_to_title(lubridate::month(1:12,
                                                                             label = T)),
                                               multiple = T),
                                   br(),
                                   tableOutput(outputId = "prob_table"),
                                   p(strong("OBS:"), "Quantiles taken from all cycles lengths"))),
                                 br())))

sumGermination = tabPanel("Germination",
                          
                          br(),
                          
                          hidden(
                            fluidRow(id = "germ_panel",
                                     column(6, div(
                                       id = "result-container",
                              h4("Successful Germinations by Month"),
                              img(src="ajax-loader.gif", id = "plotSpinner"),
                              plotOutput(outputId = "germ_success_abs")
                              
                            )),
                            
                            column(6, div(
                              id = "result-container",
                              h4("Successful Germinations by Month (%)"),
                              img(src="ajax-loader.gif", id = "plotSpinner"),
                              plotOutput(outputId = "germ_success_perc") 
                              
                            ))),
                            
                            br(),
                            
                            fluidRow(id = "germ_panel2",
                                     column(6, div(
                                       id = "result-container",
                              h4("Germinations Fails by Month"),
                              img(src="ajax-loader.gif", id = "plotSpinner"),
                              plotOutput(outputId = "germ_fails_abs")
                              
                            )),
                            
                            column(6, div(
                              id = "result-container",
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
                                         id = "result-container",
                                         h4("Yield x Precipitation"),
                                         img(src="ajax-loader.gif", id = "plotSpinner"),
                                         plotOutput(outputId = "plot3")
                                         
                                       )),
                                column(6,
                                       div(
                                         id = "result-container",
                                         h4("By Planting Date"),
                                         img(src="ajax-loader.gif", id = "plotSpinner"),
                                         plotOutput("plot4")))),
                              br()))

sumIrrigation = tabPanel("Irrigation",
                         
                         br(),
                         #hidden(
                           div(id = "result-container",
                               h4("Yield x Irrigation"),
                               img(src="ajax-loader.gif", id = "plotSpinner"),
                               plotOutput("plot5")
                           ))