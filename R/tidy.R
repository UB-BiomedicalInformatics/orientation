#####################################################
##      
##      Tidy Gapminder data
##      Workshop Date: 2018-7-11
##      Prepared by Jamie Bono (jamie@buffalo.edu)
##
####################################################

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

###############################################
# Goal: To get gapminder_from_csv to match structure of gapminder
###############################################

gapminder_clean <- gapminder_from_csv %>% 
  mutate(country = as.factor(country)) %>%    # Convert character to factor
  mutate(continent = as.factor(continent))    # Convert character to factor

summary(gapminder)
summary(gapminder_clean)

glimpse(gapminder)
glimpse(gapminder_clean)

# Clean up workspace ====
# rm(gapminder_clean, gapminder_from_csv)
