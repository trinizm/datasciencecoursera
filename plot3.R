## Plot3
## Plot energy usage from three sub-meters over two days
## Set the working directory where the datafile is
  
  library(sqldf)
  # Create a subset of the data with the required dates
  hpc <- "./household_power_consumption.txt"
  sub_sql <- "select * from file where Date = '1/2/2007' OR Date = '2/2/2007'"
  dt <- read.csv.sql(file = hpc, sql = sub_sql, header = T, sep = ";")
  
  # Save the output to a png file
  png(filename="plot3.png", width=480, height=480, units="px")
  
  # Create a plot for three energy sub-metering variables
  par(pty = "s")
  plot(as.POSIXct(paste(dt$Date, dt$Time), format = "%d/%m/%Y %H:%M:%S"), 
     dt$Sub_metering_1, 
     ylim = c(0,max(dt$Sub_metering_1)+1), 
     type = "l", col = "black", cex.axis=1,
     ylab = "Energy sub metering", 
     xlab = "DateTime", main = "Plot3")
  lines(as.POSIXct(paste(dt$Date, dt$Time), format = "%d/%m/%Y %H:%M:%S"), 
      dt$Sub_metering_2, col = "red")
  lines(as.POSIXct(paste(dt$Date, dt$Time), format = "%d/%m/%Y %H:%M:%S"), 
      dt$Sub_metering_3, col = "blue")
  legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), 
       lty = 1, cex=0.8)
  dev.off()