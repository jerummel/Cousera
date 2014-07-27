# plot4.R calculates the total emissions of PM2.5 in the United States from coal combustion for the years 1999, 2002, 2005, and 2008 then plots the totals onto a bar graph.

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
merged_df <- merge(NEI, SCC, by = "SCC", stringsAsFactors = FALSE)[, c("SCC", "Pollutant", "Emissions", "year", "EI.Sector")]
merged_df = merged_df[grep("Coal", merged_df$EI.Sector, fixed = TRUE), ]

years <- unique(unlist(NEI$year))
emissions <- c()
for(y in years){
  filtered_df <- subset(merged_df, (year == y & Pollutant == "PM25-PRI"))
  emissions <- c(emissions, sum(filtered_df$Emissions))
}

png(filename = "plot4.png", width = 480, height=480)
barplot(emissions, main = "Total PM2.5 Emissions From Coal Combustion in the U.S.", xlab="Year", ylab = "Total Emissions (in tons)", names.arg=years, col="Blue")
dev.off()
rm(list = ls()) # Clean up
