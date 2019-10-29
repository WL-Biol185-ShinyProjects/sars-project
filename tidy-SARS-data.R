library(tidyverse)
library(readxl)
tidySARSdata <- read_excel("SARS data.xlsx", 
                        range = "A1:Q33", col_types = c("text", 
                                                        "numeric", "numeric", "numeric", 
                                                        "numeric", "numeric", "numeric", 
                                                        "numeric", "numeric", "numeric", 
                                                        "numeric", "numeric", "numeric", 
                                                        "numeric", "numeric", "date", 
                                                        "date"))
View(tidySARSdata)
