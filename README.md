# Data Wrangling: Beatles Discography Exploration
Welcome to our Data Wrangling project repository! This project aims to explore the discography of the iconic band, The Beatles, by applying a variety of data-wrangling techniques to 
discover underlying relational and chronological trends within their music and gain insights into precursory performance metrics. 
We will achieve this by analyzing specific song attributes and perceived performance metrics.

## Project Overview
The Beatles, the highest-selling musical group of all time, have left an indelible mark on the music industry. 
As a devoted fan of classic rock, we are passionate about unraveling the secrets that lie within their iconic songs. 
By applying data wrangling skills with R, we aim to discover the factors that contribute to the popularity of their music.


## Problem Statement
While defining a 'great song' may be subjective, specific metrics can shed light on the components influencing song popularity. 
This project seeks to address the following questions:

1. Can we identify discernible patterns in The Beatles' discography that correlate with song popularity?
2. Do certain song attributes play a role in the overall appeal & success of their music?
3. Is there a relationship between critical acclaim, chart rankings, and specific musical elements?

## Methodology
To achieve insights into The Beatles' discography, we will follow these steps:

1. Data Acquisition: Curate a dataset from reliable sources and reputable music archives. (_Beatles_WebScraping.R_)
2. Data Cleaning: Ensure data integrity by handling missing values, resolving inconsistencies, and removing duplicates.  (_Beatles_Integrations.R_)
3. Data Wrangling: Apply advanced data wrangling techniques with R to prepare the dataset for exploration and visualization to uncover patterns within our dataset. (_Beatles_Analysis.R_)

# Datasets
This project utilizes two distinct datasets to gain insights into The Beatles' discography.

## Dataset 1: 'TheBeatlesCleaned.csv' (Kaggle)
Sourced from Kaggle, this dataset contains comprehensive information on 193 Beatles tracks and is comprised of several key song features
that allow us to explore the components influencing each song's popularity:

- **year** (Date): The year of release for the album/song.
- **album** (Text): The name of the album associated with the song.
- **song** (Text): The specific song analyzed in each row.
- **danceability** (Numeric): Describes how suitable a track is for dancing, ranging from 0.0 (least danceable) to 1.0 (most danceable).
- **energy** (Numeric): Measures the intensity and activity of a track on a scale from 0.0 to 1.0.
- **speechiness** (Numeric): Detects the presence of spoken words in a track, ranging from 0.0 to 1.0.
- **acousticness** (Numeric): A confidence measure from 0.0 to 1.0 indicating whether the track is acoustic.
- **liveness** (Numeric): Detects the presence of an audience in the recording, with values greater than 0.8 indicating a high probability of a live performance.
- **valence** (Numeric): A measure from 0.0 to 1.0 describing the musical positiveness conveyed by a track.

## Dataset 2: Webscraped List of Songs (Wikipedia)
We collected additional information from the Wikipedia page, "List of Songs Recorded by The Beatles," using web scraping techniques. 
This dataset contains 213 instances of individual song information; after cleaning, the features of this dataset are as follows:

- **song** (Text): The specific song analyzed in each row, corresponding to the 'song' column in the Kaggle dataset.
- **songwriter1...songwriter5** (Text): Individuals who aided in writing each specific song. Songwriter2 can only be not null if songwriter1 is not null, and so on.
- **singer1...singer4** (Text): Individuals who sang in each song. Singer2 can only be not null if singer1 is not null, and so on.


