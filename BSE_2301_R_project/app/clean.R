#Function to Return the Column indicies
getIndex <- function(colName,df){
  #grep function to return the integer corresponding to the index of the column in the vector of colnames
  return (grep(colName, colnames(df)))
}

demo = read.csv("app/csv/Demographics for UNHCR's populations of concern residing in Uganda.csv")

# Remove Country, gender unknowns and overall totals(last column) since they are not consistent
# Get positions
country = getIndex("Country...territory.of.asylum.residence",demo)
fUnknown = getIndex("F..Unknown",demo)
mUnknown = getIndex("M..Unknown",demo)
ftotal = getIndex("F..Total",demo)
mtotal = getIndex("M..Total",demo)
ototal = ncol(demo)

remove = c(country,fUnknown,mUnknown,ftotal,mtotal,ototal)

# Remove all unwanted columns at once and first row as well since it is a header repeatition
removed = demo[-1,-remove]

#  Write new csv without country and row 1
write.csv(removed,"app/csv/demographics.csv",row.names = FALSE)

# Read demographics without the above columns and row
char_demo = read.csv("app/csv/demographics.csv", stringsAsFactors = FALSE)

#Remove location names and characters that cause inconsistencies
char_demo$Location.Name <- gsub('camp','',char_demo$Location.Name,ignore.case=TRUE)
char_demo$Location.Name <- gsub('District','',char_demo$Location.Name)
char_demo$Location.Name <- gsub('Point','',char_demo$Location.Name)
char_demo$Location.Name <- gsub(':','',char_demo$Location.Name)
char_demo$Location.Name <- gsub('city','',char_demo$Location.Name,ignore.case = TRUE)
char_demo$Location.Name <- gsub('KYAKA 2','Kyaka II',char_demo$Location.Name,ignore.case = TRUE)
char_demo$Location.Name <- gsub('rhino','Rhino Camp',char_demo$Location.Name,ignore.case = TRUE)
char_demo$Location.Name <- gsub('KAYAKA','Kyaka',char_demo$Location.Name,ignore.case = TRUE)
char_demo$Location.Name <- gsub('Yumbe \\(Bidibidi\\)','Yumbe',char_demo$Location.Name,ignore.case = TRUE)
char_demo$Location.Name <- gsub('Yumbe','Yumbe \\(Bidibidi\\)',char_demo$Location.Name,ignore.case = TRUE)
char_demo$Location.Name <- gsub('Kyriandongo','Kiryandongo',char_demo$Location.Name,ignore.case = TRUE)
char_demo$Location.Name <- gsub('Impevi','Imvepi',char_demo$Location.Name,ignore.case = TRUE)
char_demo$Location.Name <- gsub('Uganda  Dispersed in the country / territory','Dispersed',char_demo$Location.Name)

# Write csv without inconsistent characters and naming
write.csv(char_demo,"app/csv/demographics.csv",row.names=FALSE)


clean_demo = read.csv("app/csv/demographics.csv")

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

# Getting rows where all cells are 0
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

# Rewrite csv without the missing values
write.csv(clean_demo,"app/csv/clean_demographics.csv",row.names = FALSE)

# Read csv so as to remove the dispersed location 
clean_demo = read.csv("app/csv/clean_demographics.csv")

# Positions of appearences of dispersed location
posDispersed = grep("Dispersed",clean_demo$Location.Name)

# Remove the dispersed
clean_demo = clean_demo[-posDispersed,]

# Rewrite csv without the Dispersed row
write.csv(clean_demo,"app/csv/clean_demographics.csv",row.names = FALSE)
