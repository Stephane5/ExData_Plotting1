#############################################
## Plot 4 (Pot pourri)
#############################################

##########################
## Download and read data
##########################

zdesetwd("~/Developer/DataScience/ExploratoryDataAnalysis")
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
global_reactive_power <- as.numeric(as.character(data$Global_reactive_power))
voltage <- as.numeric(as.character(data$Voltage))
sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1))
sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2))
sub_metering_3 <- as.numeric(as.character(data$Sub_metering_3))
rm(data)

##########################
## Generate plot
##########################

par(mfcol = c(2,2))
plot(date_and_time, global_active_power, type="l", xlab="", ylab="Global Active Power")

plot(date_and_time, sub_metering_1, type="l", ylab="Energy Submetering", col="black", xlab="")
lines(date_and_time, sub_metering_2, type="l", col="red")
lines(date_and_time, sub_metering_3, type="l", col="blue")
legend("top", c("Sub_metring_1", "Sub_metring_2", "Sub_metring_3"), lwd=2,
       col=c("black", "red", "blue"), bty="n")

plot(date_and_time, voltage, type="l", xlab="datetime", ylab="Voltage")

plot(date_and_time, global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

##########################
## Save plot
##########################

dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()

