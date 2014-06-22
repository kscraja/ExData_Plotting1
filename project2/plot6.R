NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI$fips <- as.factor(NEI$fips)
NEI$SCC <- as.factor(NEI$SCC)
NEI$Pollutant <- as.factor(NEI$Pollutant)
NEI$type <- as.factor(NEI$type)

# 6. Compare emissions from motor vehicle sources in  Baltimore City 
# with emissions from motor vehicle sources in  Los Angeles County, 
# California (fips == "06037"). 
# Which city  has seen greater changes over time in motor vehicle 
# emissions?

# motor vehicles SCC Types
ccSCC <- subset(SCC, SCC.Level.One == "Mobile Sources")

# selecting only baltmore data
# bmData <- subset(NEI, (fips == "24510"))
# selecting only baltmore data and vehicle SCC
bmData <- subset(NEI, (fips == "24510" & SCC %in% ccSCC$SCC))

splitTotalsPerYear <- split(bmData, list(bmData$year))

yearlyEmissionTotals <- sapply(splitTotalsPerYear, function(d) {
    sum(d$Emissions)
})

# selecting only los angeles data
# and only vehicle SCC
laData <- subset(NEI, (fips == "06037" & SCC %in% ccSCC$SCC))
laSplitTotalsPerYear <- split(laData, list(laData$year))
laYearlyEmissionTotals <- sapply(laSplitTotalsPerYear, function(d) {
    sum(d$Emissions)
})

dfBM <- data.frame(totals=yearlyEmissionTotals, year=names(yearlyEmissionTotals), city="Baltimore")
dfLA <- data.frame(totals=laYearlyEmissionTotals, year=names(laYearlyEmissionTotals), city="Los Angeles")
df <- rbind(dfBM, dfLA)

png(file="plot6.png")
qplot(year, totals, data=df, facets=.~city)
dev.off()