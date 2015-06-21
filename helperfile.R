# Load required libraries
require(data.table)
library(dplyr)
library(DT)
library(rCharts)


# Grouping data for table rendetion based on selection
groupByYear <- function(NEI, minYear, maxYear,afips) {
  result <- NEI %>% filter(year >= minYear, year <= maxYear,fips %in% afips) 
  return(result)
}

# Aggregrate data
aggregate_by_year <- function(NEI, year_min, year_max, afips) {
  
   # filter data as selected
   dt1 <- NEI %>% filter(year >= year_min, year <= year_max, fips %in% afips)
  
    #aggregate data 
  dt1 <- aggregate(Emissions ~ year + type,data = dt1, FUN = sum)
  
  # return result set
  return(dt1)
  
  }

#' Plot number of themes by year
#' 
#' @param dt data.table
#' @param dom
#' @param yAxisLabel year
#' @param "PM2.5 Tons/ 10^4"
#' @return EmissionsbyYear plot
#
plotEmissionsbyYear<- function(dt, dom = "emissionsByYear",yAxisLabel = "Emissions") {
 
  emissionsByYear <- nPlot(
    Emissions ~ year,
    dom = dom,
    data = dt,
    group = "type",
    type = "multiBarChart")
  
  emissionsByYear$chart(margin = list(left = 100))
  emissionsByYear$yAxis( axisLabel = "Emissions", width = 80)
  emissionsByYear$xAxis( axisLabel = "Year", width = 70)
  
  emissionsByYear
}




