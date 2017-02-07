household_power_consumption

# reading the input file 
HPCtotal <- read.table("household_power_consumption.txt", sep = ";", 
                       header = TRUE, na.strings = "?")
# filtering by date (I assume Feb-1 and Feb-2 of 2007)
HPCfiltered <- filter(HPCtotal, Date == "1/2/2007" | Date == "2/2/2007")
# creating a backup file
HPCbackup <- HPCfiltered
# formatting date and time
HPCfiltered$Time <- as.POSIXct(paste(HPCfiltered$Date,HPCfiltered$Time),
                               format= "%d/%m/%Y %H:%M:%S")
HPCfiltered$Date <- as.Date(HPCfiltered$Date, "%d/%m/%Y")

