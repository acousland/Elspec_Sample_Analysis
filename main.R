#------ Include lubridate package to manipulate dates--------
library("lubridate")

#--------- Read from CSV File-----------
LoggerResults = read.csv("~/Desktop/United Energy Documents/Test Results/TEST152/PQSExport_20150216_151825_Ne02b_Wave.csv", header=T)

LoggerResults$TIMESTAMP <- dmy_hm(LoggerResults$X.DATEANDTIME) + as.numeric(LoggerResults$X.SECONDS.)

#--------- Set Window timeframe-------
#StartTime <- min(LoggerResults$TIMESTAMP)
#EndTime <- max(LoggerResults$TIMESTAMP)

StartTime <- as.POSIXct("2015-02-16 15:20:02.28", format = "%Y-%m-%d %H:%M:%OS", tz = "UTC")
EndTime <- as.POSIXct("2015-02-16 15:20:02.45", format = "%Y-%m-%d %H:%M:%OS", tz = "UTC")

FilteredResults <- subset(LoggerResults, LoggerResults$TIMESTAMP >= StartTime & LoggerResults$TIMESTAMP <= EndTime)

#--------- Set up plotter to view 3 graphs and graph currents -----
plot.new()
frame()

par(mfrow=c(3,1))

plot(FilteredResults$TIMESTAMP,FilteredResults$X.WAVEFORMI1.)
plot(FilteredResults$TIMESTAMP,FilteredResults$X.WAVEFORMI2.)
plot(FilteredResults$TIMESTAMP,FilteredResults$X.WAVEFORMI3.)

#---------- Mark window length as a test and write back to new csv file ----
LoggerResults$Testing <- ifelse(LoggerResults$TIMESTAMP >= StartTime, ifelse(LoggerResults$TIMESTAMP <= EndTime, 1,0),0)

write.csv(LoggerResults, file= "~/Desktop/United Energy Documents/Test Results/Test152Results.csv")