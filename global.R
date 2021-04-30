library(ggplot2)
library(ggthemes)
library(tidyverse)
library(plotly)
library(maps)

# If you want to update the data, set it as TRUE. 
# Or read csv directly from the link of the data
update_data <- FALSE

if (!dir.exists("data")) {
    dir.create("data")
}

if (update_data | !file.exists("data/owid-covid-data.csv")) {
    download.file("https://covid.ourworldindata.org/data/owid-covid-data.csv",
                  destfile = file.path(getwd(), "/data/owid-covid-data.csv"))
    
}

covid_data <- read.csv("https://covid.ourworldindata.org/data/owid-covid-data.csv",
                       stringsAsFactors = FALSE,
                       check.names =  FALSE)

covid_data$date <- as.Date(covid_data$date)
covid_data$new_cases[covid_data$new_cases < 0] <- 0
covid_data$new_cases_smoothed[covid_data$new_cases_smoothed < 0] <- 0

