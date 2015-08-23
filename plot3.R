##This section sets the working directory to the folder
##location where my files are located.

setwd("C:/Users/rsamuel/Datascience Specialization/Exploritory Data Analysis/Course Project 2")

##This reads in the data that will be used for the analysis

NEI <- readRDS("summarySCC_PM25.rds")

##Subsets the data only chosing the Emission, year, fips and type
##columns, summing the Emissions column by year, fips and type

TtlEmissionbyYearandfips <- aggregate(NEI["Emissions"],
                                      by = NEI[c("year","fips","type")],
                                      FUN = sum)

##Loads the dplyr package used for data manipulation

library(dplyr)

##Filters the subsetted data for only Baltimore City's data 
##(24510 represents baltimore city)

BaltimorePMbytype <- filter(TtlEmissionbyYearandfips,fips == 24510)
rm(TtlEmissionbyYearandfips)

##Loads the ggplot2 package for plotting

library(ggplot2)

#Creates a plot that compares Emissions by year and type for Baltimore City.

png('plot3.png', width = 740, height = 480)
qplot(year,Emissions, data = BaltimorePMbytype, color = type, facets = .~type, 
      geom = c("point","smooth"), method = "lm", xlab = "Emissions PM2.5", ylab = "Years",
      main = "Baltimore Emissions by Type")
dev.off()
