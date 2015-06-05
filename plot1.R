## Plot1
## Histogram for Global Active Power
## Set the working directory where the datafile is

library(sqldf)

# Create a subset of the data with the required dates
hpc <- "./household_power_consumption.txt"
sub_sql <- "select * from file where Date = '1/2/2007' OR Date = '2/2/2007'"
dt <- read.csv.sql(file = hpc, sql = sub_sql, header = T, sep = ";")

# Save the output to a png file
png(filename="plot1.png", width=480, height=480, units="px")

# Create a histogram
par(pty = "s")
hist(dt$Global_active_power, col = "red", 
     xlab = "Global Active Power \n(kilowatts)", 
     main = "Global Active Power", cex.axis=0.8)
mtext("Plot1", line=3, font=2, cex=1.2)
dev.off()