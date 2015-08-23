##This section sets the working directory to the folder
##location where my files are located.

setwd("C:/Users/rsamuel/Datascience Specialization/Exploritory Data Analysis/Course Project 2")

##This reads in the data that will be used for the analysis

NEI <- readRDS("summarySCC_PM25.rds")

##Subsets the data only chosing the Emission, year and fips
##columns, summing the Emissions column by year and fips

TtlEmissionbyYearandfips <- aggregate(NEI["Emissions"],
                                      by = NEI[c("year","fips")],
                                      FUN = sum)

##Loads the dplyr package used for data manipulation

library(dplyr)

##Filters the subsetted data for only Baltimore City's data 
##(24510 represents baltimore city)

BaltimorePM <- filter(TtlEmissionbyYearandfips,fips == 24510)
rm(TtlEmissionbyYearandfips)

#Creates a barplot that compares Emissions by year for Baltimore City.

png('plot2.png')
barplot(height=BaltimorePM$Emissions,names.arg = BaltimorePM$year, 
        xlab = "Years", ylab = "Total PM 2.5 Emission", 
        main = "Baltimore PM 2.5 Emission by year")
dev.off()
