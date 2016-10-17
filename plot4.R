############## R Script to create Plot 4 ############## 

## Download the data
    # if(!file.exists("./data")) {dir.create("./data")}
    # fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    # download.file(fileUrl, destfile = "./data/household_power_consumption.zip")
    # unzip(zipfile="./data/household_power_consumption.zip",exdir="./data")

## Read and Subset Data
    fullDataset <- read.table("./data/household_power_consumption.txt", sep=";", header=TRUE)
    fullDataset$Date <- strptime(fullDataset$Date, "%d/%m/%Y")
    epcData <- subset(fullDataset, Date >= "2007-02-01" & Date <= "2007-02-02")
    
## Clean and reformat data
    epcData$Global_active_power <- as.numeric(as.character(epcData$Global_active_power))
    epcData$Global_reactive_power <- as.numeric(as.character(epcData$Global_reactive_power))
    epcData$Voltage <- as.numeric(as.character(epcData$Voltage))
    epcData$Global_intensity <- as.numeric(as.character(epcData$Global_intensity))
    epcData$Sub_metering_1 <- as.numeric(as.character(epcData$Sub_metering_1))
    epcData$Sub_metering_2 <- as.numeric(as.character(epcData$Sub_metering_2))
    epcData$Sub_metering_3 <- as.numeric(as.character(epcData$Sub_metering_3))
    epcData <- within(epcData, { timestamp=format(as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S") })
    epcData$timestamp <- strptime(epcData$timestamp, "%d/%m/%Y %H:%M:%S")

## Create plot area
    par(mfrow=c(2,2))

## Create plot 1 (Top Left)
    plot(epcData$timestamp, epcData$Global_active_power, type="l", ylab="Global Active Power", xlab ="")

## Create plot 2 (Top Right)
    plot(epcData$timestamp, epcData$Voltage, type="l", ylab="Voltage", xlab="datetime")

## Create plot 3 (Bottom Left)
    plot(epcData$timestamp, epcData$Sub_metering_1, type="l", ylab="Energy sub metering", xlab ="")
    lines(epcData$timestamp, epcData$Sub_metering_2, type="l", col="red")
    lines(epcData$timestamp, epcData$Sub_metering_3, type="l", col="blue")
    legend("topright", bty="n", lty=c(1, 1, 1), cex=.4, col=c("black","red","blue"),
            legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  
## Create plot 4 (Bottom Right)
    plot(epcData$timestamp, epcData$Global_reactive_power, type="l", 
            ylab="Global_reactive_power", xlab="datetime")
    
    
## Copy plot to PNG file device
    dev.copy(png, file = "plot4.png", width=480, height=480)
    dev.off()