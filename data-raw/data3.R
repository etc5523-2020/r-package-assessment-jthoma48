## code to prepare `data3` dataset goes here

library(tidyverse)
library(readr)
library(ggplot2)
library(plotly)
library(dplyr)
library(lubridate)

data3 <- data2 %>% group_by(Country) %>% filter(Date_reported == "2020-10-06") %>% 
  select(Country, Cumulative_cases, Cumulative_deaths) %>% 
  rename(`Cumulative cases` = Cumulative_cases,
         `Cumulative deaths` = Cumulative_deaths)

usethis::use_data(data3, overwrite = TRUE)
