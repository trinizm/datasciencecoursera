## Plot2
## X - DateTime; Y - Global Active Power
## Set the working directory where the datafile is

library(sqldf)
# Create a subset of the data with the required dates
hpc <- "./household_power_consumption.txt"
sub_sql <- "select * from file where Date = '1/2/2007' OR Date = '2/2/2007'"
dt <- read.csv.sql(file = hpc, sql = sub_sql, header = T, sep = ";")

# Save the output to a png file
png(filename="plot2.png", width=480, height=480, units="px")

# Create a plot
par(pty = "s")
plot(as.POSIXct(paste(dt$Date, dt$Time), format = "%d/%m/%Y %H:%M:%S"), 
     dt$Global_active_power, 
     ylim = c(0,max(dt$Global_active_power)+1), 
     type = "l", cex.axis=1,
     ylab = "Global Active Power (kilowatts)", xlab = "DateTime", 
     main = "Global Active Power")
title("Plot2", line=3, font=2, cex=1.2, adj=0)
dev.off()