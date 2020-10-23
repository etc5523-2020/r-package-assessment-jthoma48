## code to prepare `data5` dataset goes here

library(tidyverse)
library(readr)
library(ggplot2)
library(plotly)
library(dplyr)
library(lubridate)

data4 <- read_csv(system.file("extdata", "time_series_covid19_recovered_global_iso3_regions.csv", package = "cov20"))

data5 <- data4 %>% filter(`Province/State` %in% c("Australian Capital Territory", "New South Wales", "Northern Territory", "Queensland", "South Australia", "Tasmania", "Victoria", "Western Australia")) %>% 
  select(-c(`Country/Region`, `ISO 3166-1 Alpha 3-Codes`, `Region Code`, `Region Name`, `Sub-region Code`, `Sub-region Name`, `Intermediate Region Code`, `Intermediate Region Name`)) %>% 
  rename(State = `Province/State`) %>% 
  pivot_longer(cols = c("1/22/20":"10/7/20"), 
               names_to = "Date", 
               values_to = "Cumulative Cases") %>% mutate(Date = mdy(Date))

data5$Date <- as.Date(data5$Date)
data5$Lat <- as.numeric(data5$Lat)
data5$Long <- as.numeric(data5$Long)

usethis::use_data(data5, overwrite = TRUE)
