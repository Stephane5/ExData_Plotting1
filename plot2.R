#############################################
## Plot 2 (Global Active Power x date)
#############################################

##########################
## Download and read data
##########################

## setwd("~/Developer/DataScience/ExploratoryDataAnalysis")
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
date_and_time <- paste(as.character(data$Date),as.character(data$Time),sep=" ")
date_and_time <- strptime(date_and_time,"%d/%m/%Y %H:%M:%S")
global_active_power <- as.numeric(as.character(data$Global_active_power))
rm(data)

##########################
## Generate plot
##########################
par(mfcol = c(1,1))
plot(date_and_time, global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

##########################
## Save plot
##########################

dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
