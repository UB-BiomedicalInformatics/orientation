#####################################################
##      
##      Statistical Topic 2: Supervised Classification:
##                           Logistic Regression
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
#install.packages("ElemStatLearn")
#install.packages("pROC")
#install.packages("ROCR")


# Load required packages ====
library(tidyverse)  # Functions for data manipulation
library(gapminder)  # Gapminder data
library(ggplot2)
library(GGally)
library(pastecs)
library(ElemStatLearn)
library(pROC)
library(ROCR)


# Logistic Regression: Sigmoid Function
# Sigmoid Function
my_sigmoid=function(z){
  1/(1+exp(-z))}

# For large positive values of x, the sigmoid should be close to 1, while for large negative values, the sigmoid should be close to 0. Evaluating sigmoid(0) should give exactly 0.5.
my_sigmoid(0)
my_sigmoid(10^10)
my_sigmoid(-10^(10))

x=seq(-10,10, by=0.1)
y=my_sigmoid(x)

plot(x,y,type="l",col="red",xlab="",ylab="",main="Sigmoid function (Logistic curve)")
abline(v=0,lty = 2,col="gray 70")
abline(h=0.5,lty = 2,col="gray70")

# Read data into global environment ====
data("SAheart")
View(SAheart)

# Data Source: http://www-bcf.usc.edu/~gareth/ISL/index.html 

# Split data into training and testing sets

## 75% of the sample size
smp_size <- floor(0.75 * nrow(SAheart))

## set the seed to make your partition reproducible
set.seed(999)
train_ind <- sample(seq_len(nrow(SAheart)), size = smp_size)

train <- SAheart[train_ind, ]
test <- SAheart[-train_ind, ]

# Exploratory Data Analysis ====

# Our response variable is congestive heart disease (chd)

# Continuous Variables
summary(train[,c(1:4,6:9)])

# Categorical Variables
table(train$famhist)
table(train$chd)

# Scatterplot Matrix 
scatterplot=train[, c(1:4,6:10)]
scatterplot$chd <- factor(scatterplot$chd)
ggscatmat(scatterplot, columns = 1:8, color = "chd",  alpha=0.8)

# Sigmoid Function
my_sigmoid=function(z){
  1/(1+exp(-z))}

# For large positive values of x, the sigmoid should be close to 1, while for large negative values, the sigmoid should be close to 0. Evaluating sigmoid(0) should give exactly 0.5.
my_sigmoid(0)
my_sigmoid(10^10)
my_sigmoid(-10^(10))

x=seq(-10,10, by=0.1)
y=my_sigmoid(x)

plot(x,y,type="l",col="red",xlab="",ylab="",main="Sigmoid function (Logistic curve)")
abline(v=0,lty = 2,col="gray 70")
abline(h=0.5,lty = 2,col="gray70")
# Model predicting chd using other variables
glm.fit = glm(factor(chd) ~ ., data=train, family = binomial)
glm.probs = predict(glm.fit, test, type="response")

# Accuracy: percent correct
glm.pred = rep(0,dim(test)[1])
glm.pred[glm.probs>.5]=1
chd.test = test$chd
table(chd.test, glm.pred)
mean(glm.pred==chd.test)

#ROC curve and Area Under the Curve
mroc<-roc(test$chd, glm.probs, plot=T)

# Area Under the Curve (AUC)
auc(mroc)
ci(mroc, of = c("auc"))
# Other Measures of Accuracy: Sensitivity, Specificity, PPV, NPV
coords(mroc, .5, "threshold", ret=c("sensitivity","specificity","ppv","npv"))
ci(mroc, of =c("se"))
# Good resource for doing it "by hand" in R and with regularization and using the R optimization package (https://datascienceplus.com/logistic-regression-regularized-with-optimization/)

# Another package you can use to compute, ROCR! F1, precision, recall!
## ROC curve
plot(performance(prediction(glm.probs, chd.test), 'tpr', 'fpr'))

## Precision/Recall Curve (when outcome data is rare, unbalanced)
plot(performance(prediction(glm.probs, chd.test), 'prec', 'rec'))
abline(a=0, b= 1)

# Exercise: build a more parsimonious model?
plot(mroc, col = "blue")
par(new = TRUE)
plot(mroc2, col = "green", xaxt = "n", yaxt = "n")
legend("right", legend = c("Model1", "Model2"), col = c("blue", "green"), lty = 1)

glm.fit2 = update(glm.fit,. ~.-sbp, data=train, family = binomial)
glm.probs2 = predict(glm.fit2, test, type="response")
mroc2<-roc(test$chd, glm.probs2, plot=T)
auc(mroc2)

