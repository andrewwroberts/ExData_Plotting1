#Initiate Needed Libraries
library(data.table)
library(dplyr)
library(tidyr)

#Set working directory
setwd("./ExData_Plotting1")

#Download data if necessary
if(!file.exists("exdata-data-household_power_consumption.zip")) {
       temp <- tempfile()
       download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
       file <- unzip(temp)
       unlink(temp)
}

#Read in data
power1 <- fread("./household_power_consumption.txt",na.strings="?")

#Convert to data table
power2 <-tbl_df(power1)

#Filter out unused data, convert Date and Time variables to datetime variable (POSIX)
power <- filter(power2,Date == '1/2/2007' | Date == '2/2/2007') %>% unite(DateTime,Date,Time,sep=" ") %>% 
       mutate(datetime=as.POSIXct(strptime(DateTime,format="%d/%m/%Y %H:%M:%S"))) %>% select(-DateTime)

#Create PNG file
dev.print(png,file="plot3.png",width=480, height=480)
png(file="plot3.png",bg="white")

#Plot 3
with(power,plot(datetime,Sub_metering_1,type="l",ylab="Energy sub metering",xlab=" "))
with(power,lines(datetime,Sub_metering_2,col="red"))
with(power,lines(datetime,Sub_metering_3,col="blue"))
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),col=c("black","red","blue"))

#Close PNG file
dev.off()