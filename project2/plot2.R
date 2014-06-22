
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI$fips <- as.factor(NEI$fips)
NEI$SCC <- as.factor(NEI$SCC)
NEI$Pollutant <- as.factor(NEI$Pollutant)
NEI$type <- as.factor(NEI$type)

# 2. Have total emissions from PM2.5 decreased in the 
# Baltimore City, Maryland (fips == "24510") 
# from 1999 to 2008? Use the base 
# plotting system to make a plot answering this question.

# selecting only baltmore data
bmData <- subset(NEI, fips == "24510")

yearlySplit <- split(bmData, bmData$year)
yearlyEmissionTotals <- sapply(yearlySplit, function(d) {
    sum(d$Emissions)
})

png(file="plot2.png")
plot(names(yearlyEmissionTotals), yearlyEmissionTotals, pch=19, type="l",
     xaxt="n", xlab="Year", ylab="Total Emission", main="Yearly Total Emissions - Baltimore")
axis(1, at=names(yearlyEmissionTotals))
dev.off()
