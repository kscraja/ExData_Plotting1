
#loadData <- function() {
    fileName <- "household_power_consumption.txt"
    #fileName <- "test_data.txt"
    data <- read.table(fileName, colClasses=c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), sep=";", na.strings=c("?"), header=TRUE)
    ndata <- subset(data, data$Date %in% c("1/2/2007", "2/2/2007"))
    odata <- data
    data <- ndata
    #data$Date <- as.Date(data$Date)
    #data$Time <- strptime(data$Time, format="%H:%M%S")
    data$NewDate <- paste(data$Date, data$Time)
    data$NewDate <- strptime(data$NewDate, format="%d/%m/%Y %H:%M:%S")
#}
    
png(file = "plot1.png")
hist(data$Global_active_power,  main="Global Active Power",  xlab="Global Active Power (kilowatts)", col ="red")
#dev.copy(png, file="plot1.png")
dev.off()
