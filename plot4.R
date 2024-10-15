dmy <- as.Date(DF$Date, "%d/%m/%Y")  
DF$Date <- dmy # To filter out date easily
DF$Datetime <- strptime(paste(DF$Date, DF$Time), format="%Y-%m-%d %H:%M:%S")

# Select only the range that we will do analysis 
new_df <- subset.data.frame(DF, Date >= "2007-02-01" & Date <= "2007-02-02") 
# Since we want to get the x axis be like thu - sat, 
start_date <- as.POSIXct("2007-02-01 00:00:00")
end_date <- as.POSIXct("2007-02-03 00:00:00")

# Create a png plot4.png 
png("plot4.png", width = 480, height = 480)
  par(mfrow = c(2,2))
  # first pic
  plot(new_df$Datetime, new_df$Global_active_power, type="l",xlab = "", ylab="Global Active Power (kilowatts)", xaxt="n")  
  axis(1, at=seq(start_date, end_date, by="days"), labels=format(seq(start_date, end_date, by="days"), "%a")) 
  
  # second pic 
  plot(new_df$Datetime, new_df$Voltage, type="l",xlab = "datetime", ylab="Voltage", xaxt="n")  
  axis(1, at=seq(start_date, end_date, by="days"), labels=format(seq(start_date, end_date, by="days"), "%a")) 
  
  # third pic 
  with(new_df, plot(Datetime, Sub_metering_1, type = "n",xlab = "", ylab = "Energy sub metering", xaxt="n"))
  with(new_df, lines(Datetime, Sub_metering_1, col = "black"))
  with(new_df, lines(Datetime, Sub_metering_2, col = "red"))
  with(new_df, lines(Datetime, Sub_metering_3, col = "blue"))
  axis(1, at=seq(start_date, end_date, by="days"), labels=format(seq(start_date, end_date, by="days"), "%a"))
  legend("topright",lwd = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")) 
  
  # fourth pic 
  plot(new_df$Datetime, new_df$Global_reactive_power, type="l",xlab = "datetime", ylab="Global_reactive_power", xaxt="n")  
  axis(1, at=seq(start_date, end_date, by="days"), labels=format(seq(start_date, end_date, by="days"), "%a")) 
  
dev.off()