#Function to add two columns
addCols <- function(col1,col2,targetCol){
  col1 <- as.integer(col1)
  col2 <- as.integer(col2)
  targetCol <- col1 + col2
}

#Function to Return the Column indicies
getIndex <- function(colName,df){
  #grep function to return the integer corresponding to the index of the column in the vector of colnames
  return (grep(colName, colnames(df)))
}

demographics = read.csv("../Datasets/Demographics for UNHCR's populations of concern residing in Uganda.csv")
countryIndex = getIndex("Country...territory.of.asylum.residence",demographics)

# Remove Sub header row and Uganda row
demographics = demographics[-1,-countryIndex]

#Write results into another csv without the column values
write.csv(demographics,"../Datasets/cleanHeader.csv",row.names = FALSE)
clean_demographics = read.csv("../Datasets/cleanHeader.csv")

data2005 = subset(clean_demographics,clean_demographics$Year == 2005)
data2006 = subset(clean_demographics,clean_demographics$Year == 2006)
data2007 = subset(clean_demographics,clean_demographics$Year == 2007)
data2008 = subset(clean_demographics,clean_demographics$Year == 2008)
data2009 = subset(clean_demographics,clean_demographics$Year == 2009)
data2010 = subset(clean_demographics,clean_demographics$Year == 2010)
data2011 = subset(clean_demographics,clean_demographics$Year == 2011)
data2012 = subset(clean_demographics,clean_demographics$Year == 2012)
data2013 = subset(clean_demographics,clean_demographics$Year == 2013)
data2014 = subset(clean_demographics,clean_demographics$Year == 2014)
data2015 = subset(clean_demographics,clean_demographics$Year == 2015)
data2016 = subset(clean_demographics,clean_demographics$Year == 2016)
data2017 = subset(clean_demographics,clean_demographics$Year == 2017)
data2018 = subset(clean_demographics,clean_demographics$Year == 2018)
 
#Getting row index
for(countRow in seq(from=1, to=numRows, by=1)){
  # Start from the 3rd column since the first two are strings 
  for(countCol in seq(from=3, to=numCols, by=1)){
    if (clean_demo[countRow,countCol] != 0 ){
      break
    }else{
      is_zero = is_zero + 1
    }
  }
  if (is_zero == (numCols-2)){
    # Store the row positon in a vector
    rowVals = c(rowVals,countRow)
  }
  # Return the counter back to 0 for a new row
  is_zero = 0
}
