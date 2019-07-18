#Function to Return the Column indicies
getIndex <- function(colName,df){
  #grep function to return the integer corresponding to the index of the column in the vector of colnames
  return (grep(colName, colnames(df)))
}

demo = read.csv("../Datasets/Demographics for UNHCR's populations of concern residing in Uganda.csv")

# Remove Country and Row 1
demo_no_country_row1 = demo[-1,-2]

# Remove overall total(last column) since it is not consistent
demo_no_country_row1 = demo_no_country_row1[,-ncol(demo_no_country_row1)]

#  Write new csv without country and row 1
write.csv(demo_no_country_row1,"../Datasets/demographics.csv",row.names = FALSE)

# Read clean demographics
clean_demo = read.csv("../Datasets/demographics.csv")

#Get number of rows and columns
numRows = nrow(clean_demo)
numCols = ncol(clean_demo)

#Make NA zero
clean_demo[is.na(clean_demo)] = 0

# Make empty string 0 & Make reduced value (the asterics) to 0
for(countRow in seq(from=1, to=numRows, by=1)){
  for(countCol in seq(from=3, to=numCols, by=1)){
    if (clean_demo[countRow,countCol] == "" | clean_demo[countRow,countCol] == "*"){
      clean_demo[countRow,countCol] = 0
    }
  }
}

# Counting rows where all cells are 0
is_zero = 0
zeroRows = c()

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
    zeroRows = c(zeroRows,countRow)
    
  }
  # Return the counter back to 0 for a new row
  is_zero = 0
}

# Deleting the rows where 
clean_demo = clean_demo[-zeroRows,]

# New number of rows and columns
numRows = nrow(clean_demo)

# Rewrite clean data frame to csv
write.csv(clean_demo,"../Datasets/clean_demographics.csv",row.names = FALSE)

final_demo = read.csv("../Datasets/clean_demographics.csv")
