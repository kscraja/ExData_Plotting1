
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
    
png(file = "plot3.png")
plot(data$NewDate, data$Sub_metering_1, type="l", col="black", main="", ylab="Energy sub metering", xlab="")
points(data$NewDate, data$Sub_metering_2, type="l", col="red")
points(data$NewDate, data$Sub_metering_3, type="l", col="blue")
legend("topright", lty=1, col=c("black" ,"blue", "red"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
