url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, "tmp.zip")
unzip("tmp.zip")
# The first line of the downloaded file is a header, na.string are marked as "?", so the parameters header=TRUE, na.strings="?" are used
d <- read.csv("household_power_consumption.txt", sep=";", header=TRUE,stringsAsFactors=FALSE,na.strings="?")
# Convert as.Date with the appropriate format before filterning for 2007-02-01 and 2007-02-02
d.f <- filter(d, as.Date(Date,"%d/%m/%Y") == as.Date("1/2/2007", "%d/%m/%Y") | as.Date(Date,"%d/%m/%Y", "%d/%m/%Y") == as.Date("2/2/2007", "%d/%m/%Y"))
# Combine the Date and time columns to one in a vector of type char
d.dt<-paste(d.f$Date, d.f$Time)
#Create a vector of type POSIXlt from the vector above
d.dt.plt<-strptime(d.dt, "%d/%m/%Y %H:%M:%S")
# Now we are ready to create Plot 3.
# First, as I am not in the US, set locale to english (otherwise the days in the created plot are in my local language)
Sys.setenv(LANG="en")
Sys.setlocale("LC_ALL", "English")
# To avoid data.frame issues with supporting POSIXlt. plot directly the vector d.dt.plt against the other three columns
# Plot directly to the png device as the dev.copy did not make a one to one copy in this case (issue with legend)
png(file = "plot3.png", width = 480, height = 480, units = "px")
plot(d.dt.plt, d.f$Sub_metering_1, type="l", ylab ="Energy sub metering", xlab="", col="black")
points(d.dt.plt, d.f$Sub_metering_2, col="red", type="l")
points(d.dt.plt, d.f$Sub_metering_3, col="blue", type="l")
legend("topright", lty=c(1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#close the device
dev.off()
