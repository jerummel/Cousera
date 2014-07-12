mydata <- read.table("household_power_consumption.txt", header=TRUE, sep=";", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), na.strings = c("?"), nrows = 2075259, skipNul = TRUE)
datasubset <- mydata[mydata$Date == "1/2/2007" | mydata$Date == "2/2/2007",]
datetime <- do.call(paste0, datasubset[c(1, 2)])
datetime <- strptime(datetime, "%e/%m/%Y%H:%M:%S")
datasubset <- cbind(datetime=datetime, datasubset)
datasubset <- subset(datasubset, select=-c(Date, Time))
png(filename = "plot3.png", width = 480, height=480)
with(datasubset, {
  plot(datetime, Sub_metering_1, type="n", xlab="", ylab = "Energy sub metering")
  lines(datetime, Sub_metering_1)
  lines(datetime, Sub_metering_2, col="red")
  lines(datetime, Sub_metering_3, col="blue")
  legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=1, lty=1)
})
dev.off()
rm(list = ls()) # Clean up