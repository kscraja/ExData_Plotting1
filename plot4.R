
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
    
png(file = "plot4.png")
    
par(mfrow=c(2,2))

#plot1
plot(data$NewDate, data$Global_active_power, type="l", main="", ylab="Global Active Power", xlab="")


#plot2
plot(data$NewDate, data$Voltage, type="l", main="", ylab="Voltage", xlab="datetime")

#plot3
plot(data$NewDate, data$Sub_metering_1, type="l", col="black", main="", ylab="Energy sub metering", xlab="")
points(data$NewDate, data$Sub_metering_2, type="l", col="red")
points(data$NewDate, data$Sub_metering_3, type="l", col="blue")
legend("topright", lwd="1", box.lwd=0, lty=1, col=c("black" ,"blue", "red"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#plot4
plot(data$NewDate, data$Global_reactive_power, type="l", main="", ylab="Global_reactive_power", xlab="datetime")

dev.off()
