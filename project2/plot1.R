
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI$fips <- as.factor(NEI$fips)
NEI$SCC <- as.factor(NEI$SCC)
NEI$Pollutant <- as.factor(NEI$Pollutant)
NEI$type <- as.factor(NEI$type)

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission 
# from all sources for each of the years 1999, 2002, 2005, and 2008.

yearlySplit <- split(NEI, NEI$year)
yearlyEmissionTotals <- sapply(yearlySplit, function(d) {
    sum(d$Emissions)
})

png(file="plot1.png")
plot(names(yearlyEmissionTotals), yearlyEmissionTotals, pch=19, type="l",
     xaxt="n", xlab="Year", ylab="Total Emission", main="Yearly Total Emissions")
axis(1, at=names(yearlyEmissionTotals))
dev.off()
