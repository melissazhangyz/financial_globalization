#### Preamble ####
# Purpose: Simulates national saving rate data
# Author: Yingzhi zhang
# Date: 26 March 2024
# Contact: yingzhi.zhang@mail.utoronto.ca
# License: MIT


#### Workspace setup ####
library(tidyverse)
set.seed(987)


#### Simulate data ####
country_name <- c("China", "Thiland", "Malaysia")

data <-
  tibble(
    country = rep(country_name, times = 21),
    year = rep(1990:2010, each = 3),
    saving_rate = runif(n=21*3, min=20, max=60)
  )



