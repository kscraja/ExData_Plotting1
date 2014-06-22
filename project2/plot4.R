NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI$fips <- as.factor(NEI$fips)
NEI$SCC <- as.factor(NEI$SCC)
NEI$Pollutant <- as.factor(NEI$Pollutant)
NEI$type <- as.factor(NEI$type)

# Across the United States, how have emissions 
# from coal combustion-related sources changed from 1999–2008?


# coal combustion SCC Types
ccSCC <- subset(SCC, grepl("Combustion", SCC.Level.One) & grepl("Coal", SCC.Level.Three))

# selecting only baltmore data
# bmData <- subset(NEI, (fips == "24510"))
# oldBMData <- bmData
# selecting only baltmore data and coal combustion
bmData <- subset(NEI, (fips == "24510" & SCC %in% ccSCC$SCC))

splitTotalsPerYear <- split(bmData, list(bmData$year))

yearlyEmissionTotals <- sapply(splitTotalsPerYear, function(d) {
    sum(d$Emissions)
})

png(file="plot4.png")
plot(names(yearlyEmissionTotals), yearlyEmissionTotals, pch=19, type="l",
     xaxt="n", xlab="Year", ylab="Total Emission", main="Yearly Total Emissions - Baltimore - Coal Combution")
axis(1, at=names(yearlyEmissionTotals))
dev.off()
