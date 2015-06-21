#load shiny library
library(shiny)

# load rCharts for dynamic oupt 
library(rCharts)


# Data processing libraries
library(data.table)
library(dplyr)

# Required by includeMarkdown
library(markdown)


# Load data processing file
source("helperfile.R")

NEI <-  readRDS("sample.RDS")
nfips <- sort(unique(NEI$fips))

# Shiny server
shinyServer(
  function(input, output,session) {
    
    
    # Define and initialize reactive values
    values <- reactiveValues()
    values$nfips <- nfips
    
   
    # Render data table
    output$dTable <- renderDataTable({
      dataTable() } )
       
    
    # Check box selected on left pane
    output$fipscontrol <- renderUI({
      checkboxGroupInput('nfips', 'Zip Code', nfips, selected=values$nfips)
    })
    
    
    # Add observers on clear and select all buttons
    observe({
      if(input$clear_all == 0) return()
      values$nfips <- c()
    })
    
  
    observe({
      if(input$select_all == 0) return()
      values$nfips <- nfips
    })
    
    
#     dataTableByYear <- reactive({
#       groupByYearAgg(NEI, input$range[1], 
#                      input$range[2])
#     })
    

    # Prepare dataset for plotting
    dt.agg.year <- reactive({
      aggregate_by_year(NEI, input$range[1], input$range[2],input$nfips)
      
    })
    
    output$emissionsByYear <- renderChart({
      plotEmissionsbyYear(dt.agg.year())
    })
    
    # Prepare dataset for table rendering
    dataTable <- reactive({
      groupByYear(NEI,input$range[1], 
                   input$range[2],input$nfips)
    })
    
   
  } # end of function(input, output)
)