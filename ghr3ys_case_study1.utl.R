library(plyr) #must load before dplyr
library(readr)
library(dplyr)
library(readxl)

percent.of.crime.shift<- function(crime.data2)
{
  crime.data<-crime.data2
  count.crime.time<-count(crime.data, "SHIFT")
  percent_of_total_crime<-count.crime.time
  percent_of_total_crime$freq<-percent_of_total_crime$freq/nrow(crime.data)
  colnames(percent_of_total_crime)[2]<-"freq_percent"
  print(count.crime.time)
  print(percent_of_total_crime)
  
}



# Spring: March 20  thru June 20 
# Summer: June 21 thru Sept. 21
# Fall: Sept. 22 thru Dec. 20
# Winter: Dec. 21 thru March 19
seasonal.crime.function.spring<-function(crime.data)
{
  seasonal_crime<-crime.data
  seasonal_temp<-seasonal_crime[(strftime(seasonal_crime$REPORTDATETIME, format = "%m-%d")> "03-20" & strftime(seasonal_crime$REPORTDATETIME, format = "%m-%d") < "06-20"),]
  
}

seasonal.crime.function.summer<-function(crime.data)
{
  seasonal_crime<-crime.data
  seasonal_temp<-seasonal_crime[(strftime(seasonal_crime$REPORTDATETIME, format = "%m-%d")> "06-21" & strftime(seasonal_crime$REPORTDATETIME, format = "%m-%d") < "09-21"),]
}

seasonal.crime.function.fall<-function(crime.data)
{
  seasonal_crime<-crime.data
  seasonal_temp<-seasonal_crime[(strftime(seasonal_crime$REPORTDATETIME, format = "%m-%d")> "09-22" & strftime(seasonal_crime$REPORTDATETIME, format = "%m-%d") < "12-20"),]
}

seasonal.crime.function.winter<-function(crime.data)
{
  seasonal_crime<-crime.data
  seasonal_temp<-seasonal_crime[(strftime(seasonal_crime$REPORTDATETIME, format = "%m-%d")> "12-21"),]
  seasonal_temp2<-seasonal_crime[(strftime(seasonal_crime$REPORTDATETIME, format = "%m-%d")< "03-19"),]
  seasonal_final<-rbind(seasonal_temp,seasonal_temp2)
  seasonal_final_2<-seasonal_final[!duplicated(seasonal_final),]
}




assault.theft.clean.data<-function(crime.data)
{
  data.assault<-crime.data[grep("ASSAULT", crime.data$OFFENSE), ]
  data.theft<-crime.data[grep("THEFT", crime.data$OFFENSE), ]
  data.assault.theft<-rbind(data.theft,data.assault)

}