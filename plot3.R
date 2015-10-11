## This script creates a png file for one line plot of sub-metering readings across a 
## two-day period based on the Household Power Consumption dataset. It is assumed that the
## dataset has already been downloaded and unzipped in the user's home directory.


# READING THE DATA

# Read dataset into R from text file (the semicolon variant of csv)
data <- read.csv2("./household_power_consumption.txt", na.strings = "?")


# PROCESSING THE DATA

# Change format and class of Date variable for easier handling
data$Date <- as.Date(data$Date, "%d/%m/%Y")

# Filter dates to two-day window (2007-02-01 and 2007-02-02)
filtered_data <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02",]

# Change format and class of Time variable to more complete datetime for easier handling
dateTime <- paste(filtered_data$Date, filtered_data$Time)
filtered_data$Time <- strptime(dateTime, format = "%Y-%m-%d %H:%M:%S")

# Change class of all other variables to numeric
# (Apply function implicitly coerces factors to characters before applying as.numeric.)
filtered_data[,3:9] <- apply(filtered_data[,3:9], 2, as.numeric)


# CREATING THE PLOT

# Open a png graphics device with specified width and height (480 pixels X 480 pixels)
png(file = "plot3.png", width = 480, height = 480)

# Set background to transparent 
# (Reference plot background is transparent when individual image is viewed.)
par(bg = "transparent")

# Plot all sub-metering readings, with titles, colors, and a legend
plot(filtered_data$Time, filtered_data$Sub_metering_1, type = "l", xlab = "", 
     ylab = "Energy sub metering")
lines(filtered_data$Time, filtered_data$Sub_metering_2, type = "l", col = "red")
lines(filtered_data$Time, filtered_data$Sub_metering_3, type = "l", col = "blue")
legend(x = "topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = 1, col = c("black", "red", "blue"))

# Turn graphics device off
dev.off()
