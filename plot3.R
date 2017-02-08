## reading and formatting the input
library(data.table)
setwd("~/ScriptsR/HPC")
# reading the input file 
HPCtotal <- read.table("household_power_consumption.txt", sep = ";",
                       header = TRUE, na.strings = "?")
# filtering by date
HPCfiltered <- filter(HPCtotal, Date == "1/2/2007" | Date == "2/2/2007")
# creating a backup file
HPCbackup <- HPCfiltered
# formatting date and time
HPCfiltered$Time <- as.POSIXct(paste(HPCfiltered$Date,HPCfiltered$Time),
                               format= "%d/%m/%Y %H:%M:%S")
HPCfiltered$Date <- as.Date(HPCfiltered$Date, "%d/%m/%Y")
## creating the plot
png(file="plot3.png", width = 480, height = 480)
par(mar= c(3,4,0,0), oma= c(0,1,1,1))
plot(HPCfiltered$Time, HPCfiltered$Sub_metering_1,xaxt="n", 
     ylab = "Energy Sub Metering", xlab = "", type = "l", col = "BLACK", xaxt="n", 
     ylim = c(0,40))
par(new=T)
plot(HPCfiltered$Time, HPCfiltered$Sub_metering_2, xaxt="n", 
     ylab = "", xlab = "", type = "l", col = "RED", xaxt="n", ylim = c(0,40))
par(new=T)
plot(HPCfiltered$Time, HPCfiltered$Sub_metering_3, xaxt="n", 
     ylab = "", xlab = "", type = "l", col = "BLUE", xaxt="n", ylim = c(0,40))
DataMin <- as.Date(min(HPCfiltered$Time))
DataMax <- as.Date(max(HPCfiltered$Time))+1
# in portuguese "qui" stands for "Thu", "sex" for "Fri" and "sáb" for "Sat"
axis.POSIXct(1, at=seq(DataMin, DataMax, by="1 day"), format="%a")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), 
       lty = c(1,1), col = c("BLACK", "RED", "BLUE"))
dev.off()