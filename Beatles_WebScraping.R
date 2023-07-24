#Jackson Kithcart and Ryan Yuson
#Group Project Web Scraping
#12/9/2022

rm(list=ls())

library(tidyr)
library(rvest)
library(stringr)
library(dplyr)

###Read kaggle csv into data frame
Beatles <- read.csv("TheBeatlesCleaned.csv")

###Grab website url
url <- paste("https://en.wikipedia.org/wiki/List_of_songs_recorded_by_the_Beatles")

###Parse website and grab table
file<-read_html(url)
tables<-html_nodes(file, "table")
table1 <- html_table(tables[3], fill = TRUE)

#put table into data frame
songs <- table1[[1]]