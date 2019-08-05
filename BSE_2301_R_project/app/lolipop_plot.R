# Library
library(tidyverse)
library(ggplot2)
avg = readr::read_csv("csv/average_locations.csv")


ggplot(avg, aes(x=Location.Name, y=AvgTotal)) +
  geom_segment( aes(x=Location.Name, xend=Location.Name, y=0, yend=AvgTotal)) +
  geom_point( size=5, color="red", fill=alpha("orange", 0.3), alpha=0.7, shape=21, stroke=2) 

# Horizontal 
ggplot(avg, aes(x=Location.Name, y=AvgTotal)) +
  geom_segment( aes(x=Location.Name, xend=Location.Name, y=0, yend=AvgTotal), color="skyblue") +
  geom_point( color="blue", size=4, alpha=0.6) +
  theme_light() +
  coord_flip() +
  theme(
    panel.grid.major.y = element_blank(),
    panel.border = element_blank(),
    axis.ticks.y = element_blank()
  ) 

