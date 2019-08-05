avg = read.csv("app/csv/average_locations.csv")
par(mar = c(7.5,4,2,0.5),mgp = c(3.1, 0.6, 0))
barplot(t(avg[,2]), names.arg = avg$Location.Name,las=2, beside = T, col = "blue", axis.lty = "solid",
         ylab = "Averages", main = "Age 0 - 4",border=NA)

barplot(t(avg[,3]), names.arg = avg$Location.Name,las=2, beside = T, col = "#36A3F0", axis.lty = "solid", 
         ylab = "Averages",main = "Age 5 - 17",border=NA)


barplot(t(avg[,4]), names.arg = avg$Location.Name,las=2, beside = T, col = "#74A2C9", axis.lty = "solid",
         ylab = "Averages",main = "Age 18 - 59",border=NA)


barplot(t(avg[,5]), names.arg = avg$Location.Name,las=2, beside = T, col = "#A8D1ED", axis.lty = "solid",
         ylab = "Averages",main = "Age 60 Above",cex.names = 0.6,border=NA)


