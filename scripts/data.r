## Author: Austin Stephen
## date: 4/12/2022

library(dplyr)
library(tidyverse)

data <- read.csv("data/SMP500.csv")

## date to numeric so models can be built 
data <- data %>% mutate(
  date = as.Date(Date,format ="%Y-%d-%m"),
  dateNumeric = as.numeric(date) + 36159,
  dateNumeric2 = dateNumeric**2,
  dateNumeric3 = dateNumeric**3)

## building models to look at the residuals
mLinear <- lm(SP500 ~ dateNumeric, data=data)

mQuad <- lm(SP500 ~ dateNumeric + dateNumeric2, data=data)  

mCube <- lm(SP500 ~ dateNumeric + dateNumeric2 + dateNumeric3, data=data)  

data$residualsLinear <- mLinear$residuals
data$residualsQuad <- mQuad$residuals
data$residualsCube <- mCube$residuals

# plotting the data and looking at the residuals
data %>% ggplot(aes(x=dateNumeric, y=SP500))+
  geom_point()+
  geom_smooth(method = "lm")

data %>% ggplot(aes(x=dateNumeric, y=residualsLinear))+
  geom_point()+
  geom_smooth(method = )

data %>% ggplot(aes(x=dateNumeric, y=residualsQuad))+
  geom_point()+
  geom_smooth()

data %>% ggplot(aes(x=dateNumeric, y=residualsCube))+
  geom_point()+
  geom_smooth()


## discretize the data for Natalie's work
data <- data %>% mutate(
  discrRes1 = as.factor(round(residualsCube/80, digits = 0)*80),
  discrRes2 = as.factor(round(residualsCube/110, digits = 0) *110),
  discrRes3 = as.factor(round(residualsCube/140, digits = 0) *140),
  discrRes4 = as.factor(round(residualsCube/150, digits = 0) * 150),
  discrRes5 = as.factor(round(residualsCube/175, digits = 0) * 175),
  discrRes6 = as.factor(round(residualsCube/200, digits = 0) * 200),
  discrRes7 = as.factor(round(residualsCube/250, digits = 0) * 250)
) %>%
  select(-Date)
#summary(data)

dataWrite <- data %>% select(-c(dateNumeric2,dateNumeric3))
## writting the data
write.csv(dataWrite,"data/SMP500_mod.csv", row.names = FALSE)
#tmp<- read.csv("data/SMP500_mod.csv")


# Repeating everything for post 1900 --------------------------------------

# remove observations pre 1900
data_1900 <- data %>% filter( dateNumeric > 10592)


# building models to get the residuals
mLinear <- lm(SP500 ~ dateNumeric, data=data_1900)

mQuad <- lm(SP500 ~ dateNumeric + dateNumeric2, data=data_1900)  

mCube <- lm(SP500 ~ dateNumeric + dateNumeric2 + dateNumeric3, data=data_1900)  

# summary(mLinear)
# summary(mQuad)
# summary(mCube)

data_1900$residualsLinear <- mLinear$residuals
data_1900$residualsQuad <- mQuad$residuals
data_1900$residualsCube <- mCube$residuals

# removing junk columns
dataWrite <-data_1900 %>% select(-c(dateNumeric2,dateNumeric3))

## writting the data
write.csv(dataWrite,"data/SMP500_post_1900.csv", row.names = FALSE)

# Repeating everything from 1950 on ---------------------------------------
# Repeating everything for post 1900 --------------------------------------

# remove observations pre 1900
data_1950 <- data %>% filter( dateNumeric > 28854)

summary(data_1950)

# building models to get the residuals
mLinear <- lm(SP500 ~ dateNumeric, data=data_1950)

mQuad <- lm(SP500 ~ dateNumeric + dateNumeric2, data=data_1950)  

mCube <- lm(SP500 ~ dateNumeric + dateNumeric2 + dateNumeric3, data=data_1950)  

# summary(mLinear)
# summary(mQuad)
# summary(mCube)

data_1950$residualsLinear <- mLinear$residuals
data_1950$residualsQuad <- mQuad$residuals
data_1950$residualsCube <- mCube$residuals

# removing junk columns
dataWrite <-data_1950 %>% select(-c(dateNumeric2,dateNumeric3))

## writting the data
write.csv(dataWrite,"data/SMP500_post_1950.csv", row.names = FALSE)

