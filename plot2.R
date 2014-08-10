# download and unzip
getpowerdata <- function() {
    # download and unzip
    if(!file.exists("household_power_consumption.txt")) {
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "hhpower.zip")
        unzip("hhpower.zip")
    }
    # read data
    hhpower <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", nrows = 1000)
    classes <- sapply(hhpower, class)
    hhpower <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", colClasses = classes)
    # convert to proper data type
    hhpower$DateTime <- paste(hhpower$Date, hhpower$Time)
    hhpower$DateTime <- strptime(hhpower$DateTime, "%d/%m/%Y %H:%M:%S")
    hhpower$Date <- as.Date(hhpower$Date, "%d/%m/%Y")
    # Filter data
    filter = hhpower$Date == as.Date("2007-02-01") | hhpower$Date == as.Date("2007-02-02")
    hhwork <- hhpower[filter,]
    hhwork
}
if (! exists("hhwork")) {
    hhwork <- getpowerdata()
}
# plot 2
png(filename = "plot2.png")
with(hhwork, plot(DateTime, Global_active_power, ylab="Global Active Power (kilowatts)", type = "l", xlab=""))
dev.off()