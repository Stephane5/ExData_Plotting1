#############################################
## Plot 1 (histogram of Global Active Power)
#############################################

##########################
## Download and read data
##########################

##setwd("~/Developer/DataScience/ExploratoryDataAnalysis")
urlPath <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(urlPath, destfile=temp, method="curl")
data <- read.table(unz(temp,"household_power_consumption.txt"),
                   header=TRUE, sep = ";", na.strings="?", stringsAsFactors=FALSE, dec=".")
unlink(temp)

##########################
## Data cleanup
##########################

data <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007",]
global_active_power <- as.numeric(as.character(data$Global_active_power))
rm(data)

##########################
## Generate plot
##########################

par(mfcol = c(1,1))
hist(global_active_power, col="red", freq = TRUE, main="Global Active Power", xlab = "Global Active Power (kilowatts)")

##########################
## Save plot
##########################

dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()

