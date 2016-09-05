require(dplyr)

dataFile <- read.table("./exdata_data_household_power_consumption/household_power_consumption.txt", 
                       header=TRUE, sep=";", na.strings = "?",stringsAsFactors=FALSE)

consolData <- as.POSIXlt(strptime(paste(dataFile$Date, dataFile$Time, sep=" "), 
                                  format = "%d/%m/%Y %H:%M:%S"))
datedData <- cbind(consolData, dataFile[,3:9])
names(datedData)[1] <- "Date"
febData <- filter(datedData, Date >= as.POSIXlt("2007-02-01 00:00:00") & 
                      Date < as.POSIXlt("2007-02-03 00:00:00"))


# Plots
png(file="plot4.png", width = 480, height = 480)
par(mfcol = c(2, 2)) # plot by col
# topleft plot
plot(febData$Date, febData$Global_active_power, xlab = "", 
     ylab="Global Active Power (kilowatts)", type="l")
# bottomleft plot
plot(febData$Date, febData$Sub_metering_1, xlab = "", ylab="Energy sub metering", type="l")
points(febData$Date, febData$Sub_metering_2, type="l", col="red")
points(febData$Date, febData$Sub_metering_3, type="l", col="blue")
legend("topright", pch='____', col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# topright plot
plot(febData$Date, febData$Voltage, xlab = "datetime", ylab="Voltage", type="l")
# bottomright plot
plot(febData$Date, febData$Global_reactive_power, xlab = "datetime", 
     ylab="Global_reactive_power", type="l")

dev.off()