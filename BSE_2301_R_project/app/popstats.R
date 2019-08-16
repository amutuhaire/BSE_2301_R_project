#Function to Return the Column indicies
getIndex <- function(colName,df){
  #grep function to return the integer corresponding to the index of the column in the vector of colnames
  return (grep(colName, colnames(df)))
}


popStat = read.csv("app/csv/unhcr_popstats_export_persons_of_concern_2019_07_04_102625.csv")

# Store only the required columns
year = getIndex("Year",popStat)
received = getIndex("Refugees..incl..refugee.like.situations.",popStat)
return = getIndex("Returned.refugees",popStat)
keep = c(year,received,return)
popStat = popStat[,keep]

#Make NA zero
popStat[is.na(popStat)] = 0

# Give appropriate names
colnames(popStat) = c("Year","Received_Refugees","Returned_Refugees")

write.csv(popStat,"app/csv/popstats.csv",row.names = FALSE)
popStat = read.csv("app/csv/popstats.csv")

# Get the unique years
years = levels(as.factor(popStat$Year))
numYears = length(years)
# Initialize the vectors to store the years
numRecev = c()
numRetun = c()

# Loop through popStat while populating the vectors with the sums of each year
for(index in seq(from=1, to=numYears, by=1)){
  # Get the sum for received at the current index for the year represented by that index
  numRecev[index] = sum(subset(popStat,popStat$Year == years[index])[2])
  numRetun[index] = sum(subset(popStat,popStat$Year == years[index])[3])
}

# Combine the results to make a data.frame that later translates into the csv
returned = as.data.frame(cbind(years,numRecev,numRetun),row.names = FALSE)
colnames(returned) = c("Year","Received_Refugees","Returned_Refugees")
write.csv(returned,"app/csv/returned.csv",row.names = FALSE)


