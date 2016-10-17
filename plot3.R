############## R Script to create Plot 3 ############## 

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

## Create plot
    par(mfrow=c(1,1))
    plot(epcData$timestamp, epcData$Sub_metering_1, type="l", ylab="Energy sub metering", xlab ="")
    lines(epcData$timestamp, epcData$Sub_metering_2, type="l", col="red")
    lines(epcData$timestamp, epcData$Sub_metering_3, type="l", col="blue")
    legend("topright", lty=c(1, 1, 1), cex=.8, col=c("black","red","blue"),
            legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
    
## Copy plot to PNG file device
    dev.copy(png, file = "plot3.png", width=480, height=480)
    dev.off()