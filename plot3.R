## The following code recreates Plot 3 of Assignment 1

## Read in the data set
power <- read.table("./household_power_consumption.txt",sep=";",header=TRUE,colClasses="character",na.strings="NA")

## Subset the data for the relevant February 2007 dates
days <- power$Date == "1/2/2007" | power$Date == "2/2/2007"
pdata <- subset(power,days,drop=TRUE)

## Convert Date and Time columns to one string
wdays <- weekdays(as.Date(pdata[,1],format="%d/%m/%Y"),abbreviate=TRUE)
cals <- as.Date(pdata[,1],format="%d/%m/%Y")
dates <- format(paste(wdays,cals,pdata[,2]),format="%a %Y-%m-%d %X")
ndates <- as.POSIXct(dates,tz="",format="%a %Y-%m-%d %X")

## Make line plots of each sub metering value
ylab <- "Energy sub metering"
plot(as.POSIXct(ndates),as.numeric(pdata[,7]),type="l",ylab=ylab,xlab="",xaxt="n")
lines(as.POSIXct(ndates),as.numeric(pdata[,8]),col="red")
lines(as.POSIXct(ndates),as.numeric(pdata[,9]),col="blue")

## Create the labels for the x axis
r <- as.POSIXct(round(range(ndates),"days"))
axis.POSIXct(1,ndates,at=seq(r[1],r[2],by="days"),labels=weekdays(seq(r[1],r[2],by="days"),abbreviate=TRUE),format="%a")

## Create the legend
legend("topright",names(pdata[7:9]),col=c(1,"red","blue"),lwd=2,cex=0.7)

## Copy plot to png plotting device
dev.copy(png,file="./plot3.png",width=480,height=480)
dev.off()
