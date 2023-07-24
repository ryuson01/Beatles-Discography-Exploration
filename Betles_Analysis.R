#Jackson Kithcart and Ryan Yuson
#Group Project Data Analysis
#12/9/2022

###Create data frames for each songwriter
beatles_songwriter1 <- select(Beatles_merged, song, Songwriter1, danceability, acousticness, valence)
beatles_songwriter2<- select(Beatles_merged, song, Songwriter2, danceability, acousticness, valence)
beatles_songwriter3 <- select(Beatles_merged, song, Songwriter3, danceability, acousticness, valence)
beatles_songwriter4<- select(Beatles_merged, song, Songwriter4, danceability, acousticness, valence)
beatles_songwriter5<- select(Beatles_merged, song, Songwriter5,danceability, acousticness, valence)


###Rename the columns to merge them
names(beatles_songwriter1)[names(beatles_songwriter1) == "Songwriter1"] <- "Songwriter"
names(beatles_songwriter2)[names(beatles_songwriter2) == "Songwriter2"] <- "Songwriter"
names(beatles_songwriter3)[names(beatles_songwriter3) == "Songwriter3"] <- "Songwriter"
names(beatles_songwriter4)[names(beatles_songwriter4) == "Songwriter4"] <- "Songwriter"
names(beatles_songwriter5)[names(beatles_songwriter5) == "Songwriter5"] <- "Songwriter"

###mergee the columns to create one big data frame
beatles_songwriter <- rbind(beatles_songwriter1,beatles_songwriter2,beatles_songwriter3,beatles_songwriter4,beatles_songwriter5)

###omit NA rows
beatles_songwriter<- na.omit(beatles_songwriter)


############################ ANALYSIS BY SONGWRITER ##################################


##### Danceability ######

#Create data frame with songwriter and their mean danceability
danceability_by_songwriter <- summarise(group_by(beatles_songwriter,Songwriter), mean_danceability=mean(danceability))

####Create data frame with songwriter and their mean danceability for main Beatles songwriters (Starr did not write songs)
main_beatles_danceability<- filter(danceability_by_songwriter, Songwriter == "Lennon" | Songwriter == "McCartney" | Songwriter == "Harrison")

###Plot graphs
qplot(Songwriter,mean_danceability, data = danceability_by_songwriter, geom = "col", xlab = "Songwriter", fill=Songwriter ,aes(reorder(Songwriter, -mean_danceability)))+ geom_text(aes(label=mean_danceability), size=2.75,
                                                                                                                                                                                    vjust=-0.4)
qplot(Songwriter,mean_danceability, data = main_beatles_danceability, geom = "col", xlab = "Songwriter", fill=Songwriter ,aes(reorder(Songwriter, -mean_danceability)))+ geom_text(aes(label=mean_danceability), size=2.75,
                                                                                                                                                                                   vjust=-0.4)


##### Acousticness #####

#Create data frame with songwriter and their mean acousticness
acousticness_by_songwriter <- summarise(group_by(beatles_songwriter,Songwriter), mean_acousticness=mean(acousticness))

####Create data frame with songwriter and their mean acousticness for main Beatles songwriters (Starr did not write songs)
main_beatles_acousticness <-filter(acousticness_by_songwriter, Songwriter == "Lennon" | Songwriter == "McCartney" | Songwriter == "Harrison")

###Plot graphs
qplot(Songwriter,mean_acousticness, data = acousticness_by_songwriter, geom = "col", xlab = "Songwriter", fill=Songwriter ,aes(reorder(Songwriter, -mean_acousticness)))+ geom_text(aes(label=mean_acousticness), size=2.75,
                                                                                                                                                                                    vjust=-0.4)
qplot(Songwriter,mean_acousticness, data = main_beatles_acousticness, geom = "col", xlab = "Songwriter", fill=Songwriter ,aes(reorder(Songwriter, -mean_acousticness)))+ geom_text(aes(label=mean_acousticness), size=2.75,
                                                                                                                                                                                   vjust=-0.4)

##### Positivity #####

#Create data frame with songwriter and their mean valence
valence_by_songwriter <- summarise(group_by(beatles_songwriter,Songwriter), mean_valence=mean(valence))


####Create data frame with songwriter and their mean valence for main Beatles songwriters (Starr did not write songs)
main_beatles_valence <-filter(valence_by_songwriter, Songwriter == "Lennon" | Songwriter == "McCartney" | Songwriter == "Harrison")

###Plot graphs
qplot(Songwriter,mean_valence, data = valence_by_songwriter, geom = "col", xlab = "Songwriter", fill=Songwriter ,aes(reorder(Songwriter, -mean_valence)))+ geom_text(aes(label=mean_valence), size=2.75,
                                                                                                                                                                     vjust=-0.4)
qplot(Songwriter,mean_valence, data = main_beatles_valence, geom = "col", xlab = "Songwriter", fill=Songwriter ,aes(reorder(Songwriter, -mean_valence)))+ geom_text(aes(label=mean_valence), size=2.75,
                                                                                                                                                                    vjust=-0.4)



############################### ANALYSIS BY SINGER ##################################

###Create data frames for each singer
beatles_singer1 <- select(Beatles_merged, song, Singer1, danceability, energy, speechiness, acousticness, liveness, valence)
beatles_singer2<- select(Beatles_merged, song, Singer2, danceability, energy, speechiness, acousticness, liveness, valence)
beatles_singer3 <- select(Beatles_merged, song, Singer3, danceability, energy, speechiness, acousticness, liveness, valence)
beatles_singer4<- select(Beatles_merged, song, Singer4, danceability, energy, speechiness, acousticness, liveness, valence)

###Rename the columns to merge them
names(beatles_singer1)[names(beatles_singer1) == "Singer1"] <- "Singer"
names(beatles_singer2)[names(beatles_singer2) == "Singer2"] <- "Singer"
names(beatles_singer3)[names(beatles_singer3) == "Singer3"] <- "Singer"
names(beatles_singer4)[names(beatles_singer4) == "Singer4"] <- "Singer"

##merge data frames to create big data frame
beatles_singer <- rbind(beatles_singer1,beatles_singer2,beatles_singer3,beatles_singer4)
beatles_singer<- na.omit(beatles_singer)

##### Danceability by singer ######


danceability_by_singer <- summarise(group_by(beatles_singer,Singer), mean_danceability=mean(danceability))

main_beatle_singers_danceability<- filter(danceability_by_singer, Singer == "Lennon" | Singer == "McCartney" | Singer == "Harrison" | Singer == "Starr")

qplot(Singer,mean_danceability, data = danceability_by_singer, geom = "col", xlab = "Singer", fill=Singer ,aes(reorder(Singer, -mean_danceability)))+ geom_text(aes(label=mean_danceability), size=2.75,
                                                                                                                                                                vjust=-0.4)
qplot(Singer,mean_danceability, data = main_beatle_singers_danceability, geom = "col", xlab = "Singer", fill=Singer ,aes(reorder(Singer, -mean_danceability)))+ geom_text(aes(label=mean_danceability), size=2.75,
                                                                                                                                                                          vjust=-0.4)
#### Energy ####
beatles_singer$energy<- gsub("\\)", "0", beatles_singer$energy)
beatles_singer$energy <- as.numeric(beatles_singer$energy)

energy_by_singer <- summarise(group_by(beatles_singer,Singer), mean_energy=mean(energy))

main_beatle_singers_energy<- filter(energy_by_singer, Singer == "Lennon" | Singer == "McCartney" | Singer == "Harrison" | Singer == "Starr")

qplot(Singer,mean_energy, data = energy_by_singer, geom = "col", xlab = "Singer", fill=Singer ,aes(reorder(Singer, -mean_energy)))+ geom_text(aes(label=mean_energy), size=2.75,
                                                                                                                                              vjust=-0.4)
qplot(Singer,mean_energy, data = main_beatle_singers_energy, geom = "col", xlab = "Singer", fill=Singer ,aes(reorder(Singer, -mean_energy)))+ geom_text(aes(label=mean_energy), size=2.75,
                                                                                                                                                        vjust=-0.4)

#### Speechiness ####

speechiness_by_singer <- summarise(group_by(beatles_singer,Singer), mean_speechiness=mean(speechiness))

main_beatle_singers_speechiness<- filter(speechiness_by_singer, Singer == "Lennon" | Singer == "McCartney" | Singer == "Harrison" | Singer == "Starr")

qplot(Singer,mean_speechiness, data = speechiness_by_singer, geom = "col", xlab = "Singer", fill=Singer ,aes(reorder(Singer, -mean_speechiness)))+ geom_text(aes(label=mean_speechiness), size=2.75,
                                                                                                                                                             vjust=-0.4)
qplot(Singer,mean_speechiness, data = main_beatle_singers_speechiness, geom = "col", xlab = "Singer", fill=Singer ,aes(reorder(Singer, -mean_speechiness)))+ geom_text(aes(label=mean_speechiness), size=2.75,
                                                                                                                                                                       vjust=-0.4)

#### Acousticness

acousticness_by_singer <- summarise(group_by(beatles_singer,Singer), mean_acousticness=mean(acousticness))

main_beatle_singers_acousticness<- filter(acousticness_by_singer, Singer == "Lennon" | Singer == "McCartney" | Singer == "Harrison" | Singer == "Starr")

qplot(Singer,mean_acousticness, data = acousticness_by_singer, geom = "col", xlab = "Singer", fill=Singer ,aes(reorder(Singer, -mean_acousticness)))+ geom_text(aes(label=mean_acousticness), size=2.75,
                                                                                                                                                                vjust=-0.4)
qplot(Singer,mean_acousticness, data = main_beatle_singers_acousticness, geom = "col", xlab = "Singer", fill=Singer ,aes(reorder(Singer, -mean_acousticness)))+ geom_text(aes(label=mean_acousticness), size=2.75,
                                                                                                                                                                          vjust=-0.4)
#### Liveness ####

liveness_by_singer <- summarise(group_by(beatles_singer,Singer), mean_liveness=mean(liveness))

main_beatle_singers_liveness<- filter(liveness_by_singer, Singer == "Lennon" | Singer == "McCartney" | Singer == "Harrison" | Singer == "Starr")

qplot(Singer,mean_liveness, data = liveness_by_singer, geom = "col", xlab = "Singer", fill=Singer ,aes(reorder(Singer, -mean_liveness)))+ geom_text(aes(label=mean_liveness), size=2.75,
                                                                                                                                                    vjust=-0.4)
qplot(Singer,mean_liveness, data = main_beatle_singers_liveness, geom = "col", xlab = "Singer", fill=Singer ,aes(reorder(Singer, -mean_liveness)))+ geom_text(aes(label=mean_liveness), size=2.75,
                                                                                                                                                              vjust=-0.4)
#### Positivity ####

valence_by_singer <- summarise(group_by(beatles_singer,Singer), mean_valence=mean(valence))

main_beatle_singers_valence<- filter(valence_by_singer, Singer == "Lennon" | Singer == "McCartney" | Singer == "Harrison" | Singer == "Starr")

qplot(Singer,mean_valence, data = valence_by_singer, geom = "col", xlab = "Singer", fill=Singer ,aes(reorder(Singer, -mean_valence)))+ geom_text(aes(label=mean_valence), size=2.75,
                                                                                                                                                 vjust=-0.4)
qplot(Singer,mean_valence, data = main_beatle_singers_valence, geom = "col", xlab = "Singer", fill=Singer ,aes(reorder(Singer, -mean_valence)))+ geom_text(aes(label=mean_valence), size=2.75,
                                                                                                                                                           vjust=-0.4)

################################### ANALYSIS BY ALBUM ######################################

###danceability###
danceability_by_album <- summarise(group_by(Beatles_merged,album), mean_danceability=mean(danceability))

qplot(album,mean_danceability, data = danceability_by_album, geom = "col", xlab = "Album", fill=album ,aes(reorder(album, -mean_danceability)))+ geom_text(aes(label=mean_danceability), size=2.75,
                                                                                                                                                           vjust=-0.4)

#### Energy ####

energy_by_album <-summarise(group_by(Beatles_merged,album), mean_energy=mean(energy))

qplot(album,mean_energy, data = energy_by_album, geom = "col", xlab = "Album", fill=album ,aes(reorder(album, -mean_energy)))+ geom_text(aes(label=mean_energy), size=2.75,
                                                                                                                                         vjust=-0.4)
#### Speechiness ####

speechiness_by_album <- summarise(group_by(Beatles_merged,album), mean_speechiness=mean(speechiness))

qplot(album,mean_speechiness, data = speechiness_by_album, geom = "col", xlab = "Album", fill=album ,aes(reorder(album, -mean_speechiness)))+ geom_text(aes(label=mean_speechiness), size=2.75,
                                                                                                                                                        vjust=-0.4)

### Acousticness ###

acousticness_by_album <- summarise(group_by(Beatles_merged,album), mean_acousticness=mean(acousticness))

qplot(album,mean_acousticness, data = acousticness_by_album, geom = "col", xlab = "Album", fill=album ,aes(reorder(album, -mean_acousticness)))+ geom_text(aes(label=mean_acousticness), size=2.75,
                                                                                                                                                           vjust=-0.4)
### Liveness ###

liveness_by_album <- summarise(group_by(Beatles_merged,album), mean_liveness=mean(liveness))

qplot(album,mean_liveness, data = liveness_by_album, geom = "col", xlab = "Album", fill=album ,aes(reorder(album, -mean_liveness)))+ geom_text(aes(label=mean_liveness), size=2.75,
                                                                                                                                               vjust=-0.4)

### Positivity ###

valence_by_album <- summarise(group_by(Beatles_merged,album), mean_valence=mean(valence))

qplot(album,mean_valence, data = valence_by_album, geom = "col", xlab = "Album", fill=album ,aes(reorder(album, -mean_valence)))+ geom_text(aes(label=mean_valence), size=2.75,
                                                                                                                                            vjust=-0.4)

################################# ANALYSIS BY YEAR ########################################


###danceability###
danceability_by_year <- summarise(group_by(Beatles_merged,year), mean_danceability=mean(danceability))

ggplot() + geom_line(aes(y = mean_danceability, x = year), data = danceability_by_year)


### energy ###
energy_by_year <- summarise(group_by(Beatles_merged,year), mean_energy=mean(energy))

ggplot() + geom_line(aes(y = mean_energy, x = year), data = energy_by_year)

### Speechiness ###
speechiness_by_year <- summarise(group_by(Beatles_merged,year), mean_speechiness=mean(speechiness))

ggplot() + geom_line(aes(y = mean_speechiness, x = year), data = speechiness_by_year)

### Acousticness ###

acousticness_by_year <- summarise(group_by(Beatles_merged,year), mean_acousticness=mean(acousticness))

ggplot() + geom_line(aes(y = mean_acousticness, x = year), data = acousticness_by_year)

### Liveness ###

liveness_by_year <- summarise(group_by(Beatles_merged,year), mean_liveness=mean(liveness))

ggplot() + geom_line(aes(y = mean_liveness, x = year), data = liveness_by_year)

### Positivity ###

valence_by_year <- summarise(group_by(Beatles_merged,year), mean_valence=mean(valence))

ggplot() + geom_line(aes(y = mean_valence, x = year), data = valence_by_year)

save.image("RyanYusonJacksonKithcartDataWranglingGroupProject.rda")
