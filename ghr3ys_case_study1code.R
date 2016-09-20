#Gabriel Rushin codekerrk

setwd("~/Documents/ SYS 6018-001 /Crime project")

source("ghr3ys_case_study1.utl.R")
source("CrimeUtil2.R")
library(plyr) #must load before dplyr
library(readr)
library(dplyr)
library(readxl)
library(ks)
library(RColorBrewer)
library(MASS)


#Read in data from Crime
crime2016 <- read_csv('DataSets/Crime_Incidents__2016.csv')
crime2015 <- read_csv('DataSets/Crime_Incidents__2015.csv')
crime2014 <- read_csv('DataSets/Crime_Incidents__2014.csv')
crime2013 <- read_csv('DataSets/Crime_Incidents__2013.csv')
crime2012 <- read_csv('DataSets/Crime_Incidents__2012.csv')
crime2011 <- read_csv('DataSets/Crime_Incidents__2011.csv')

#Read in data with only theft and assualt
crime2016_assault_theft<-assault.theft.clean.data(crime2016)
crime2015_assault_theft<-assault.theft.clean.data(crime2015)
crime2014_assault_theft<-assault.theft.clean.data(crime2014)
crime2013_assault_theft<-assault.theft.clean.data(crime2013)
crime2012_assault_theft<-assault.theft.clean.data(crime2012)
crime2011_assault_theft<-assault.theft.clean.data(crime2011)



#all data combine Crime_11_16_assualt_theft only has assualt and theft
crime_11_16<-rbind(crime2016, crime2015, crime2014, crime2013, crime2012, crime2011)
crime_11_16_assault_theft<-assault.theft.clean.data(crime_11_16)

#Data of Crime based on Seasonality
#Below is showing based upon seasons.
# Spring: March 20  thru June 20 
# Summer: June 21 thru Sept. 21
# Fall: Sept. 22 thru Dec. 20
# Winter: Dec. 21 thru March 19
crime_11_16_spring<-seasonal.crime.function.spring(crime_11_16)
crime_11_16_summer<-seasonal.crime.function.summer(crime_11_16)
crime_11_16_fall<-seasonal.crime.function.fall(crime_11_16)
crime_11_16_winter<-seasonal.crime.function.winter(crime_11_16)

crime_11_16_spring_AT<-seasonal.crime.function.spring(crime_11_16_assault_theft)
crime_11_16_summer_AT<-seasonal.crime.function.summer(crime_11_16_assault_theft)
crime_11_16_fall_AT<-seasonal.crime.function.fall(crime_11_16_assault_theft)
crime_11_16_winter_AT<-seasonal.crime.function.winter(crime_11_16_assault_theft)

#Percent.of.crime.shfit shows the percentage of crime that occurs in the evening, midnight, or day
# I must find the what they define as "midnight". This is based upon shfits.(beleive this better
#helps police)
percent.of.crime.shift(crime_11_16)
percent.of.crime.shift(crime2016)
percent.of.crime.shift(crime2015)
percent.of.crime.shift(crime2014)
percent.of.crime.shift(crime2013)
percent.of.crime.shift(crime2012)
percent.of.crime.shift(crime2011)

percent.of.crime.shift(crime_11_16_assault_theft)
percent.of.crime.shift(crime2016_assault_theft)
percent.of.crime.shift(crime2015_assault_theft)
percent.of.crime.shift(crime2014_assault_theft)
percent.of.crime.shift(crime2013_assault_theft)
percent.of.crime.shift(crime2012_assault_theft)
percent.of.crime.shift(crime2011_assault_theft)


percent.of.crime.shift(crime_11_16_spring_AT)
percent.of.crime.shift(crime_11_16_summer_AT)
percent.of.crime.shift(crime_11_16_fall_AT)
percent.of.crime.shift(crime_11_16_winter_AT)

#KDE's
library(maptools)
library(maps)
library(mapproj)
library(rgdal)

dsn <-"/Users/Gabriel/Documents/ SYS 6018-001 /Crime project/Ward__2012/"
shapefile <- "Ward__2012"
dc<- readOGR(dsn,shapefile)
summary(dc)
plot(dc)

aban
# read abandon vechile data
#15, 15
abandon_df<-sample.crime('DataSets/Crime_Incidents__2016.csv', -1, start.month = 1, end.month = 12)
# get KDE sample data 
kde.sample.points = abandon_df[,c("x","y")]

# get estimation points for KDE -- a grid of evenly spaced points
kde.est.points = get.grid.points(city.boundary, kde.resolution.meters, FALSE)

# run and plot KDE, using 500 points from the sample
kde.est = run.spatial.kde(kde.sample.points, kde.est.points, 500) 
plot.spatial.kde(kde.est, kde.est.points)

# add city boundary to KDE plot for interpretability
plot(city.boundary, add=TRUE)

