## This script creates a png file for one histogram of global active power readings during
## a two-day period based on the Household Power Consumption dataset. It is assumed that 
## the dataset has already been downloaded and unzipped in the user's home directory.

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
png(file = "plot1.png", width = 480, height = 480)

# Set background to transparent 
# (Reference plot background is transparent when individual image is viewed.)
par(bg = "transparent")

# Plot histogram for global active power readings using red color and titles
hist(filtered_data$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")

# Turn graphics device off
dev.off()
