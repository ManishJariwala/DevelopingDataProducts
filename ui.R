
#load library 

library(shiny)
library(rCharts)

#
shinyUI(
    navbarPage("Emissions Data for selected zip code",
        tabPanel("Plot",
                sidebarPanel(
                    sliderInput("range", 
                        "Range:", 
                        min = 1950, 
                        max = 2011, 
                        value = c(1993, 2011)
                       # format="####"
                        ),
                    uiOutput("fipscontrol"),
                    actionButton(inputId = "clear_all", label = "Clear selection", icon = icon("check-square")),
                    actionButton(inputId = "select_all", label = "Select all", icon = icon("check-square-o"))
                ),
  
                mainPanel(
                    tabsetPanel(
                        
                      
                        # Data 
                        tabPanel(p(icon("table"), "Data"),
                                 dataTableOutput(outputId="dTable")
                        ),
                      
                        # Time series data
                        tabPanel(p(icon("line-chart"), "By year"),
                                 h4('Number of events by year', align = "center"),
                                 showOutput("emissionsByYear", "nvd3")
                        )
                        
                        
                    )
                )
            
        ),
        
        tabPanel("About",
            mainPanel(
                includeMarkdown("include.md")
            )
        )
    )
)
