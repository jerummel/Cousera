# plot2.R calculates the total emissions of PM2.5 in the Baltimore, MD for the years 1999, 2002, 2005, and 2008 then plots the totals onto a bar graph.

NEI <- readRDS("summarySCC_PM25.rds")

years <- unique(unlist(NEI$year))
emissions <- c()
for(y in years){
  filtered_df <- subset(NEI, (year == y & Pollutant == "PM25-PRI" & fips == "24510"))
  emissions <- c(emissions, sum(filtered_df$Emissions))
}

png(filename = "plot2.png", width = 480, height=480)
barplot(emissions, main = "Total PM2.5 Emissions in Baltimore, MD", xlab="Year", ylab = "Total Emissions (in tons)", names.arg=years, col="Blue")
dev.off()
rm(list = ls()) # Clean up
