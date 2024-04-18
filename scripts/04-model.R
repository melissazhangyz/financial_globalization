#### Preamble ####
# Purpose: Model
# Author: Yingzhi Zhang
# Date: 7 Apr 2024
# Contact: yingzhi.zhang@mail.utoronto.ca
# License: MIT

#### Workspace setup ####
library(tidyverse)
library(readxl)
library(lubridate)
library(broom)
library(car)
library(rstanarm)
library(modelsummary)
library(performance)

#### Read data ####
set.seed(666)
data <- read_csv("data/analysis_data/model.csv")
head(data)

### General Model ####
general_model <- lm(data = data,
                    interest_rate ~ gdp_growth + unemployment_rate + USA_saving + EAP_exclude)
summary(general_model)

#### Save model ####
saveRDS(
  general_model,
  file = "models/general_model.rds"
)


