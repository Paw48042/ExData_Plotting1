# Assume that you haven't download the data yet.

# Start with download a file and unzip file in the directory assign it in data frame
download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip', 
              destfile = 'household_power_consumption.zip')
unzip('household_power_consumption.zip') 
DF <- read.table('household_power_consumption.txt', header = TRUE, sep = ";", na.strings = "?")
# Change data types of date and time. and put it into the data frame 

dmy <- as.Date(DF$Date, "%d/%m/%Y")  
DF$Date <- dmy # To filter out date easily
DF$Datetime <- strptime(paste(DF$Date, DF$Time), format="%Y-%m-%d %H:%M:%S")

# Select only the range that we will do analysis 
new_df <- subset.data.frame(DF, Date >= "2007-02-01" & Date <= "2007-02-02") 
# Since we want to get the x axis be like thu - sat, 
start_date <- as.POSIXct("2007-02-01 00:00:00")
end_date <- as.POSIXct("2007-02-03 00:00:00")

# Create a png plot3.png 

png("plot3.png", width = 480, height = 480) 
  # Code here 
  with(new_df, plot(Datetime, Sub_metering_1, type = "n",xlab = "", ylab = "Energy sub metering", xaxt="n"))
  with(new_df, lines(Datetime, Sub_metering_1, col = "black"))
  with(new_df, lines(Datetime, Sub_metering_2, col = "red"))
  with(new_df, lines(Datetime, Sub_metering_3, col = "blue"))
  axis(1, at=seq(start_date, end_date, by="days"), labels=format(seq(start_date, end_date, by="days"), "%a"))
  legend("topright",lwd = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()