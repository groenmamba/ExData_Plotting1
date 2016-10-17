############## R Script to create Plot 1 ############## 

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
    
## Create plot
    par(mfrow=c(1,1))
    hist(epcData$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
    
## Copy plot to PNG file device
    dev.copy(png, file = "plot1.png", width=480, height=480)
    dev.off()