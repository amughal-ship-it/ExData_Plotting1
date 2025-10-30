
https://github.com/amughal-ship-it/ExData_Plotting1


if(!file.exists("household_power_consumption.txt")){
  zip_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(zip_url, destfile = "dataset.zip")
  unzip("dataset.zip")
}


data <- read.table("household_power_consumption.txt",
                   header = TRUE, sep = ";",
                   na.strings = "?", stringsAsFactors = FALSE)

data$Date <- as.Date(data$Date, format="%d/%m/%Y")

subset_data <- subset(data, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

subset_data$Datetime <- strptime(paste(subset_data$Date, subset_data$Time),
                                 format="%Y-%m-%d %H:%M:%S")


#Plot1
png("plot1.png", width=480, height=480)
hist(subset_data$Global_active_power, col="red", 
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")
dev.off()

#Plot2
subset_data$Datetime <- strptime(paste(subset_data$Date, subset_data$Time),
                                 "%Y-%m-%d %H:%M:%S")
png("plot2.png", width=480, height=480)
plot(subset_data$Datetime, subset_data$Global_active_power, 
     type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()

#Plot3

png("plot3.png", width=480, height=480)
plot(subset_data$Datetime, subset_data$Sub_metering_1, type="l", 
     xlab="", ylab="Energy sub metering")
lines(subset_data$Datetime, subset_data$Sub_metering_2, col="red")
lines(subset_data$Datetime, subset_data$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lty=1)
dev.off()


#Plot 4
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))

# Top-left
plot(subset_data$Datetime, subset_data$Global_active_power, type="l",
     xlab="", ylab="Global Active Power")

# Top-right
plot(subset_data$Datetime, subset_data$Voltage, type="l",
     xlab="datetime", ylab="Voltage")

# Bottom-left
plot(subset_data$Datetime, subset_data$Sub_metering_1, type="l",
     xlab="", ylab="Energy sub metering")
lines(subset_data$Datetime, subset_data$Sub_metering_2, col="red")
lines(subset_data$Datetime, subset_data$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lty=1, bty="n")

# Bottom-right
plot(subset_data$Datetime, subset_data$Global_reactive_power, type="l",
     xlab="datetime", ylab="Global_reactive_power")

dev.off()
