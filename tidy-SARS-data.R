library(tidyverse)
library(readxl)
tidySARSdata <- read_excel("SARS data ll.xlsx", 
                        range = "A1:S33", col_types = c("numeric", "numeric", "text", 
                                                        "numeric", "numeric", "numeric", 
                                                        "numeric", "numeric", "numeric", 
                                                        "numeric", "numeric", "numeric", 
                                                        "numeric", "numeric", "numeric", 
                                                        "numeric", "numeric", "date", 
                                                        "date"))
names(tidySARSdata) <- c("latitude", "longitude", "areas", "female", "male", "total", "medianAge", "youngestCase", "oldestCase", "currentlyHospitalized", "casesRecovered", "deaths", "caseFatalityRate", "importedCases", "percentImportedcases", "affectedHCW", "percentHCW", "firstOnset", "lastOnset")
View(tidySARSdata)
