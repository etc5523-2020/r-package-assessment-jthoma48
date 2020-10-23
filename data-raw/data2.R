## code to prepare `data2` dataset goes here

library(tidyverse)
library(readr)
library(ggplot2)
library(plotly)
library(dplyr)
library(lubridate)


data2 <- read_csv(system.file("extdata", "WHO-COVID-19-global-data.csv", package = "cov20"))
data2$Date_reported <- as.Date(data2$Date_reported)

usethis::use_data(data2, overwrite = TRUE)
