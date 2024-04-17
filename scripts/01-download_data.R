#### Preamble ####
# Purpose: Downloads and saves the data from FRED database
# Author: Yingzhi Zhang
# Date: 28 Mar 2024 
# Contact: yingzhi.zhang@mail.utoronto.ca
# License: MIT


#### Workspace setup ####
library(tidyverse)
library(readxl)
library(writexl)

#### Download data ####
#Part1:US data from FRED
interest_rate <- read_csv("https://fred.stlouisfed.org/graph/fredgraph.csv?bgcolor=%23e1e9f0&chart_type=line&drp=0&fo=open%20sans&graph_bgcolor=%23ffffff&height=450&mode=fred&recession_bars=on&txtcolor=%23444444&ts=12&tts=12&width=1318&nt=0&thu=0&trc=0&show_legend=yes&show_axis_titles=yes&show_tooltip=yes&id=FEDFUNDS&scale=left&cosd=1954-07-01&coed=2024-03-01&line_color=%234572a7&link_values=false&line_style=solid&mark_type=none&mw=3&lw=2&ost=-99999&oet=99999&mma=0&fml=a&fq=Annual&fam=avg&fgst=lin&fgsnd=2020-02-01&line_index=1&transformation=lin&vintage_date=2024-04-17&revision_date=2024-04-17&nd=1954-07-01")
gdp_growth <- read_csv("https://fred.stlouisfed.org/graph/fredgraph.csv?bgcolor=%23e1e9f0&chart_type=line&drp=0&fo=open%20sans&graph_bgcolor=%23ffffff&height=450&mode=fred&recession_bars=on&txtcolor=%23444444&ts=12&tts=12&width=1318&nt=0&thu=0&trc=0&show_legend=yes&show_axis_titles=yes&show_tooltip=yes&id=GDP&scale=left&cosd=1947-01-01&coed=2023-10-01&line_color=%234572a7&link_values=false&line_style=solid&mark_type=none&mw=3&lw=2&ost=-99999&oet=99999&mma=0&fml=a&fq=Annual&fam=avg&fgst=lin&fgsnd=2020-02-01&line_index=1&transformation=pch&vintage_date=2024-04-17&revision_date=2024-04-17&nd=1947-01-01")
unemployment <- read_csv("https://fred.stlouisfed.org/graph/fredgraph.csv?bgcolor=%23e1e9f0&chart_type=line&drp=0&fo=open%20sans&graph_bgcolor=%23ffffff&height=450&mode=fred&recession_bars=on&txtcolor=%23444444&ts=12&tts=12&width=1318&nt=0&thu=0&trc=0&show_legend=yes&show_axis_titles=yes&show_tooltip=yes&id=UNRATE&scale=left&cosd=1948-01-01&coed=2024-03-01&line_color=%234572a7&link_values=false&line_style=solid&mark_type=none&mw=3&lw=2&ost=-99999&oet=99999&mma=0&fml=a&fq=Annual&fam=avg&fgst=lin&fgsnd=2020-02-01&line_index=1&transformation=lin&vintage_date=2024-04-17&revision_date=2024-04-17&nd=1948-01-01")
private_saving <- read_csv("https://fred.stlouisfed.org/graph/fredgraph.csv?bgcolor=%23e1e9f0&chart_type=line&drp=0&fo=open%20sans&graph_bgcolor=%23ffffff&height=450&mode=fred&recession_bars=on&txtcolor=%23444444&ts=12&tts=12&width=1318&nt=0&thu=0&trc=0&show_legend=yes&show_axis_titles=yes&show_tooltip=yes&id=PSAVERT&scale=left&cosd=1959-01-01&coed=2024-02-01&line_color=%234572a7&link_values=false&line_style=solid&mark_type=none&mw=3&lw=2&ost=-99999&oet=99999&mma=0&fml=a&fq=Annual&fam=avg&fgst=lin&fgsnd=2020-02-01&line_index=1&transformation=lin&vintage_date=2024-04-17&revision_date=2024-04-17&nd=1959-01-01")

#part2: World bank data
gross_saving <- read_xlsx(paste0(gsub("/scripts", "", getwd()), "/data/raw_data/P_Data_Extract_From_World_Development_Indicators.xlsx"))

#### Save data ####
write_csv(interest_rate, "data/raw_data/US_interest_rate.csv") 
write_csv(gdp_growth, "data/raw_data/US_gdp_growth_rate.csv") 
write_csv(unemployment, "data/raw_data/US_unemployment_rate.csv")          
write_csv(private_saving, "data/raw_data/US_private_saving_rate.csv") 
write_xlsx(gross_saving, "data/raw_data/gross_saving.xlsx")
