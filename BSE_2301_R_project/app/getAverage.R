library(dplyr)
library(tidyverse)

location <- read.csv("app/csv/all_camps.csv")
cleanDemo <- read.csv("app/csv/clean_demographics.csv")

#Function to Return the Column indicies
getIndex <- function(colName,df){
  #grep function to return the integer corresponding to the index of the column in the vector of colnames
  return (grep(colName, colnames(df)))
}
# Get values for all camps
adjumani <- subset(cleanDemo,cleanDemo$Location.Name == "Adjumani" | cleanDemo$Location.Name == "Adjumani " | cleanDemo$Location.Name == "Adjumani  ")
arua <- subset(cleanDemo,cleanDemo$Location.Name == "Arua" | cleanDemo$Location.Name == "Arua " | cleanDemo$Location.Name == "Arua  ")
ikafe <- subset(cleanDemo,cleanDemo$Location.Name == "Ikafe" | cleanDemo$Location.Name == "Ikafe " | cleanDemo$Location.Name == "Ikafe  ")
imvepi <- subset(cleanDemo,cleanDemo$Location.Name == "Imvepi" | cleanDemo$Location.Name == "Imvepi " | cleanDemo$Location.Name == "Imvepi  ")
kampala <- subset(cleanDemo,cleanDemo$Location.Name == "Kampala" | cleanDemo$Location.Name == "Kampala " | cleanDemo$Location.Name == "Kampala  ")
kiryandongo <- subset(cleanDemo,cleanDemo$Location.Name == "Kiryandongo" | cleanDemo$Location.Name == "Kiryandongo " | cleanDemo$Location.Name == "Kiryandongo  ")
kitgum <- subset(cleanDemo,cleanDemo$Location.Name == "Kitgum" | cleanDemo$Location.Name == "Kitgum " | cleanDemo$Location.Name == "Kitgum  ")
koboko <- subset(cleanDemo,cleanDemo$Location.Name == "Koboko" | cleanDemo$Location.Name == "Koboko " | cleanDemo$Location.Name == "Koboko  ")
kyaka	 <- subset(cleanDemo,cleanDemo$Location.Name == "Kyaka II" | cleanDemo$Location.Name == "Kyaka II " | cleanDemo$Location.Name == "Kyaka II  ")
kyangwali  <- subset(cleanDemo,cleanDemo$Location.Name == "Kyangwali" | cleanDemo$Location.Name == "Kyangwali " | cleanDemo$Location.Name == "Kyangwali  ")
lamwo  <- subset(cleanDemo,cleanDemo$Location.Name == "Lamwo" | cleanDemo$Location.Name == "Lamwo " | cleanDemo$Location.Name == "Lamwo  ")
lobule  <- subset(cleanDemo,cleanDemo$Location.Name == "Lobule" | cleanDemo$Location.Name == "Lobule " | cleanDemo$Location.Name == "Lobule  ")
madiOkollo  <- subset(cleanDemo,cleanDemo$Location.Name == "Madi-Okollo" | cleanDemo$Location.Name == "Madi-Okollo " | cleanDemo$Location.Name == "Madi-Okollo  ")
matanda <- subset(cleanDemo,cleanDemo$Location.Name == "Matanda" | cleanDemo$Location.Name == "Matanda " | cleanDemo$Location.Name == "Matanda  ")	
moyo  <- subset(cleanDemo,cleanDemo$Location.Name == "Moyo" | cleanDemo$Location.Name == "Moyo " | cleanDemo$Location.Name == "Moyo  ")
nakivale <- subset(cleanDemo,cleanDemo$Location.Name == "Nakivale" | cleanDemo$Location.Name == "Nakivale " | cleanDemo$Location.Name == "Nakivale  ")
oruchinga <- subset(cleanDemo,cleanDemo$Location.Name == "Oruchinga" | cleanDemo$Location.Name == "Oruchinga " | cleanDemo$Location.Name == "Oruchinga  ")
pakelle <- subset(cleanDemo,cleanDemo$Location.Name == "Pakelle" | cleanDemo$Location.Name == "Pakelle " | cleanDemo$Location.Name == "Pakelle  ")
palorinya <- subset(cleanDemo,cleanDemo$Location.Name == "Palorinya" | cleanDemo$Location.Name == "Palorinya " | cleanDemo$Location.Name == "Palorinya  ")
rhino <- subset(cleanDemo,cleanDemo$Location.Name == "Rhino Camp" | cleanDemo$Location.Name == "Rhino Camp " | cleanDemo$Location.Name == "Rhino Camp  ")
rwamanja <- subset(cleanDemo,cleanDemo$Location.Name == "Rwamanja" | cleanDemo$Location.Name == "Rwamanja " | cleanDemo$Location.Name == "Rwamanja  ")
yumbe <- subset(cleanDemo,cleanDemo$Location.Name == "Yumbe (Bidibidi)" | cleanDemo$Location.Name == "Yumbe (Bidibidi) " | cleanDemo$Location.Name == "Yumbe (Bidibidi)  ")


# Average the values
aruaMean = round(colMeans(arua[,-c(1,2)]),0)
adjumaniMean = round(colMeans(adjumani[,-c(1,2)]),0)
ikafeMean = round(colMeans(ikafe[,-c(1,2)]),0)
imvepiMean = round(colMeans(imvepi[,-c(1,2)]),0)
kampalaMean = round(colMeans(kampala[,-c(1,2)]),0)
kiryandongoMean = round(colMeans(kiryandongo[,-c(1,2)]),0)
kitgumMean = round(colMeans(kitgum[,-c(1,2)]),0)
kobokoMean = round(colMeans(koboko[,-c(1,2)]),0)
kyakaMean = round(colMeans(kyaka[,-c(1,2)]),0)
kyangwaliMean = round(colMeans(kyangwali[,-c(1,2)]),0)
lamwoMean = round(colMeans(lamwo[,-c(1,2)]),0)
lobuleMean = round(colMeans(lobule[,-c(1,2)]),0)
madiOkolloMean = round(colMeans(madiOkollo[,-c(1,2)]),0)
matandaMean = round(colMeans(matanda[,-c(1,2)]),0)
moyoMean = round(colMeans(moyo[,-c(1,2)]),0)
nakivaleMean = round(colMeans(nakivale[,-c(1,2)]),0)
oruchingaMean = round(colMeans(oruchinga[,-c(1,2)]),0)
pakelleMean = round(colMeans(pakelle[,-c(1,2)]),0)
palorinyaMean = round(colMeans(palorinya[,-c(1,2)]),0)
rhinoMean = round(colMeans(rhino[,-c(1,2)]),0)
rwamanjaMean = round(colMeans(rwamanja[,-c(1,2)]),0)
yumbeMean = round(colMeans(yumbe[,-c(1,2)]),0)

# Bind into a dataframe of rows for each averaged value
averageDemo <- as.data.frame(
               rbind(
                 adjumaniMean,aruaMean,ikafeMean,imvepiMean,kampalaMean,
                 kiryandongoMean,kitgumMean,kobokoMean,kyakaMean,
                 kyangwaliMean,lamwoMean,lobuleMean,madiOkolloMean,
                 matandaMean,moyoMean,nakivaleMean,oruchingaMean,
                 pakelleMean,palorinyaMean,rhinoMean,rwamanjaMean,yumbeMean
               ) 
              )

# Get average of all columns together with the location column
averageDemo <- cbind(location,averageDemo)

# Do a sum for unnecessarily split columns as well as the genders
finalAverage <- mutate(averageDemo,
                       avg.0.4 = Female.0.4 + Male.0.4,
                       avg.5.17 = Female.5.11 + Female.5.17 + Female.12.17 + Male.5.11 + Male.5.17 + Male.12.17,
                       avg.18.59 = Female.18.59 + Male.18.59,
                       avg.60 = Female.60. + Male.60.,
                       AvgTotal = avg.0.4 + avg.5.17 + avg.18.59 + avg.60
                      )

# Remove the unnecessary columns
# Get positions
loc = getIndex("Location.Name",finalAverage)
avg04 = getIndex("avg.0.4",finalAverage)
avg517 = getIndex("avg.5.17",finalAverage)
avg1859 = getIndex("avg.18.59",finalAverage)
avg60 = getIndex("avg.60",finalAverage)
avgTot = getIndex("AvgTotal",finalAverage)

# Make df with only those positions
finalAverage = finalAverage[,c(loc,avg04,avg517,avg1859,avg60,avgTot)]
write.csv(finalAverage,"app/csv/average_locations.csv",row.names = FALSE)




