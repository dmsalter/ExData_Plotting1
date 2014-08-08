## The following code recreates Plot 1 of Assignment 1

## Read in the data set
power <- read.table("./household_power_consumption.txt",sep=";",header=TRUE,colClasses="character",na.strings="NA")

## Subset the data for the relevant February 2007 dates
days <- power$Date == "1/2/2007" | power$Date == "2/2/2007"
pdata <- subset(power,days,drop=TRUE)

## Make a histogram plot of column 3
xlab <- "Global Active Power (kilowatts)"
title <- "Global Active Power"
hist(as.numeric(pdata[,3]),col="red",xlab=xlab,main=title)

## Copy plot to png plotting device
dev.copy(png,file="./plot1.png",width=480,height=480)
dev.off()
