##This section sets the working directory to the folder
##location where my files are located.

setwd("C:/Users/rsamuel/Datascience Specialization/Exploritory Data Analysis/Course Project 2")

##This reads in the data that will be used for the analysis

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Merges the 2 datasets on the SCC columns

NEISCC <- merge(NEI,SCC, by.x = "SCC", by.y = "SCC")


##Subsets the merged dataset for Emissions, year, and EI.sector columns,
##summing the Emissions by year and EI.Sector

TtlyrandSector <- aggregate(NEISCC["Emissions"],by = NEISCC[c("year","EI.Sector")], FUN = sum)

##Loads the dplyr package used for data manipulation

library(dplyr)

##Filters the data to only include rows that has "Coal" in the description
##of the EI.Sector column

TtlSubset <- filter(TtlyrandSector, grepl("Coal", EI.Sector))
rm(TtlyrandSector)

##Loads the ggplot2 package for plotting

library(ggplot2)

##Creates a bar graph that compares coal emissions by year in the US.
png('plot4.png')
g <- ggplot(TtlSubset, aes(factor(year),Emissions))
g <- g + geom_bar(stat = "identity", fill = "blue") + 
    labs(x = "Years") + labs(y = "Emissions PM2.5") + 
    labs(title = "Coal Combustion Emissions in the US")
print(g)
dev.off()
