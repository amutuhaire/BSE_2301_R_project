clean = read.csv("app/csv/clean_demographics.csv")

# Get factor of all camps and turn its levels into vector
allCampsFactor = clean$Location.Name
allCamps = levels(allCampsFactor)

# Number of camps
len_Camps = length(allCamps)
count = 1
totalRed = c()

#Go through the entire factor of camps
while(count <= len_Camps){
  # Get the positions where the corresponding camp names are located
  name = allCamps[count]
  
  # Make the name of the camp just the first five characters for consistency
  name = substring(name,1,5)
  posCurrent = grep(name,allCamps)
  
  # Maintain one position if there are many
  if(length(posCurrent) > 1){
    posCurrent = posCurrent[-1]
    allCamps = allCamps[-posCurrent]
    
    # Record total redundancies for checking
    totalRed = c(totalRed,posCurrent)
  }
  # Length keeps variating
  len_Camps = length(allCamps)
  
  count = count + 1
}

# Confirm that there are no more repeatitions
for (current in seq(from=1, to=len_Camps, by=1)){
  name = allCamps[current]
  # Make the name of the camp just the first five characters for consistency
  name = substring(name,1,5)
  posCurrent = grep(name,allCamps)
  print(posCurrent)
}

# Store the camp names
allCamps = as.data.frame(allCamps)
colnames(allCamps) = c("Location.Name")
write.csv(allCamps,"app/csv/all_camps.csv",row.names = FALSE)

