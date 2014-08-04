getwd()
##Primero leemos el conjunto de datos
setwd("C:/Users/lorena/Desktop/Coursera")
EPC <- read.table("./household_power_consumption.txt", sep=";", header=TRUE, dec=".", na.strings = "?") 

head(EPC)

##Segundo convertimos la  variable Date en Fecha en el campo Date2
library(lubridate)
EPC$Date<-dmy(EPC$Date)
EPC$Date<-as.Date(EPC$Date)

EPC$DateTime <- strptime(paste(EPC$Date,EPC$Time), "%d/%m/%Y %H:%M:%S")  

EPC$Global_active_power<-as.numeric(sub(",", ".",EPC$Global_active_power),na.rm = TRUE)
EPC$Global_reactive_power<-as.numeric(sub(",", ".",EPC$Global_reactive_power),na.rm = TRUE)

##Tercero, nos quedamos s??lo con los datos desde 2007/01/01 hasta 2007/02/02
EPC_fin<-EPC[(EPC$Date>="2007-02-01" & EPC$Date<="2007-02-02") ,]

head(EPC_fin)

######PLOT3
plot(EPC_fin$DateTime, EPC_fin$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering") 
points(EPC_fin$DateTime, EPC_fin$Sub_metering_1, col="black", type="l")
points(EPC_fin$DateTime, EPC_fin$Sub_metering_2, col="red", type="l")
points(EPC_fin$DateTime, EPC_fin$Sub_metering_3, col="blue", type="l")
legend("topright", pch="_", col=c("black","red","blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),adj = c(0, 0.5))
dev.copy(png, file="plot3.png",width=480, height=480)
dev.off()
