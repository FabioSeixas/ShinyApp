
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
                                 div(id = "result-container",
                                   selectInput("sum_prob_month",
                                               "Select Planting Month",
                                               choices = c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul",
                                                 "Aug", "Sep", "Oct", "Nov", "Dec"),
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
                         hidden(
                           div(class = "plot-container sum",
                               img(src="ajax-loader.gif", id = "plotSpinner"),
                               plotOutput("plot5")
                           )))

sumEconomic = tabPanel("Economic",
                       br(),
                       hidden(
                         fluidRow(column(6,
                                         div(class = "plot-container sum",
                                             img(src="ajax-loader.gif", id = "plotSpinner"),
                                             plotOutput("grossMarginPlot"))),
                                  column(6,
                                         div(class = "plot-container sum",
                                             img(src="ajax-loader.gif", id = "plotSpinner"),
                                             plotOutput("econRelationPlot")))),
                         br(),
                         div(id = "dailyInputs",
                             selectizeInput("econ_select_month",
                                            "Select Month(s)",
                                            choices = c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul",
                                                        "Aug", "Sep", "Oct", "Nov", "Dec"),
                                            multiple = T,
                                            selected = c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul",
                                                         "Aug", "Sep", "Oct", "Nov", "Dec")),
                             selectizeInput("econ_select_cycle",
                                            label = "Select Cycle(s)",
                                            choices = 8:12,
                                            multiple = T,
                                            selected = 8:12)),
                         fluidRow(column(8,
                                         div(class = "plot-container sum", id = "econResults", 
                                             img(src="ajax-loader.gif", id = "plotSpinner"),
                                             plotOutput("econResultsPlot"))),
                                  column(4,
                                         div(class = "text-results",
                                             br(),
                                             h5("Yield Threshold to ensure a Positive Result"),
                                             verbatimTextOutput("yieldThreshold"),
                                             br(),
                                             h5("Simulations above the Threshold"),
                                             verbatimTextOutput("econPercent")))),
                         br(),
                         fluidRow(column(8,
                                         div(class = "plot-container sum",
                                             img(src="ajax-loader.gif", id = "plotSpinner"),
                                             plotOutput("econSecurityPlot"))),
                                  column(4,
                                         div(class = "text-results",
                                             br(),
                                             h5("Security Margins equal or above 10%"),
                                             verbatimTextOutput("econSecurityText10"),
                                             br(),
                                             h5("Security Margins equal or above 30%"),
                                             verbatimTextOutput("econSecurityText30"),
                                             br(),
                                             h5("Security Margins equal or above 50%"),
                                             verbatimTextOutput("econSecurityText50"))))
                         ))
                      