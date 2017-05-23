require(downloader)

download("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",dest="powerconsumption.zip", mode="wb")
unzip("powerconsumption.zip",exdir ="./")

classes <- c("Date", "Time", rep("numeric", 7))
data1 <- read.table("household_power_consumption.txt",sep = ";",header = TRUE,na.strings = "?")
data2 <- data1[grepl("^1/2/2007",data1$Date) | grepl("^2/2/2007",data1$Date),]
data2$Date <- as.Date(data2$Date, format ="%d/%m/%Y")
datetime <- paste(data2$Date,as.character(data2$Time))
datetime <- strptime(x, "%Y-%m-%d %H:%M:%S")
data2 <- cbind(datetime,data2)

png(filename = "plot4.png",width = 480, height = 480)
par(mfcol=c(2,2))
plot(data2$datetime, data2$Global_active_power,type ="n",xlab = "",ylab= "Global Active Power (kilowatts)")
lines(data2$datetime, data2$Global_active_power)

plot(data2$datetime, data2$Sub_metering_1, type ="n",xlab = "",ylab= "Energy sub metering")
lines(data2$datetime, data2$Sub_metering_1, col = "black")
lines(data2$datetime, data2$Sub_metering_2, col = "red")
lines(data2$datetime, data2$Sub_metering_3, col = "blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty = 1,cex=0.75)

plot(data2$datetime, data2$Voltage,type ="n",xlab = "datetime",ylab= "Voltage")
lines(data2$datetime, data2$Voltage)

plot(data2$datetime, data2$Global_reactive_power,type ="n",xlab = "datetime",ylab = "Global_reactive_power")
lines(data2$datetime, data2$Global_reactive_power)
dev.off()