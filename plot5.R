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

##Filters the data to only include information for Baltimore City
##(represented by 24510 in the fips column), and rows that has "On-Road" in the description
##of the EI.Sector column to get only motor vehicle Emissions

TtlSubset <- filter(TtlyrfipsandSector, grepl("On-Road", EI.Sector))
TtlSubset <- filter(TtlSubset, fips == 24510)
TtlSubset <- TtlSubset %>% group_by(year) %>% summarise(Emissions = sum(Emissions))
rm(TtlyrfipsandSector)

##Loads the ggplot2 package for plotting

library(ggplot2)

##Creats a bar graph that compares Baltimore motor vehicle emissions by year

png('plot5.png')
g <- ggplot(TtlSubset, aes(factor(year),Emissions))
g <- g + geom_bar(stat = "identity", fill = "blue") + 
    labs(x = "Years") + labs(y = "Emissions PM2.5") + 
    labs(title = "Motor Vehicle Emissions in the Baltimore")
print(g)
dev.off()
