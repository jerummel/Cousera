mydata <- read.table("household_power_consumption.txt", header=TRUE, sep=";", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), na.strings = c("?"), nrows = 2075259, skipNul = TRUE)
datasubset <- mydata[mydata$Date == "1/2/2007" | mydata$Date == "2/2/2007",]
datetime <- do.call(paste0, datasubset[c(1, 2)])
datetime <- strptime(datetime, "%e/%m/%Y%H:%M:%S")
datasubset <- cbind(datetime=datetime, datasubset)
datasubset <- subset(datasubset, select=-c(Date, Time))
png(filename = "plot2.png", width = 480, height=480)
with(datasubset, {
  plot(datetime, Global_active_power, type="n", xlab="", ylab = "Global Active Power (kilowatts)")
  lines(datetime, Global_active_power)
})
dev.off()
rm(list = ls()) # Clean up