#libraries

library(rstudioapi)
library(dplyr)
library(lubridate)
library(ggplot2)
library(gridExtra)

#setting path and default langauage (so that weekdays are displayed in english)
myDir = unlist(strsplit(rstudioapi::getActiveDocumentContext()$path, '/'))
path0 = paste0(myDir[seq_len(length(myDir)-1)], collapse = '/')
# Set the system locale to English (weekdays are displayed in english)
Sys.setlocale("LC_TIME", "English_United States.1252")

#load and arrange data
my_data <- read.table(paste0(path0,"/household_power_consumption.txt"), header = TRUE, sep = ";")
# Convert a date variable to Date format
my_data$Date <- as.Date(my_data$Date, format = "%d/%m/%Y")
data_final <- my_data %>% 
  filter(Date %in% as.Date(c("2007-02-01", "2007-02-02")))


#arrange data for plot1
data_final$Global_active_power=as.numeric(data_final$Global_active_power)
#arrange data for plot2
# convert the date and time variables to a datetime format
data_final$Datetime <- as.POSIXct(paste(data_final$Date, data_final$Time), format = "%Y-%m-%d %H:%M:%S")

#arrange data for plot3
data_final$Sub_metering_1=as.numeric(data_final$Sub_metering_1)
data_final$Sub_metering_2=as.numeric(data_final$Sub_metering_2)

#arrange data for plot4
data_final$Voltage=as.numeric(data_final$Voltage)
data_final$Global_reactive_power=as.numeric(data_final$Global_reactive_power)

#define plots
plot1<-hist(data_final$Global_active_power, col="red",xlab="Global_active_power(kilowatts)",main="Global Active Power")





# create  PNG files:

#plot1
png("plot1.png", width=800, height=600, res=72)
# Create the histogram with adjusted margins
par(mar = c(5, 4, 4, 2) + 0.1)
hist(data_final$Global_active_power, col="red",xlab="Global_active_power(kilowatts)",main="Global Active Power")

# Save the plot to the PNG file
dev.off()


