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
png(file="plot1.png", width = 480, height = 480)
par(mar= c(4,4,1,0), oma= c(0,1,0,1))
hist(HPCfiltered$Global_active_power, col = "red", 
     main = "Global Active Power", xlab = "Global Active Power (kilowatts)", 
     ylim = c(0,1200))
dev.off()