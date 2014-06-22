NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI$fips <- as.factor(NEI$fips)
NEI$SCC <- as.factor(NEI$SCC)
NEI$Pollutant <- as.factor(NEI$Pollutant)
NEI$type <- as.factor(NEI$type)

# How have emissions from motor vehicle sources changed 
# from 1999–2008 in Baltimore City? 

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

png(file="plot5.png")
plot(names(yearlyEmissionTotals), yearlyEmissionTotals, pch=19, type="l",
     xaxt="n", xlab="Year", ylab="Total Emission", main="Yearly Total Emissions - Baltimore - Motor vehicles")
axis(1, at=names(yearlyEmissionTotals))
dev.off()
