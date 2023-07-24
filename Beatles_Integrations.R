### Data Cleaning/merging

# Input semicolon between individuals names
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

ncols <- max(stringr::str_count(songs$`Songwriter(s)`, "; ")) + 1

# Create new columns
colmn <- paste("col", 1:ncols)

# Create dataframes with columns
songs <- cbind(songs, reshape2::colsplit(songs$`Songwriter(s)`, "; ", colmn))

unique(songs$`Lead vocal(s)[d]`)

# Remove parentheses from vocals
songs$`Lead vocal(s)[d]`<- gsub("[(]","", songs$`Lead vocal(s)[d]`)
songs$`Lead vocal(s)[d]`<- gsub("[)]","", songs$`Lead vocal(s)[d]`)


# Input semincolon between names
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

# Create new columns
colmn2 <- paste("col", 6:9)

# Create data frame by putting old data into new dataframe splitting columns by semicolon
songs <- cbind(songs, reshape2::colsplit(songs$`Lead vocal(s)[d]`, "; ", colmn2))

# Input NAs
songs[songs ==""] <- NA

# Get rid of Wikipedia links from song data frame
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

# Make song titles Capitalized
Beatles$song <- str_to_title(Beatles$song)
songs$Song <-str_to_title(songs$Song)


# Fix errors in Beatles and Song data frames
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

# Create data frame with singers, songwriters, and songs
songs2 <- songs[ ,c("Song", "col 1", "col 2", "col 3", "col 4", "col 5", "col 6", "col 7", "col 8", "col 9")]

# Input new, more descriptive, column names 
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

# Get rid of spaces on the end of song
Beatles$song <- trimws(Beatles$song, which = c('right'))
songs2$song <- trimws(songs2$song, which = c('right'))

# Merge data by common song name
Beatles_merged <- merge(Beatles, songs2, by="song")

# Fix error in energy column
Beatles_merged$energy<- gsub("\\)", "0", Beatles_merged$energy)
Beatles_merged$energy <- as.numeric(Beatles_merged$energy)
