library(wordcloud2)
avg = read.csv("app/csv/average_locations.csv")
avg2 = avg[,c(1,ncol(avg))]
wordcloud2(avg2,size = 1)
