library(data.table)
data <- read.table(file = "household_power_consumption.txt",header = TRUE,sep = ";",na.strings = "?")
data$Date <- as.Date(data$Date,format = "%d/%m/%Y")
data <- subset(data,Date >= "2007-02-01" & Date <= "2007-02-02")
data$datetime <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")
data$datetime <- as.POSIXct(data$datetime)
par(mfrow = c(2,2))
with(data, plot(datetime,Global_active_power,type = "l",xlab = "",ylab = "Global Active Power (kilowatts)"))
with(data, plot(datetime,Voltage,type = "l",xlab = "datetime",ylab = "Voltage", col = "black"))
plot(data$datetime,data$Sub_metering_1,ylab = "Energy Sub Metering",xlab = "",type = "l",col = "black")
lines(data$datetime,data$Sub_metering_2, col = "red")
lines(data$datetime,data$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
plot(data$datetime,data$Global_reactive_power,xlab = "datetime",ylab = "Global_reactive_power",type = "l")
dev.copy(device = png,file = "plot4.png",width = 480 , height = 480)
dev.off()