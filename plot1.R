##This section sets the working directory to the folder
##location where my files are located.

setwd("C:/Users/rsamuel/Datascience Specialization/Exploritory Data Analysis/Course Project 2")

##This reads in the data that will be used for the analysis

NEI <- readRDS("summarySCC_PM25.rds")

##Subsets the data only chosing the Emission and year 
##columns, summing the Emissions column by year
TtlEmissionbyYear <- aggregate(Emissions~year,NEI,sum)

##Creates a barplot that compares Emissions by year in the US
png('plot1.png')
barplot(height=TtlEmissionbyYear$Emissions,names.arg = TtlEmissionbyYear$year, 
        xlab = "Years", ylab = "Total PM 2.5 Emission", 
        main = "Total PM 2.5 Emission by year")
dev.off()
