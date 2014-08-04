getwd()
##Primero leemos el conjunto de datos
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


######PLOT1
hist(EPC_fin$Global_active_power, col="Red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.copy(png, file="plot1.png",width=480, height=480)
dev.off()