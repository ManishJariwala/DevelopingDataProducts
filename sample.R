# Assumption - Zip file has been downloaded to current working director, and it has been unzipped.
# Also, it is assumed that the "onroad" captures all motor vehicle.

# Check if both data exist in the environment. If not, load the data.
if (!"NEI" %in% ls()) {
  NEI <- readRDS("summarySCC_PM25.rds")
}
if (!"SCC" %in% ls()) {
  SCC <- readRDS("Source_Classification_Code.rds")
}

# Only Baltimore
NEIbaltimore <- NEI[NEI$fips=="24510",]

# Caputre Emissions for all Motor Vehicle.  It is assumed that Data Cateogy - On-road, provides comprehensive information.

SCCmotor <- SCC[SCC$Data.Category == "Onroad",] 
NEImotor <- NEIbaltimore[NEIbaltimore$SCC %in% SCCmotor$SCC,]


# Calculate sum by year
emissiontotalbyyear <- aggregate(Emissions ~ year + type,data = NEImotor, FUN = sum)




nPlot(
  Emissions ~ year,
  data = emissiontotalbyyear,
  group = "type",
  type = "multiBarChart")



