#####################################################
##      
##      Import and initial exploration of Gapminder data
##      Workshop Date: 2018-7-11
##      Prepared by Jamie Bono (jamie@buffalo.edu)
##
####################################################

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

