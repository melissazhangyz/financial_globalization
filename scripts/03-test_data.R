#### Preamble ####
# Purpose: Tests
# Author: Yingzhi
# Date: 6 Apr 2024
# Contact: yingzhi.zhang@mail.utoronto.ca
# License: MIT


#### Workspace setup ####
library(tidyverse)
library(lubridate)
library(readxl)
US_analysis_data <- read_csv("data/analysis_data/US_data.csv")
world_bank_saving <- read_xlsx("data/analysis_data/world_bank_data.xlsx")

#### Test data for US dataset ####
# Check if all dates are within 1960 to 2023
test_a <- all(US_analysis_data$DATE >= as.Date("1960-01-01") & US_analysis_data$DATE <= as.Date("2023-12-31"))
print(paste("Test A (DATE within 1960-2023):", test_a))

# Check if interest_rate is always larger than 0
test_b <- all(US_analysis_data$interest_rate > 0)
print(paste("Test B (interest_rate > 0):", test_b))

# Check private_saving and unemployment_rate are within 0-50
test_c <- all(US_analysis_data$private_saving >= 0 & US_analysis_data$private_saving <= 50) &
  all(US_analysis_data$unemployment_rate >= 0 & US_analysis_data$unemployment_rate <= 50)
print(paste("Test C (private_saving and unemployment_rate within 0-50):", test_c))

# Filter data for post-2000 and check if current_account values are negative
post_2000_data <- filter(US_analysis_data, DATE > as.Date("2000-01-01"))
test_d <- all(post_2000_data$current_account < 0)
print(paste("Test D (current_account post-2000 is negative):", test_d))

#### Test data for world bank dataset ####
# Check if all dates are within 1960 to 2023
test_e <- all(world_bank_saving$Time >= as.Date("1960-01-01") & world_bank_saving$Time <= as.Date("2023-12-31"))
print(paste("Test E (DATE within 1960-2023):", test_e))

# Test f: US rate always smaller than China
us_smaller_china <- world_bank_saving$USA < world_bank_saving$China
test_f <- all(us_smaller_china, na.rm = TRUE)  # Remove NA values for comparison
print(paste("Test f (US rate always smaller than China):", test_g))

# Test g: All rates are greater than 0 (ignoring NA)
rates_columns <- world_bank_saving[, -1]  # Exclude the 'Time' column
test_h <- all(rates_columns > 0, na.rm = TRUE)
print(paste("Test H (All rates greater than 0, except NA):", test_h))
