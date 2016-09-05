require(dplyr)

dataFile <- read.table("./exdata_data_household_power_consumption/household_power_consumption.txt", 
                       header=TRUE, sep=";", na.strings = "?",stringsAsFactors=FALSE)

consolData <- as.POSIXlt(strptime(paste(dataFile$Date, dataFile$Time, sep=" "), 
                                  format = "%d/%m/%Y %H:%M:%S"))

datedData <- cbind(consolData, dataFile[,3:9])

names(datedData)[1] <- "Date"

febData <- filter(datedData, Date >= as.POSIXlt("2007-02-01 00:00:00") & 
                      Date < as.POSIXlt("2007-02-03 00:00:00"))

png(file="plot2.png", width = 480, height = 480)
plot(febData$Date, febData$Global_active_power, xlab = "", 
     ylab="Global Active Power (kilowatts)", type="l")
dev.off()