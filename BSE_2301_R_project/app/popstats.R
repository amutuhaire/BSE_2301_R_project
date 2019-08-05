#Function to Return the Column indicies
getIndex <- function(colName,df){
  #grep function to return the integer corresponding to the index of the column in the vector of colnames
  return (grep(colName, colnames(df)))
}


popStat = read.csv("app/csv/unhcr_popstats_export_persons_of_concern_2019_07_04_102625.csv")

# Store only the required columns
year = getIndex("Year",popStat)
country  = getIndex("Country...territory.of.asylum.residence",popStat)
received = getIndex("Refugees..incl..refugee.like.situations.",popStat)
return = getIndex("Returned.refugees",popStat)
keep = c(year,country,received,return)
popStat = popStat[,keep]

#Make NA zero
popStat[is.na(popStat)] = 0

colnames(popStat) = c("Year","Asylum.Country","Refugees.Received","Refugees.Returned")

write.csv(popStat,"app/csv/popstats.csv",row.names = FALSE)
popStat = read.csv("app/csv/popstats.csv")
