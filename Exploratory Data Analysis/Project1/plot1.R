mydata <- read.table("household_power_consumption.txt", header=TRUE, sep=";", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), na.strings = c("?"), nrows = 2075259, skipNul = TRUE)
datasubset <- mydata[mydata$Date == "1/2/2007" | mydata$Date == "2/2/2007",]
png(filename = "plot1.png", width = 480, height=480)
with(datasubset, hist(Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main = "Global Active Power"))
dev.off()
rm(list = ls()) # Clean up