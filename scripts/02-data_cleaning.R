#### Preamble ####
# Purpose: Cleans the raw data and combine into two dataset
# Author: Yingzhi Zhang
# Date: 6 April 2024 
# Contact: yingzhi.zhang@mail.utoronto.ca
# License: MIT


#### Workspace setup ####
library(tidyverse)
library(readxl)
library(lubridate)
library(parquetize)

#### Processing US datase ####
#1. Interest rate
US_interest_rate <- read_csv("data/raw_data/US_interest_rate.csv")
US_interest_rate <- US_interest_rate %>%
  mutate(
    DATE = year(DATE),  
    interest_rate = round(as.numeric(FEDFUNDS), 3) 
  ) %>% 
  select(DATE, interest_rate) %>% 
  filter(DATE > 1959) %>% 
  drop_na()

#2. Real GDP
US_real_gdp <- read_csv("data/raw_data/US_real_gdp.csv")
US_real_gdp <- US_real_gdp %>% 
  mutate(
    DATE = year(DATE),  
    real_gdp = round(as.numeric(GDPC1), 3) 
  ) %>% 
  select(DATE, real_gdp) %>% 
  filter(DATE > 1959) %>% 
  drop_na()

#3. GDP growth rate
US_gdp_growth_rate <- read_csv("data/raw_data/US_gdp_growth_rate.csv")
US_gdp_growth_rate <- US_gdp_growth_rate %>% 
  mutate(
    DATE = year(DATE),  
    gdp_growth = round(as.numeric(GDP_PCH), 3) 
  ) %>% 
  select(DATE, gdp_growth) %>% 
  filter(DATE > 1959) %>% 
  drop_na()

#4. unemployment rate
US_unemployment_rate <- read_csv("data/raw_data/US_unemployment_rate.csv")
US_unemployment_rate <- US_unemployment_rate %>% 
  mutate(
    DATE = year(DATE),  
    unemployment_rate = round(as.numeric(UNRATE), 3)
    ) %>% 
  select(DATE, unemployment_rate) %>% 
  filter(DATE > 1959) %>% 
  drop_na()

#5. private saving rate
US_private_saving_rate <- read_csv("data/raw_data/US_private_saving_rate.csv")
US_private_saving_rate <- US_private_saving_rate %>% 
  mutate(
    DATE = year(DATE),  
    private_saving = round(as.numeric(PSAVERT), 3)
  ) %>% 
  select(DATE, private_saving) %>% 
  filter(DATE > 1959) %>% 
  drop_na()


#6. current account
US_current_account <- read_csv("data/raw_data/US_current_account.csv")
US_current_account <- US_current_account %>% 
  mutate(
    DATE = year(DATE),  
    current_account = round(as.numeric(NETFI), 3)
  ) %>% 
  select(DATE, current_account) %>% 
  filter(DATE > 1959) %>% 
  drop_na()

#7. combine into one dataset
US_analysis_data <-
  US_interest_rate %>% 
  mutate(gdp_growth = US_gdp_growth_rate$gdp_growth,
         real_gdp = US_real_gdp$real_gdp,
         unemployment_rate = US_unemployment_rate$unemployment_rate,
         private_saving = US_private_saving_rate$private_saving,
         current_account = US_current_account$current_account)

#### Processing world bank datase ####
world_bank_saving <- read_xlsx("data/raw_data/gross_saving.xlsx")
world_bank_saving <- world_bank_saving %>% 
  select(-1,-2,-4) %>% 
  mutate(Time = year(date(ISOdate(world_bank_saving$Time, 1, 1)))) %>% 
  mutate(across(-Time, ~round(as.numeric(replace(., . == "..", NA)), 3))) %>%
  slice(1:49) 

new_name <- c("Time", "USA", "World", "UK", "Brazil", "Canada", "China", "France", "Germany", "India",
              "Indonesia", "Israel", "Japan", "Malaysia", "Mexico", "Philippines", "Singapore", "Thailand",
              "Vietnam", "EAP_exclude", "EAP","EU","Middle_Income","Upper_Middle_Income")
colnames(world_bank_saving) <- new_name

head(world_bank_saving)

#### Combine for modeling dataset ####
USA_saving <- world_bank_saving %>% 
  filter(Time >= 1982 & Time <= 2022) %>% 
  select(USA)

EAP_exclude <- world_bank_saving %>% 
  filter(Time >= 1982 & Time <= 2022) %>% 
  select(EAP_exclude)

EAP <- world_bank_saving %>% 
  filter(Time >= 1982 & Time <= 2022) %>% 
  select(EAP)

China_saving <- world_bank_saving %>% 
  filter(Time >= 1982 & Time <= 2022) %>% 
  select(China)

Indonesia <- world_bank_saving %>% 
  filter(Time >= 1982 & Time <= 2022) %>% 
  select(Indonesia)

model_data <- US_analysis_data %>% 
  filter(DATE >= 1982 & DATE <= 2022) %>% 
  select(-current_account, -private_saving) %>% 
  mutate(USA_saving = USA_saving$USA,
         EAP_exclude = EAP_exclude$EAP_exclude,
         China_saving = China_saving$China,
         Indonesia_saving = Indonesia$Indonesia)

#### Save data set ####
write_parquet_at_once(US_analysis_data, "data/analysis_data/US_data.parquet")
write_csv(US_analysis_data, "data/analysis_data/US_data.csv")
write_xlsx(world_bank_saving, "data/analysis_data/world_bank_data.xlsx")
write_parquet_at_once(world_bank_data, "data/analysis_data/world_bank_data.parquet")
write_parquet_at_once(model_data, "data/analysis_data/model.parquet")
write_csv(model_data, "data/analysis_data/model.csv")
