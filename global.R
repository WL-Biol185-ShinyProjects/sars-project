library(shiny)
library(shinydashboard)
library(leaflet)
library(tidyverse)
library(readxl)
library(stringr)
library(htmltools)
library(leaflet)
library(readr)


#Data Frame for Place Map
SARS_data_ll <- data.frame(
  lat = c(-25.274398, -14.235004, 56.130366	, 35.861660 , 22.396428, 22.198745, 23.697810, 4.570868, 
          61.924110, 46.227638, 51.165691, 20.593684,-0.789275, 41.871940, 29.311660, 4.210484, 46.862496,
          -40.900557, 12.879721, 53.412910, 35.907757, 45.943161, 61.524010, 1.352083, -30.559482, 40.463667,
          60.128161, 46.818188, 15.870032, 55.378051, 37.090240, 14.058324),
  lng = c(133.775136, -51.925280, -106.346771, 104.195397, 114.109497, 113.543873, 120.960515, -74.297333,
          25.748151, 2.213749, 10.451526, 78.962880, 113.921327, 12.567380, 47.481766, 101.975766, 103.846656,
          174.885971, 121.774017, -8.243890, 127.766922, 24.966760, 105.318756, 103.819836, 22.937506, -3.749220,
          18.643501, 8.227512, 100.992541, -3.435973, -95.712891, 108.277199),
  Areas = c("Australia", "Brazil", "Canada", "China", "China, Hong Kong (Special Administrative Region)", 
            "China, Macao (Special Administrative Region)","China, Taiwan", "Colombia", "Finland", "France",
            "Germany", "India", "Indonesia", "Italy", "Kuwait", "Malaysia", "Mongolia", "New Zealand", 
            "Philippines", "Republic of Ireland", "Republic of Korea", "Romania", "Russian Federation",
            "Singapore", "South Africa", "Spain", "Sweden", "Switzerland", "Thailand", "United Kingdom",
            "United States", "Vietnam"),
  Total = c("6", "1", "251", "5327", "1755", "1", "665", "1", "1", "7", "9", "3", "2", "4", "1", "5", "9", "1", "14", "1",
            "3", "1", "1", "238", "1", "1", "3", "1", "9", "4", "33", "63"),
  
  NumberofDeaths = c("0", "0", "41", "349", "300", "0", "180", "0", "0", "1", "0", "0", "0", "0", "0", "2", "0", "0", "2",
                     "0", "0", "0", "0", "33", "1", "0", "0", "0", "2", "0", "0", "5"),
  
  stringsAsFactors = FALSE
)

SARS_data_ll$popupText <- paste(strong("Area:"), SARS_data_ll$Areas, br(), strong("Total Cases:"), SARS_data_ll$Total, br(), strong("Total Deaths:"), SARS_data_ll$NumberofDeaths)

#Data Frame for Time Map
tidySARSdata <- read_excel("SARS data ll.xlsx", 
                           range = "A1:S33", col_types = c("numeric", "numeric", "text", 
                                                           "numeric", "numeric", "numeric", 
                                                           "numeric", "numeric", "numeric", 
                                                           "numeric", "numeric", "numeric", 
                                                           "numeric", "numeric", "numeric", 
                                                           "numeric", "numeric", "date", 
                                                           "date"))
names(tidySARSdata) <- c("latitude", "longitude", "areas", "Female", "Male", "Total", 
                         "medianAge", "youngestCase", "oldestCase", "currentlyHospitalized", 
                         "casesRecovered", "deaths", "caseFatalityRate", "importedCases", 
                         "percentImportedcases", "affectedHCW", "percentHCW", "firstOnset", "lastOnset")
tidySARSdata$areas[5] <- "Hong Kong (China, Special Administrative Region)"
tidySARSdata$areas[6] <- "Macao (China, Special Administrative Region)"

#HDI data
HDI2003 <- read_csv("HDI2003.csv", col_types = cols(HDI = col_number()))
summary(HDI2003)

#1Q = 0.2660-0.4900 #2Q = 0.4900-0.6805 #3Q 0.6805-0.7755 #4Q 0.7755-0.9240
HDI2003 <- add_case(HDI2003, Country = c("Macao (China, Special Administrative Region)", "Taiwan (China, Special Administrative Region)"), HDI = c("NA", "NA"))
HDI2003$Country[75] <- "Hong Kong (China, Special Administrative Region)"
HDI2003$Country[83] <- "Republic of Ireland"
HDI2003$Country[91] <- "Republic of Korea"
HDI2003$Country[186] <- "Vietnam"
HDIsars2003 <- HDI2003 %>% 
  slice(9, 24, 32, 36, 75, 196, 197, 37, 60, 61, 65, 78, 79, 84, 92, 105, 115, 123, 136, 83, 91, 140, 141, 153, 157, 159, 163, 164, 168, 180, 181, 186)
HDIsars2003$HDIquartile <- c("1st", "3rd", "4th", "2nd", "4th", "NA", "NA", "2nd", "4th", "4th", "4th", "2nd", "2nd", "4th", "4th", "3rd", "2nd", "4th", 
                             "2nd", "4th", "4th", "3rd", "3rd", "4th", "2nd", "4th", "4th", "4th", "2nd", "4th", "4th", "2nd")

tidySARSdata$HDI <- HDIsars2003$HDI
tidySARSdata$HDIquart <- HDIsars2003$HDIquartile
tidySARSdata$continent <- c("Oceania", "South America", "North America", "Asia", "Asia", 
                            "Asia", "Asia", "South America", "Europe", "Europe", 
                            "Europe", "Asia", "Asia", "Europe", "Asia", "Asia", "Asia", "Oceania",
                            "Asia", "Europe", "Asia", "Europe", "Asia", 
                            "Asia", "Africa", "Europe", "Europe", "Europe", "Asia", "Europe",
                            "North America", "Asia")

#Data frame for Sex Graphs
sextidySARSdata <- tidySARSdata %>% 
  gather('Female', 'Male', 'Total', key = "Sex", value = "Incidence")

#dataframe for HDI plot
HDIdataframe <- tidySARSdata %>% 
  select(areas, Total, deaths, HDI)
names(HDIdataframe) <- c("Country", "Total Cases", "Total Deaths", "HDI")

#dataframe for HDI table
HDIcopyTidySARSdata <- tidySARSdata
names(HDIcopyTidySARSdata) <- c("Latitude", "Longitude", "Country", "Female", "Male", "Total Cases", "Median Age", "Youngest", "Oldest", "Currently Hospitalizied", 
                                "Recoveries", "Deaths", "Fatality Rate", "Imported Cases", "Percent Imported", "HCW", "Percent HCW", "First Onset", "Last Onset",
                                "Human Development Index (HDI)", "HDI Quartile", "continent")


#data frame for data explorer
tidyDataExplorer <- tidySARSdata %>% 
  select(areas, Total, Female, Male, medianAge, youngestCase,
         oldestCase, firstOnset, lastOnset, casesRecovered,
         deaths, caseFatalityRate, importedCases,
         percentImportedcases, affectedHCW, percentHCW, HDI, HDIquart)
names(tidyDataExplorer) <- c("Country", "Total Cases", "Female", "Male", "Median Age",
                             "Youngest Case", "Oldest Case", "First Case", "Last Case", "Cases Recovered", "Deaths", "Fatality Rate", "Imported Cases",
                             "Percentage of Imported Cases", "Healthcare Workers Affected", "Percentage of Healthcare Workers Affected", "HDI", "HDI Quartile")

#dataframe for Recoveries
recoverydata <- tidySARSdata %>%
  select(areas, casesRecovered, Total) %>% 
  mutate(recoveryRate = casesRecovered/Total) %>% 
  arrange(recoveryRate)

#recoverydata$recoveryrate <- recoverydata$casesRecovered/recoverydata$total
names(recoverydata) <- c("Countries", "casesRecovered", "Total", "Recovery Rate")


#words for introduction
#Severe acute respiratory syndrome (SARS)
#The first cases of SARS in late 2002 and early 2003 in Asia were recorded as atypical pneumonia. 
#By March 2003, World Health Organization released a global alert for this atypical, severe pneuomonia of unknown origin, and the Center for Disease Control began to issue health alerts.
#A novel coronavirus (named SARS-CoV) was determined to cause SARS, and it has been found in the civet, a mammmalian animal found in China.
#Since 2004, there have not been any reported cases of SARS
#The global SARS outbreak of 2003 

