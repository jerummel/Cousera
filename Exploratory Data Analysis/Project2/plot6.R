# plot6.R compares the total emissions of PM2.5 from motor vehicle sources in the city of Baltimore, MD and the county of Los Angeles, CA for the years 1999, 2002, 2005, and 2008 on a bar graph.

library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
merged_df <- merge(NEI, SCC, by = "SCC", stringsAsFactors = FALSE)[, c("SCC", "fips", "Pollutant", "Emissions", "year", "Data.Category", "SCC.Level.Three")]

# Non-road categories that count as "motor vehicle"
categories_nonroad <- c("2-Stroke Gasoline except Rail and Marine", "Recreational Equipment", "Construction and Mining Equipment", "Agricultural Equipment", "Airport Ground Support Equipment", "4-Stroke Gasoline except Rail and Marine", "LPG Equipment except Rail and Marine", "CNG Equipment except Rail and Marine")

new_df <- merged_df[((merged_df$Data.Category == "Onroad" |  merged_df$SCC.Level.Three %in% categories_nonroad) &  merged_df$Pollutant == "PM25-PRI" & (merged_df$fips == "24510" | merged_df$fips == "06037")), ]

years <- unique(unlist(NEI$year))
fips_codes <- c("24510", "06037")
year <- c()
fips_code <- c()
emissions <- c()
for(y in years){
  for(f in fips_codes){
    year <- c(year, toString(y))
    fips_code <- c(fips_code, f)
    filtered_df <- subset(new_df, (year == y & fips == f))
    emissions <- c(emissions, sum(filtered_df$Emissions)) 
  }
}

location_list <- lapply(fips_code, function(x) ifelse(x == "24510", "Baltimore City, MD", "Los Angeles County, CA"))
location <- array(unlist(location_list), dim = c(nrow(location_list[[1]]), ncol(location_list[[1]]), length(location_list)))

df <- data.frame(year, location, emissions)
png(filename = "plot6.png", width = 480, height=480)
g <- ggplot(df, aes(year, emissions))
g + geom_bar(stat="identity", fill = "Blue") + facet_grid(.~location) + xlab("Year") + ylab("Total Emissions (in tons)") + ggtitle("Comparison of Motor Vehicle PM2.5 Emissions")
dev.off()
rm(list = ls()) # Clean up