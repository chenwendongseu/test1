setwd("F:/R/201710")
library(data.table)
library(tidyverse)
library(leaflet)

myfiles1 <- fread("0105.csv")
myfiles2 <- fread("0610.csv")
myfiles3 <- fread("1115.csv")
myfiles4 <- fread("1620.csv")
myfiles5 <- fread("2125.csv")
myfiles6 <- fread("2631.csv")

myfiles1 <- myfiles1 %>% select(-c(1,2))
myfiles2 <- myfiles2 %>% select(-c(1,2))
myfiles3 <- myfiles3 %>% select(-c(1,2))
myfiles4 <- myfiles4 %>% select(-c(1,2))
myfiles5 <- myfiles5 %>% select(-1)
myfiles6 <- myfiles6 %>% select(-1)

myfiles <- rbind(myfiles1,myfiles2,myfiles3,myfiles4,myfiles5,myfiles6)
rm(myfiles1,myfiles2,myfiles3,myfiles4,myfiles5,myfiles6);gc()

colnames(myfiles)[1:10] <- c("CARD_ID","TYPE","BIKE_ID","LEASE_TIME","RT_TIME",
                             "LEASE_ID","LEASE_NAME","RT_ID","RT_NAME","CERT_ID")

myfiles <- myfiles %>% mutate(LEASE_ID = substr(LEASE_ID,2,6),RT_ID = substr(RT_ID,2,6))
myfiles <- myfiles %>% filter(substr(LEASE_ID,1,2) %in% seq(11,16,1) , substr(RT_ID,1,2) %in% seq(11,16,1))

a <- myfiles %>% group_by(LEASE_ID) %>% summarise(num =n()) 

leaflet() %>% addProviderTiles("OpenStreetMap") %>% 
  addMarkers(lng=118.78498, lat=32.05715)