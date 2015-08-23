##This section sets the working directory to the folder
##location where my files are located.

setwd("C:/Users/rsamuel/Datascience Specialization/Exploritory Data Analysis/Course Project 2")

##This reads in the data that will be used for the analysis

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Merges the 2 datasets on the SCC columns

NEISCC <- merge(NEI,SCC, by.x = "SCC", by.y = "SCC")

##Subsets the merged dataset for Emissions, year, fips and EI.sector columns,
##summing the Emissions by year, fips and EI.Sector

TtlyrfipsandSector <- aggregate(NEISCC["Emissions"]
                                ,by = NEISCC[c("year","fips","EI.Sector")], FUN = sum)

##Loads the dplyr package used for data manipulation

library(dplyr)

##Filters the data to only include information for Baltimore City and Los Angeles
##(represented by 24510 and 06037 respectively in the fips column), 
##and rows that has "On-Road" in the description
##of the EI.Sector column to get only motor vehicle Emissions

TtlSubset <- filter(TtlyrfipsandSector, grepl("On-Road", EI.Sector))
filterdata <- c("24510","06037")
TtlSubset <- filter(TtlSubset, fips %in% filterdata)

##Sums Emissions in the subsetted data by year and fips

TtlSubset <- aggregate(TtlSubset["Emissions"], by = TtlSubset[c("year","fips")], FUN = sum)
rm(TtlyrfipsandSector,filterdata)

##Replaces 24510 with "Baltimore" and 06037 with "Los Angeles" in the subsetted dataset

TtlSubset$fips[TtlSubset$fips == "24510"] <- "Baltimore"
TtlSubset$fips[TtlSubset$fips == "06037"] <- "Los Angeles"

##Loads the ggplot2 package for plotting

library(ggplot2)

##Creates a bar graph that compares motor vehicle emissions by year for Baltimore and Los Angeles

png('plot6.png', width = 840, height = 480)
g <- ggplot(TtlSubset, aes(factor(year),Emissions))
g <- g + facet_grid(.~ fips)
g <- g + geom_bar(stat = "identity", fill = "blue") + 
    labs(x = "Years") + labs(y = "Emissions PM2.5") + 
    labs(title = "Motor Vehicle Emission Balimore vs Los Angeles")
print(g)
dev.off()
