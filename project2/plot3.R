NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI$fips <- as.factor(NEI$fips)
NEI$SCC <- as.factor(NEI$SCC)
NEI$Pollutant <- as.factor(NEI$Pollutant)
NEI$type <- as.factor(NEI$type)

# 3. Of the four types of sources indicated by the 
# type (point, nonpoint, onroad, nonroad) variable, which of 
# these four sources have seen decreases in emissions 
# from 1999–2008 for Baltimore City? Which have seen 
# increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

# selecting only baltmore data
bmData <- subset(NEI, fips == "24510")

splitTypeAndYear <- split(bmData, list(bmData$type, bmData$year))

yearlyEmissionTotals <- sapply(splitTypeAndYear, function(d) {
    sum(d$Emissions)
})

#creating data frame with year and type and totals
df <- data.frame(types=names(yearlyEmissionTotals), totals=yearlyEmissionTotals)
df$typeAndPointAsChar <- as.character(df$types)
X <- read.table(textConnection(df$typeAndPointAsChar), sep=".", col.names=c("type", "year"))
X <- cbind(X, df$totals)

library(ggplot2)

png(file="plot3.png")
qplot(year, df$totals, data=X, facets=type~.)
dev.off()
