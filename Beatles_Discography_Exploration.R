rm(list=ls())

# Load necessary packages
library(tidyr)
library(rvest)
library(stringr)
library(dplyr)
library(ggplot2)

# Load Kaggle file
Beatles <- read.csv("TheBeatlesCleaned.csv")

# Web scrape table from Wikipedia
url <- paste("https://en.wikipedia.org/wiki/List_of_songs_recorded_by_the_Beatles")
file<-read_html(url)
tables<-html_nodes(file, "table")

# Convert into usable dataframe
table1 <- html_table(tables[3], fill = TRUE)
songs <- table1[[1]]

# Data cleaning for 'Songwriter(s)' column
unique(songs$`Songwriter(s)`)

# Replace combined names with semicolon-separated names
songs$`Songwriter(s)`<- gsub("LennonMcCartney", "Lennon; McCartney", songs$`Songwriter(s)`)
songs$`Songwriter(s)`<- gsub("Johnny RussellVoni Morrison" , "Johnny Russell; Voni Morrison" , songs$`Songwriter(s)`)
songs$`Songwriter(s)`<- gsub("Burt BacharachMack DavidLuther Dixon" , "Burt Bacharach; Mack David; Luther Dixon" , songs$`Songwriter(s)`)
songs$`Songwriter(s)`<- gsub("Luther DixonWes Farrell" , "Luther Dixon; Wes Farrell", songs$`Songwriter(s)`)
songs$`Songwriter(s)`<- gsub("Lennon; McCartneyHarrisonStarkey" , "Lennon; McCartney; Harrison; Starkey", songs$`Songwriter(s)`)
songs$`Songwriter(s)`<- gsub("Jerry LeiberMike Stoller /Richard Penniman" ,"Jerry Leiber; Mike Stoller; Richard Penniman", songs$`Songwriter(s)`)
songs$`Songwriter(s)`<- gsub("Lennon; McCartneyJean NicolasHeinz Hellmer" , "Lennon; McCartney; Jean Nicolas; Heinz Hellmer", songs$`Songwriter(s)`)
songs$`Songwriter(s)`<- gsub("Robert BlackwellEnotris JohnsonRichard Penniman", "Robert Blackwell; Enotris Johnson; Richard Penniman", songs$`Songwriter(s)`)
songs$`Songwriter(s)`<- gsub("Traditional, arr.Lennon; McCartney; Harrison; Starkey", "Lennon; McCartney; Harrison; Starkey", songs$`Songwriter(s)`)
songs$`Songwriter(s)`<- gsub("Berry GordyJanie Bradford", "Berry Gordy; Janie Bradford", songs$`Songwriter(s)`)
songs$`Songwriter(s)`<- gsub("Georgia DobbinsWilliam GarrettBrian HollandRobert BatemanFreddie Gorman", "Georgia Dobbins; William Garrett; Brian Holland; Robert Bateman; Freddie Gorman", songs$`Songwriter(s)`)
songs$`Songwriter(s)`<- gsub("Lennon; McCartneyJean NicolasLee Montogue", "Lennon; McCartney; Jean Nicolas; Lee Montogue", songs$`Songwriter(s)`)
songs$`Songwriter(s)`<- gsub("Bobby ScottRic Marlow", "Bobby Scott; Ric Marlow", songs$`Songwriter(s)`)
songs$`Songwriter(s)`<- gsub("Phil MedleyBert Berns", "Phil Medley; Bert Berns", songs$`Songwriter(s)`)
songs$`Songwriter(s)`<- gsub("Lennon; McCartneyStarkey" , "Lennon; McCartney; Starkey" , songs$`Songwriter(s)`)
songs$`Songwriter(s)`<- gsub("Gerry GoffinCarole King" , "Gerry Goffin; Carole King" , songs$`Songwriter(s)`)

# Split 'Songwriter(s)' and 'Lead vocal(s)[d]' columns into multiple columns
ncols <- max(stringr::str_count(songs$`Songwriter(s)`, "; ")) + 1
colmn <- paste("col", 1:ncols)
songs <- cbind(songs, reshape2::colsplit(songs$`Songwriter(s)`, "; ", column))

ncols2 <- max(stringr::str_count(songs$`Lead vocal(s)[d]`, "; ")) + 1
colmn2 <- paste("col", 6:9)
songs <- cbind(songs, reshape2::colsplit(songs$`Lead vocal(s)[d]`, "; ", colmn2))

unique(songs$`Lead vocal(s)[d]`)

songs$`Lead vocal(s)[d]`<- gsub("[(]","", songs$`Lead vocal(s)[d]`)
songs$`Lead vocal(s)[d]`<- gsub("[)]","", songs$`Lead vocal(s)[d]`)

songs$`Lead vocal(s)[d]`<- gsub("McCartneywith Lennon", "McCartney; Lennon", songs$`Lead vocal(s)[d]`)
songs$`Lead vocal(s)[d]`<- gsub("LennonMcCartney", "Lennon; McCartney", songs$`Lead vocal(s)[d]`)
songs$`Lead vocal(s)[d]`<- gsub("Lennonwith McCartney", "Lennon; McCartney", songs$`Lead vocal(s)[d]`)
songs$`Lead vocal(s)[d]`<- gsub("LennonMcCartneyHarrison", "Lennon; McCartney; Harrison", songs$`Lead vocal(s)[d]`)
songs$`Lead vocal(s)[d]`<- gsub("McCartneywith Lennon,Harrison,and Starr", "McCartney; Lennon; Harrison; Starr", songs$`Lead vocal(s)[d]`)
songs$`Lead vocal(s)[d]`<- gsub("Lennonwith Yoko Ono", "Lennon; Yoko Ono", songs$`Lead vocal(s)[d]`)
songs$`Lead vocal(s)[d]`<- gsub("McCartneyLennonHarrison", "McCartney; Lennon; Harrison", songs$`Lead vocal(s)[d]`)
songs$`Lead vocal(s)[d]`<- gsub("Lennonwith McCartneyand Harrison", "Lennon; McCartney; Harrison", songs$`Lead vocal(s)[d]`)
songs$`Lead vocal(s)[d]`<- gsub("LennonHarrison", "Lennon; Harrison", songs$`Lead vocal(s)[d]`)
songs$`Lead vocal(s)[d]`<- gsub("McCartney; Lennon,Harrison,and Starr", "McCartney; Lennon; Harrison; Starr", songs$`Lead vocal(s)[d]`)
songs$`Lead vocal(s)[d]`<- gsub("Lennon; McCartneyand Harrison", "Lennon; McCartney; Harrison", songs$`Lead vocal(s)[d]`)
songs$`Lead vocal(s)[d]`<- gsub("Lennon; McCartneyHarrison", "Lennon; McCartney; Harrison", songs$`Lead vocal(s)[d]`)

#Data cleaning for Song titles
songs[songs ==""] <- NA
songs$Song<- gsub("#","", songs$Song)
songs$Song<- gsub("\"", "", songs$Song)
songs$Song<- gsub("\\[e\\]", "", songs$Song)
songs$Song<- gsub("\\[f\\]", "", songs$Song)
songs$Song<- gsub("\\[g\\]", "", songs$Song)
songs$Song<- gsub("\\[h\\]", "", songs$Song)
songs$Song<- gsub("\\[i\\]", "", songs$Song)
songs$Song<- gsub("\\[j\\]", "", songs$Song)
songs$Song<- gsub("\\[k\\]", "", songs$Song)
songs$Song<- gsub("\\[l\\]", "", songs$Song)
songs$Song<- gsub("\\[m\\]", "", songs$Song)
songs$Song<- gsub("\\[n\\]", "", songs$Song)
songs$Song<- gsub("\\[o\\]", "", songs$Song)

Beatles$song <- str_to_title(Beatles$song)
songs$Song <-str_to_title(songs$Song)

songs$Song<- gsub("Anna \\(Go to Him\\)", "Anna", songs$Song)
Beatles$song <- gsub("Youre", "You\'re", Beatles$song)
Beatles$song <- gsub("Babys", "Baby\'s", Beatles$song)
Beatles$song <- gsub("Back In The Ussr", "Back In the U.S.S.R.", Beatles$song)
Beatles$song <- gsub("Mr.kite", "Mr.Kite", Beatles$song)
Beatles$song <- gsub("Cant", "Can\'t", Beatles$song)
Beatles$song <- gsub("Everybodys", "Everybody\'s", Beatles$song)
Beatles$song <- gsub("Heres", "Here", Beatles$song)
Beatles$song <- gsub("Ive", "I\'ve", Beatles$song)
Beatles$song <- gsub("Its", "It\'s", Beatles$song)
Beatles$song <- gsub("Im", "I\'m", Beatles$song)
Beatles$song <- gsub("Ill", "I\'ll", Beatles$song)
Beatles$song <- gsub("\\(She's So Heavy\\)", " \\(She's So Heavy\\)", Beatles$song)
Beatles$song <- gsub("Wont", "Won\'t", Beatles$song)
Beatles$song <- gsub("Kansas City/ Hey-Hey-Hey-Hey", "Kansas City/Hey-Hey-Hey-Hey!", Beatles$song)
Beatles$song <- gsub("Long, Long. Long", "Long, Long, Long", Beatles$song)
Beatles$song <- gsub("Maxwells", "Maxwell\'s", Beatles$song)
Beatles$song <- gsub("Mr ", "Mr. ", Beatles$song)
Beatles$song <- gsub("\\(That’s What I Want\\)", " \\(That's What I Want\\)", Beatles$song)
Beatles$song <- gsub("Natures", "Nature\'s", Beatles$song)
Beatles$song <- gsub("Mr.moonlight", "Mr. Moonlight", Beatles$song)
songs$Song <- gsub("Norwegian Wood \\(This Bird Has Flown\\)", "Norwegian Wood", songs$Song)
Beatles$song <- gsub("Obi-La -Di, Ob-La-Da", "Obi-La-Di, Ob-La-Da", Beatles$song)
Beatles$song <- gsub("P.s. ", "P.S. ", Beatles$song)
Beatles$song <- gsub("Mister", "Mr.", Beatles$song)
Beatles$song <- gsub("Sgt. Peppers Lonely Hearts Club Band", "Sgt. Pepper\'s Lonely Hearts Club Band", Beatles$song)
Beatles$song <- gsub("Shes", "She\'s", Beatles$song)
Beatles$song <- gsub("The Continue Story Of Bungalow Bill", "The Continuing Story Of Bungalow Bill", Beatles$song)
Beatles$song <- gsub("Yer Blue", "Yer Blues", Beatles$song)

#Select relevant columns
songs2 <- songs[ ,c("Song", "col 1", "col 2", "col 3", "col 4", "col 5", "col 6", "col 7", "col 8", "col 9")]

#Rename columns for clarity
names(songs2)[names(songs2) == "Song"] <- "song"
names(songs2)[names(songs2) == "col 1"] <- "Songwriter1"
names(songs2)[names(songs2) == "col 2"] <- "Songwriter2"
names(songs2)[names(songs2) == "col 3"] <- "Songwriter3"
names(songs2)[names(songs2) == "col 4"] <- "Songwriter4"
names(songs2)[names(songs2) == "col 5"] <- "Songwriter5"
names(songs2)[names(songs2) == "col 6"] <- "Singer1"
names(songs2)[names(songs2) == "col 7"] <- "Singer2"
names(songs2)[names(songs2) == "col 8"] <- "Singer3"
names(songs2)[names(songs2) == "col 9"] <- "Singer4"

#Merge datasets
Beatles$song <- trimws(Beatles$song, which = c('right'))
songs2$song <- trimws(songs2$song, which = c('right'))
Beatles_merged <- merge(Beatles, songs2, by="song")

# Select  columns for each 'songwriter' dataset
beatles_songwriter1 <- select(Beatles_merged, song, Songwriter1, danceability, acousticness, valence)
beatles_songwriter2<- select(Beatles_merged, song, Songwriter2, danceability, acousticness, valence)
beatles_songwriter3 <- select(Beatles_merged, song, Songwriter3, danceability, acousticness, valence)
beatles_songwriter4<- select(Beatles_merged, song, Songwriter4, danceability, acousticness, valence)
beatles_songwriter5<- select(Beatles_merged, song, Songwriter5,danceability, acousticness, valence)

# Rename columns
names(beatles_songwriter1)[names(beatles_songwriter1) == "Songwriter1"] <- "Songwriter"
names(beatles_songwriter2)[names(beatles_songwriter2) == "Songwriter2"] <- "Songwriter"
names(beatles_songwriter3)[names(beatles_songwriter3) == "Songwriter3"] <- "Songwriter"
names(beatles_songwriter4)[names(beatles_songwriter4) == "Songwriter4"] <- "Songwriter"
names(beatles_songwriter5)[names(beatles_songwriter5) == "Songwriter5"] <- "Songwriter"

# Combine all 'beatles_songwriter' datasets into a single dataset
beatles_songwriter <- rbind(beatles_songwriter1,beatles_songwriter2,beatles_songwriter3,beatles_songwriter4,beatles_songwriter5)

# Remove NA's
beatles_songwriter<- na.omit(beatles_songwriter)

#################
### Danceability 
danceability_by_songwriter <- summarise(group_by(beatles_songwriter,Songwriter), mean_danceability=mean(danceability))
View(danceability_by_songwriter)

# Ringo Starr did not write any songs 
main_beatles_danceability<- filter(danceability_by_songwriter, Songwriter == "Lennon" | Songwriter == "McCartney" | Songwriter == "Harrison")

qplot(Songwriter,mean_danceability, data = danceability_by_songwriter, geom = "col", xlab = "Songwriter", fill=Songwriter ,aes(reorder(Songwriter, -mean_danceability)))+ geom_text(aes(label=mean_danceability), size=2.75, vjust=-0.4)
qplot(Songwriter,mean_danceability, data = main_beatles_danceability, geom = "col", xlab = "Songwriter", fill=Songwriter ,aes(reorder(Songwriter, -mean_danceability)))+ geom_text(aes(label=mean_danceability), size=2.75, vjust=-0.4)

#################
### Acousticness 
acousticness_by_songwriter <- summarise(group_by(beatles_songwriter,Songwriter), mean_acousticness=mean(acousticness))
main_beatles_acousticness <-filter(acousticness_by_songwriter, Songwriter == "Lennon" | Songwriter == "McCartney" | Songwriter == "Harrison")

qplot(Songwriter,mean_acousticness, data = acousticness_by_songwriter, geom = "col", xlab = "Songwriter", fill=Songwriter ,aes(reorder(Songwriter, -mean_acousticness)))+ geom_text(aes(label=mean_acousticness), size=2.75, vjust=-0.4)
qplot(Songwriter,mean_acousticness, data = main_beatles_acousticness, geom = "col", xlab = "Songwriter", fill=Songwriter ,aes(reorder(Songwriter, -mean_acousticness)))+ geom_text(aes(label=mean_acousticness), size=2.75, vjust=-0.4)

#################
### Positivity 
valence_by_songwriter <- summarise(group_by(beatles_songwriter,Songwriter), mean_valence=mean(valence))
main_beatles_valence <-filter(valence_by_songwriter, Songwriter == "Lennon" | Songwriter == "McCartney" | Songwriter == "Harrison")

#
qplot(Songwriter,mean_valence, data = valence_by_songwriter, geom = "col", xlab = "Songwriter", fill=Songwriter ,aes(reorder(Songwriter, -mean_valence)))+ geom_text(aes(label=mean_valence), size=2.75, vjust=-0.4)
qplot(Songwriter,mean_valence, data = main_beatles_valence, geom = "col", xlab = "Songwriter", fill=Songwriter ,aes(reorder(Songwriter, -mean_valence)))+ geom_text(aes(label=mean_valence), size=2.75, vjust=-0.4)

#################
### By Singer 
beatles_singer1 <- select(Beatles_merged, song, Singer1, danceability, energy, speechiness, acousticness, liveness, valence)
beatles_singer2<- select(Beatles_merged, song, Singer2, danceability, energy, speechiness, acousticness, liveness, valence)
beatles_singer3 <- select(Beatles_merged, song, Singer3, danceability, energy, speechiness, acousticness, liveness, valence)
beatles_singer4<- select(Beatles_merged, song, Singer4, danceability, energy, speechiness, acousticness, liveness, valence)

names(beatles_singer1)[names(beatles_singer1) == "Singer1"] <- "Singer"
names(beatles_singer2)[names(beatles_singer2) == "Singer2"] <- "Singer"
names(beatles_singer3)[names(beatles_singer3) == "Singer3"] <- "Singer"
names(beatles_singer4)[names(beatles_singer4) == "Singer4"] <- "Singer"

beatles_singer <- rbind(beatles_singer1,beatles_singer2,beatles_singer3,beatles_singer4)
beatles_singer<- na.omit(beatles_singer)

#################
### Danceability by Singer
danceability_by_singer <- summarise(group_by(beatles_singer,Singer), mean_danceability=mean(danceability))
main_beatle_singers_danceability<- filter(danceability_by_singer, Singer == "Lennon" | Singer == "McCartney" | Singer == "Harrison" | Singer == "Starr")

qplot(Singer,mean_danceability, data = danceability_by_singer, geom = "col", xlab = "Singer", fill=Singer, aes(reorder(Singer, -mean_danceability))) + geom_text(aes(label=mean_danceability), size=2.75, vjust=-0.4)                                                                                                                                                               vjust=-0.4)
qplot(Singer,mean_danceability, data = main_beatle_singers_danceability, geom = "col", xlab = "Singer", fill=Singer ,aes(reorder(Singer, -mean_danceability)))+ geom_text(aes(label=mean_danceability), size=2.75, vjust=-0.4)

#################
### Energy
beatles_singer$energy<- gsub("\\)", "0", beatles_singer$energy)
beatles_singer$energy <- as.numeric(beatles_singer$energy)

energy_by_singer <- summarise(group_by(beatles_singer,Singer), mean_energy=mean(energy))
main_beatle_singers_energy<- filter(energy_by_singer, Singer == "Lennon" | Singer == "McCartney" | Singer == "Harrison" | Singer == "Starr")

qplot(Singer,mean_energy, data = energy_by_singer, geom = "col", xlab = "Singer", fill=Singer ,aes(reorder(Singer, -mean_energy)))+ geom_text(aes(label=mean_energy), size=2.75, vjust=-0.4)
qplot(Singer,mean_energy, data = main_beatle_singers_energy, geom = "col", xlab = "Singer", fill=Singer ,aes(reorder(Singer, -mean_energy)))+ geom_text(aes(label=mean_energy), size=2.75, vjust=-0.4)

#################
#### Speechiness 
speechiness_by_singer <- summarise(group_by(beatles_singer,Singer), mean_speechiness=mean(speechiness))
main_beatle_singers_speechiness<- filter(speechiness_by_singer, Singer == "Lennon" | Singer == "McCartney" | Singer == "Harrison" | Singer == "Starr")

qplot(Singer,mean_speechiness, data = speechiness_by_singer, geom = "col", xlab = "Singer", fill=Singer ,aes(reorder(Singer, -mean_speechiness)))+ geom_text(aes(label=mean_speechiness), size=2.75, vjust=-0.4)
qplot(Singer,mean_speechiness, data = main_beatle_singers_speechiness, geom = "col", xlab = "Singer", fill=Singer ,aes(reorder(Singer, -mean_speechiness)))+ geom_text(aes(label=mean_speechiness), size=2.75, vjust=-0.4)

#################
#### Acousticness
acousticness_by_singer <- summarise(group_by(beatles_singer,Singer), mean_acousticness=mean(acousticness))
main_beatle_singers_acousticness<- filter(acousticness_by_singer, Singer == "Lennon" | Singer == "McCartney" | Singer == "Harrison" | Singer == "Starr")

qplot(Singer,mean_acousticness, data = acousticness_by_singer, geom = "col", xlab = "Singer", fill=Singer ,aes(reorder(Singer, -mean_acousticness)))+ geom_text(aes(label=mean_acousticness), size=2.75, vjust=-0.4)
qplot(Singer,mean_acousticness, data = main_beatle_singers_acousticness, geom = "col", xlab = "Singer", fill=Singer ,aes(reorder(Singer, -mean_acousticness)))+ geom_text(aes(label=mean_acousticness), size=2.75, vjust=-0.4)

#################
#### Liveness
liveness_by_singer <- summarise(group_by(beatles_singer,Singer), mean_liveness=mean(liveness))
main_beatle_singers_liveness<- filter(liveness_by_singer, Singer == "Lennon" | Singer == "McCartney" | Singer == "Harrison" | Singer == "Starr")

qplot(Singer,mean_liveness, data = liveness_by_singer, geom = "col", xlab = "Singer", fill=Singer ,aes(reorder(Singer, -mean_liveness)))+ geom_text(aes(label=mean_liveness), size=2.75, vjust=-0.4)
qplot(Singer,mean_liveness, data = main_beatle_singers_liveness, geom = "col", xlab = "Singer", fill=Singer ,aes(reorder(Singer, -mean_liveness)))+ geom_text(aes(label=mean_liveness), size=2.75, vjust=-0.4)

#################
#### Positivity
valence_by_singer <- summarise(group_by(beatles_singer,Singer), mean_valence=mean(valence))
main_beatle_singers_valence<- filter(valence_by_singer, Singer == "Lennon" | Singer == "McCartney" | Singer == "Harrison" | Singer == "Starr")

qplot(Singer,mean_valence, data = valence_by_singer, geom = "col", xlab = "Singer", fill=Singer ,aes(reorder(Singer, -mean_valence)))+ geom_text(aes(label=mean_valence), size=2.75, vjust=-0.4)
qplot(Singer,mean_valence, data = main_beatle_singers_valence, geom = "col", xlab = "Singer", fill=Singer ,aes(reorder(Singer, -mean_valence)))+ geom_text(aes(label=mean_valence), size=2.75, vjust=-0.4)

#################
# Exploration by Album
#### Danceability 
danceability_by_album <- summarise(group_by(Beatles_merged,album), mean_danceability=mean(danceability))

qplot(album,mean_danceability, data = danceability_by_album, geom = "col", xlab = "Album", fill=album ,aes(reorder(album, -mean_danceability)))+ geom_text(aes(label=mean_danceability), size=2.75, vjust=-0.4)

#################
#### Energy
Beatles_merged$energy<- gsub("\\)", "0", Beatles_merged$energy)
Beatles_merged$energy <- as.numeric(Beatles_merged$energy)
energy_by_album <-summarise(group_by(Beatles_merged,album), mean_energy=mean(energy))

qplot(album,mean_energy, data = energy_by_album, geom = "col", xlab = "Album", fill=album ,aes(reorder(album, -mean_energy)))+ geom_text(aes(label=mean_energy), size=2.75, vjust=-0.4)

#################
#### Speechiness 
speechiness_by_album <- summarise(group_by(Beatles_merged,album), mean_speechiness=mean(speechiness))

qplot(album,mean_speechiness, data = speechiness_by_album, geom = "col", xlab = "Album", fill=album ,aes(reorder(album, -mean_speechiness)))+ geom_text(aes(label=mean_speechiness), size=2.75, vjust=-0.4)

#################
### Acousticness 
acousticness_by_album <- summarise(group_by(Beatles_merged,album), mean_acousticness=mean(acousticness))

qplot(album,mean_liveness, data = acousticness_by_album, geom = "col", xlab = "Album", fill=album ,aes(reorder(album, -mean_liveness)))+ geom_text(aes(label=mean_liveness), size=2.75, vjust=-0.4)

#################
### Liveness 
liveness_by_album <- summarise(group_by(Beatles_merged,album), mean_liveness=mean(liveness))

qplot(album,mean_liveness, data = liveness_by_album, geom = "col", xlab = "Album", fill=album ,aes(reorder(album, -mean_liveness)))+ geom_text(aes(label=mean_liveness), size=2.75, vjust=-0.4)

#################
### Positivity
valence_by_album <- summarise(group_by(Beatles_merged,album), mean_valence=mean(valence))

qplot(album,mean_valence, data = valence_by_album, geom = "col", xlab = "Album", fill=album ,aes(reorder(album, -mean_valence)))+ geom_text(aes(label=mean_valence), size=2.75, vjust=-0.4)

#################
# Exploration by Year 
### Danceability 
danceability_by_year <- summarise(group_by(Beatles_merged,year), mean_danceability=mean(danceability))

ggplot() + geom_line(aes(y = mean_danceability, x = year), data = danceability_by_year)

#################
### Energy
energy_by_year <- summarise(group_by(Beatles_merged,year), mean_energy=mean(energy))

ggplot() + geom_line(aes(y = mean_energy, x = year), data = energy_by_year)

#################
### Speechiness
speechiness_by_year <- summarise(group_by(Beatles_merged,year), mean_speechiness=mean(speechiness))

ggplot() + geom_line(aes(y = mean_speechiness, x = year), data = speechiness_by_year)

#################
### Acousticness
acousticness_by_year <- summarise(group_by(Beatles_merged,year), mean_acousticness=mean(acousticness))

ggplot() + geom_line(aes(y = mean_acousticness, x = year), data = acousticness_by_year)

#################
### Liveness
liveness_by_year <- summarise(group_by(Beatles_merged,year), mean_liveness=mean(liveness))

ggplot() + geom_line(aes(y = mean_liveness, x = year), data = liveness_by_year)

#################
### Positivity
valence_by_year <- summarise(group_by(Beatles_merged,year), mean_valence=mean(valence))

ggplot() + geom_line(aes(y = mean_valence, x = year), data = valence_by_year)








