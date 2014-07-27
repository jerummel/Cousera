# plot5.R calculates the total emissions of PM2.5 in the city of Baltimore from motor vehicle sources for the years 1999, 2002, 2005, and 2008 then plots the totals onto a bar graph.

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
merged_df <- merge(NEI, SCC, by = "SCC", stringsAsFactors = FALSE)[, c("SCC", "fips", "Pollutant", "Emissions", "year", "Data.Category", "SCC.Level.Three")]

#Non-road categories that count as "motor vehicle"
categories_nonroad <- c("2-Stroke Gasoline except Rail and Marine", "Recreational Equipment", "Construction and Mining Equipment", "Agricultural Equipment", "Airport Ground Support Equipment", "4-Stroke Gasoline except Rail and Marine", "LPG Equipment except Rail and Marine", "CNG Equipment except Rail and Marine")

new_df <- merged_df[((merged_df$Data.Category == "Onroad" |  merged_df$SCC.Level.Three %in% categories_nonroad) &  merged_df$Pollutant == "PM25-PRI" & merged_df$fips == "24510"), ]

years <- unique(unlist(NEI$year))
emissions <- c()
for(y in years){
  filtered_df <- subset(new_df, (year == y))
  emissions <- c(emissions, sum(filtered_df$Emissions))
}

png(filename = "plot5.png", width = 480, height=480)
barplot(emissions, main = "Total PM2.5 Emissions From Motor Vehicles in Baltimore, MD", xlab="Year", ylab = "Total Emissions (in tons)", names.arg=years, col="Blue")
dev.off()
rm(list = ls()) # Clean up