############################################################
# Preparation work, only need to do it once: 
#   set directory, download file, unzip it and understand content
# setwd('...')
# download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip', 'exdata_data_household_power_consumption.zip', method='wget')
# unzip('exdata_data_household_power_consumption.zip')
# readLines(file('household_power_consumption.txt'),5)
# read data, try subset first
mydata <- read.table('household_power_consumption.txt', header=T, sep=";", nrows=10000)
str(mydata)
# found '?' as a factor value for numeric columns, treat them as NA
mydata <- read.table('household_power_consumption.txt', header=T, sep=';', na.strings='?', nrows=10000)
# try to transform date and time columns
mydata <- transform(mydata, Time=strptime(paste(as.character(Date),Time), '%d/%m/%Y %H:%M:%S'), Date=as.Date(as.character(Date),'%d/%m/%Y'))
str(mydata)

############################################################
# Main code

# read full data set
mydata <- read.table('household_power_consumption.txt', header=T, sep=";", na.strings="?")
mydata <- transform(mydata, Time=strptime(paste(as.character(Date),Time), '%d/%m/%Y %H:%M:%S'), Date=as.Date(as.character(Date),'%d/%m/%Y'))
# subset
mydata <- subset(mydata, Date >= as.Date('2007-02-01') & Date <= as.Date('2007-02-02'))
str(mydata)

# create panels 2x2
par(mar=c(5,4,4,2))
par(mfcol=c(2,2))

# top left
with(mydata, plot(Time, Global_active_power, type='l', xlab='', ylab='Global Active Power'))

# bottom left
with(mydata, plot(Time, Sub_metering_1, type='l', xlab='', ylab='Energy sub metering'))
with(mydata, lines(Time, Sub_metering_2, type='l', col='red'))
with(mydata, lines(Time, Sub_metering_3, type='l', col='blue'))
legend('topright',c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),lty=c(1,1,1), col=c('black','red','blue'), pt.cex=1, cex=0.8, bty='n')

# top right
with(mydata, plot(Time, Voltage, type='l', xlab='datetime'))

# bottom right
with(mydata, plot(Time, Global_reactive_power, type='l', xlab='datetime'))

dev.copy(png, 'plot4.png')
dev.off()
par(mfrow=c(1,1))
