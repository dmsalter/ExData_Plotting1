## The following code recreates Plot 4 of Assignment 1

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

## Make four separate plot regions
par(mfrow=c(2,2))

## Make upper left corner plot (plot2.R)
ylab <- "Global Active Power"
plot(as.POSIXct(ndates),as.numeric(pdata[,3]),type="l",ylab=ylab,xlab="",xaxt="n")
r <- as.POSIXct(round(range(ndates),"days"))
axis.POSIXct(1,ndates,at=seq(r[1],r[2],by="days"),labels=weekdays(seq(r[1],r[2],by="days"),abbreviate=TRUE),format="%a")

## Make upper right corner plot 
xlab <- "datetime"
ylab <- "Voltage"
plot(as.POSIXct(ndates),as.numeric(pdata[,5]),type="l",ylab=ylab,xlab=xlab,xaxt="n")
r <- as.POSIXct(round(range(ndates),"days"))
axis.POSIXct(1,ndates,at=seq(r[1],r[2],by="days"),labels=weekdays(seq(r[1],r[2],by="days"),abbreviate=TRUE),format="%a")

## Make lower left corner plot (plot3.R)
ylab <- "Energy sub metering"
plot(as.POSIXct(ndates),as.numeric(pdata[,7]),type="l",ylab=ylab,xlab="",xaxt="n")
lines(as.POSIXct(ndates),as.numeric(pdata[,8]),col="red")
lines(as.POSIXct(ndates),as.numeric(pdata[,9]),col="blue")
r <- as.POSIXct(round(range(ndates),"days"))
axis.POSIXct(1,ndates,at=seq(r[1],r[2],by="days"),labels=weekdays(seq(r[1],r[2],by="days"),abbreviate=TRUE),format="%a")
legend("topright",names(pdata[7:9]),col=c(1,"red","blue"),lwd=2,bty="n",y.intersp=0.5,xjust=1,cex=0.7)

## Make lower right corner plot
xlab <- "datetime"
ylab <- names(pdata[4])
plot(as.POSIXct(ndates),as.numeric(pdata[,4]),type="l",ylab=ylab,xlab=xlab,xaxt="n")
r <- as.POSIXct(round(range(ndates),"days"))
axis.POSIXct(1,ndates,at=seq(r[1],r[2],by="days"),labels=weekdays(seq(r[1],r[2],by="days"),abbreviate=TRUE),format="%a")

## Copy plot to png plotting device
dev.copy(png,file="./plot4.png",width=480,height=480)
dev.off()
