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

# Create a png with name plot1.png
png("plot1.png", width = 480, height = 480)

  hist(
    new_df$Global_active_power, 
    freq = TRUE, 
    main = paste("Global active power"),
    xlab = paste("Global active power(kilowatts)"), 
    col = "red"
    )

dev.off()