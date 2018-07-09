#####################################################
##      
##      Import and initial exploration of Gapminder data
##      Workshop Date: 2018-7-11
##      Prepared by Jamie Bono (jamie@buffalo.edu)
##
####################################################

# Set working directory ====
getwd()
setwd("R")
getwd()

# Load required packages ====
library(tidyverse)  # Functions for data manipulation
library(gapminder)  # Gapminder data

# Read data into global environment ====
data("gapminder")
View(gapminder)

# Write data to csv file ====
write_csv(gapminder, "data/gapminder.csv")

# Read saved csv file for comparison ====
gapminder_from_csv <- read_csv("data/gapminder.csv")

# Examine the data structures ====
# Using base functions ----
View(gapminder)
View(gapminder_from_csv)

str(gapminder)
str(gapminder_from_csv)

summary(gapminder)
summary(gapminder_from_csv)

# Using dplyr functions ----
glimpse(gapminder)
glimpse(gapminder_from_csv)
