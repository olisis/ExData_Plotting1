url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, "tmp.zip")
unzip("tmp.zip")
# The first line of the downloaded file is a header, na.string are marked as "?", so the parameters header=TRUE, na.strings="?" are used
d <- read.csv("household_power_consumption.txt", sep=";", header=TRUE,stringsAsFactors=FALSE,na.strings="?")
# Convert as.Date with the appropriate format before filterning for 2007-02-01 and 2007-02-02
d.f <- filter(d, as.Date(Date,"%d/%m/%Y") == as.Date("1/2/2007", "%d/%m/%Y") | as.Date(Date,"%d/%m/%Y", "%d/%m/%Y") == as.Date("2/2/2007", "%d/%m/%Y"))
#Combine the Date and time columns to one in a vector of type char
d.dt<-paste(d.f$Date, d.f$Time)
#Create a vector of type POSIXlt from the vector above
d.dt.plt<-strptime(d.dt, "%d/%m/%Y %H:%M:%S")
# Now we are ready to create Plot 2.
# First, as I am not in the US, set locale to english (otherwise the days in the created plot are in my local language)
Sys.setenv(LANG="en")
Sys.setlocale("LC_ALL", "English")
# To avoid data.frame issues with supporting POSIXlt. plot directly the vector d.dt.plt against d.f$Global_active_power column
# Let us put the Plot to the screen device first (default), to see if the result matchs the requirements
plot(d.dt.plt, d.f$Global_active_power, type="l", ylab ="Global Active Power (kilowatts)", xlab="")
#Check the result and copy the plot to the png device as required
dev.copy(png, file = "plot2.png", width=480,height=480, units="px")
#close both the png and the screen device
dev.off()
dev.off()