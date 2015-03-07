#### Plot 1, Project 1, Coursera - Exploratory Data Analysis
#### Date: 7 March 2015
#### Author: Antony Mapfumo

## Set the working directory
setwd("/home/tony/ExData_Plotting1")

## Load data.table library
library(data.table)

## Read the zip data file
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filename <- "household_power_consumption.zip"
download.file(fileUrl, filename, method = "curl")

unzip(filename)
## "household_power_consumption.txt"

data <- fread("household_power_consumption.txt")

# Change format of the date variable
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

# Subset the data for the two dates we are interested in
data_subset <- data[data$Date=="2007-02-01" | data$Date=="2007-02-02"]

# Convert data subset to a data frame
data_subset <- data.frame(data_subset)

# Convert columns to numeric
for(i in c(3:9)) {data_subset[,i] <- as.numeric(as.character(data_subset[,i]))}

# Create Date_Time variable
data_subset$Date_Time <- paste(data_subset$Date, data_subset$Time)

# Convert Date_Time variable to proper format
data_subset$Date_Time <- strptime(data_subset$Date_Time, format="%Y-%m-%d %H:%M:%S")
class(data_subset$Date_Time)

## Plot 3 #########
png(filename = "plot3.png", width = 480, height = 480, units = "px", bg = "white")
par(mar = c(6, 6, 5, 4))
plot(data_subset$Date_Time, data_subset$Sub_metering_1, xaxt=NULL, xlab = "", ylab = "Energy sub metering", type="n")
## Sets up the plot but does not populate with any data
lines(data_subset$Date_Time, data_subset$Sub_metering_1, col = "black", type = "S")
## sub_metering_1 plots
lines(data_subset$Date_Time, data_subset$Sub_metering_2, col = "red", type = "S")
## sub_metering_2 plots
lines(data_subset$Date_Time, data_subset$Sub_metering_3, col = "blue", type = "S")
## sub_metering_3 plots

legend("topright", lty = c(1, 1), lwd = c(1, 1, 1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()