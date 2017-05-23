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

png(filename = "plot1.png",width = 480, height = 480)
hist(data2$Global_active_power,breaks = 12,col = "red",main = "Global Active Power",xlab = "Global Active Power (kilowatts)")
dev.off()