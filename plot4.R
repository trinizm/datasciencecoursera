## Plot4
## Combine multiple plots into one graph
## Set the working directory where the datafile is
    
  library(sqldf)
  # Create a subset of the data with the required dates
  hpc <- "./household_power_consumption.txt"
  sub_sql <- "select * from file where Date = '1/2/2007' OR Date = '2/2/2007'"
  dt <- read.csv.sql(file = hpc, sql = sub_sql, header = T, sep = ";")
  
  # Save the output to a png file
  png(filename="plot4.png", width=480, height=480, units="px")

  #Layout parameters  
  par(pty = "m",
      mfrow = c(2,2),
      mai=c(0,0,0,0), 
      oma=c(1,0.5,2,0.5), 
      mar=c(4,5,2,1.5))
    
#1st plot
  plot(as.POSIXct(paste(dt$Date, dt$Time), format = "%d/%m/%Y %H:%M:%S"), 
     dt$Global_active_power, 
     ylim = c(0,max(dt$Global_active_power)+1), 
     type = "l", cex.axis=1,
     ylab = "Global Active Power", xlab = "DateTime" )

#2nd plot
  plot(as.POSIXct(paste(dt$Date, dt$Time), format = "%d/%m/%Y %H:%M:%S"), 
     dt$Voltage, 
     ylim = c(min(dt$Voltage)-1,max(dt$Voltage)+1), 
     type = "l", cex.axis=1,
     ylab = "Voltage", xlab = "DateTime")

#3rd plot
  plot(as.POSIXct(paste(dt$Date, dt$Time), format = "%d/%m/%Y %H:%M:%S"), 
     dt$Sub_metering_1, 
     ylim = c(0,max(dt$Sub_metering_1)+1), 
     type = "l", col = "black", cex.axis=1,
     ylab = "Energy Sub Metering", 
     xlab = "DateTime" )
  lines(as.POSIXct(paste(dt$Date, dt$Time), format = "%d/%m/%Y %H:%M:%S"), 
      dt$Sub_metering_2, col = "red")
  lines(as.POSIXct(paste(dt$Date, dt$Time), format = "%d/%m/%Y %H:%M:%S"), 
      dt$Sub_metering_3, col = "blue")
  legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), 
       lty = 1, bty = "n", cex = 0.8)

#4th plot
  plot(as.POSIXct(paste(dt$Date, dt$Time), format = "%d/%m/%Y %H:%M:%S"), 
     dt$Global_reactive_power, 
     ylim = c(min(dt$Global_reactive_power),max(dt$Global_reactive_power)), 
     type = "l", cex.axis=1,
     ylab = "Global Reactive Power", 
     xlab = "DateTime")

#Main title
mtext("Plot4", side=3, line=-1, outer=TRUE, cex=1.5, font=2)
dev.off()