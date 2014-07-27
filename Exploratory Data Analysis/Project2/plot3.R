# plot3.R calculates the total emissions for each source of PM2.5 in Baltimore, MD for the years 1999, 2002, 2005, and 2008 then plots the totals into ggplot2.

library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")

years <- unique(unlist(NEI$year))
types <- unique(unlist(NEI$type))
year <- c()
type <- c()
emissions <- c()
for(y in years){
  for(t in types){
    year <- c(year, toString(y))
    type <- c(type, t)
    filtered_df <- subset(NEI, (year == y & Pollutant == "PM25-PRI" & fips == "24510" & type == t))
    emissions <- c(emissions, sum(filtered_df$Emissions)) 
  }
}

df <- data.frame(year, type, emissions)
png(filename = "plot3.png", width = 480, height=480)
g <- ggplot(df, aes(year, emissions))
g + geom_bar(stat="identity", fill = "Blue") + facet_grid(.~type) + xlab("Year") + ylab("Total Emissions (in tons)") + ggtitle("Total PM2.5 Emissions in Baltimore, MD by Source")
dev.off()
rm(list = ls()) # Clean up