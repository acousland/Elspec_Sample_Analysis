
#--------- Read from CSV File (Remember reverse slashes) -----------
LoggerResults = read.csv("C:/Data Repositry/Elspec/TestResults/TEST110/PQSExport_20150213_090400_Ne02b_Wave(1).csv", header=T)

LoggerResults$TIMESTAMP <- dmy_hm(LoggerResults$X.DATEANDTIME) + as.numeric(LoggerResults$X.SECONDS.)

#--------- Set Window timeframe-------
message(min(LoggerResults$TIMESTAMP))
message(max(LoggerResults$TIMESTAMP))


StartTime <- as.POSIXct("2015-02-13 09:04:22", format = "%Y-%m-%d %H:%M:%OS", tz = "UTC")
EndTime <- as.POSIXct("2015-02-13 09:04:47", format = "%Y-%m-%d %H:%M:%OS", tz = "UTC")

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

write.csv(LoggerResults, file= "C:/Data Repositry/Elspec/TestResults/Test110Results.csv")