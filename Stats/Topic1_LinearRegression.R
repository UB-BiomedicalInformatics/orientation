#####################################################
##      
##      Statistical Topic 1: Linear Regression
##      Workshop Date: 2018-7-12
##      Prepared by Sarah Mullin (sarahmul@buffalo.edu)
##
####################################################


## Install Packages ====
# install.packages("tidyverse")     # Metalibrary of tools for tidy data munging automatically loads the following:
# install.packages("dplyr")         # Tools for data manipulation
# install.packages("ggplot2")       # Grammar of Graphics plotting
# install.packages("readxl")      # Read Excel files
# install.packages("gapminder")   # Gapminder dataset
#install.packages("GGally")
#install.packages("pastecs")

# Load required packages ====
library(tidyverse)  # Functions for data manipulation
library(gapminder)  # Gapminder data
library(ggplot2)
library(GGally)
library(pastecs)

# Read data into global environment ====
data("gapminder")
View(gapminder)

# We are only going to look at the year 2007 for multiple linear regression. Why?

# Exploratory Data Analysis ====
# 142 Countries

# Our response variable is life expectancy--we want to predict the life expectency of 

# Scatterplots for GDP per Capita and Population
gapminder %>% filter(year==2007) %>%
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point() #for gdpPercapita

gapminder %>% filter(year==2007) %>%
  ggplot(aes(x = pop, y = lifeExp)) +
  geom_point() #for population

# Box plots for the categorical variable continent
gapminder %>% filter(year==2007) %>%
  ggplot(aes(x = continent, y = lifeExp)) + geom_boxplot()

#gapminder %>% 
 # ggplot(aes(year, lifeExp, group = country)) +
#  geom_line(alpha = 1/3)

# Create dataset filtering out years that are not 2007
gapminder_2007 <- gapminder %>% filter(year==2007)

# Descriptive Statistics for 2007
#library(pastecs)
#stat.desc(gapminder_2007[4:6])
# Continuous Variables
summary(gapminder_2007[4:6])

# Categorical Variables
table(gapminder_2007$continent)

# Scatterplot Matrix 
ggscatmat(gapminder_2007, columns = 4:6, alpha=0.8)
ggscatmat(gapminder_2007, columns = 4:6, color="continent", alpha=0.8)

# Pearson Product Moment Correlation
cor(gapminder_2007[,4:6], method="pearson")

# What if our relationship between two continuous variables is not linear?
cor(gapminder_2007[,4:6], method="spearman")

# Model predicting life expectancy by population, GDP per capita, and continent for 2007
model <- lm(lifeExp~pop+gdpPercap+factor(continent), data=gapminder_2007) #?lm(response ~ predictors)
summary(model) 

# Confidence intervals for coefficients
confint(model)

# Sum of squares table
anova(model)

# 95% Prediction Interval for lifeExp when the continent=Africa, population=500000, and gdpPercap=1000
new.pred <- data.frame(pop=500000, gdpPercap=1000, continent="Africa")
predict.lm(model, new.pred,interval="prediction" )

# Note: Prediction Intervals vs. Confidence Intervals (http://statweb.stanford.edu/~susan/courses/s141/horegconf.pdf)

# Checking Model Fit: 
par(mfrow=c(2,2))
plot(model)


# Transformation of the Response (Good resource: https://onlinecourses.science.psu.edu/stat501/node/322/)
model_transform <- lm((lifeExp^2)~pop+gdpPercap+factor(continent), data=gapminder_2007) #?lm(response ~ predictors)
summary(model_transform)
plot(model_transform)

# You should try using a power transformation on y when the variances are unequal and the error terms are not normal.

# Full vs. Reduced F-test for getting rid of Population
reduced<-lm((lifeExp^2)~gdpPercap+factor(continent), data=gapminder_2007)
full<-lm((lifeExp^2)~pop+gdpPercap+factor(continent), data=gapminder_2007)
anova(reduced, full) #compare the models

# Gamma Regression (constraints: y is in (0, /infty), suitable when we expect the linkage between mean and variance is fixed, ie. if you expect a small value of y, you should expect a small amount of variability in the observed values)
model_glm <- glm(lifeExp~pop+gdpPercap+factor(continent), family = Gamma(link = "inverse"), data=gapminder_2007) #can change links to be: inverse, log, identity
model_glm_ci <- confint(model_glm)
coef(model_glm)
summary(model_glm)

# Residual Deviance Test
1-pchisq(1.8087/0.01314,135)

# P-value is 0.4204 shows no lack of fit
plot(model_glm)









