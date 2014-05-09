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
hist(mydata$Global_active_power, col='red', main='Global Active Power', xlab='Global Active Power (kilowatts)')
# default dimension is 480x480 already
dev.copy(png, 'plot1.png')
dev.off()
