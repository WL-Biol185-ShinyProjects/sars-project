library(tidyverse)
tidySARSdata <- read.table("SARS data.xlsx",
                           header = TRUE,
                           na.strings = "Pending")
tidySARSdata
