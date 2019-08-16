library(treemap)
avg = read.csv("app/csv/average_locations.csv")
# treemap
plot2 = treemap(avg,
        index="Location.Name",
        vSize="AvgTotal",
        type="index"
)
