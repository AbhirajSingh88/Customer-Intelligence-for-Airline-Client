
installLibrary("rattle")
installLibrary("rpart.plot")
installLibrary("RColorBrewer")
trainList <- createDataPartition(y=rawData$Recommend.Likelihood, p=.67, list=F)
unique(rawData$Flight.Cancelled)

trainSet <- rawData[trainList,]
testSet <- rawData[-trainList,]
categorizedTable <- rawData %>% 
  group_by(Flight.Travel.Type, Flight.Cabin.Class, Flight.Airline.Membership.Class) %>% 
  summarize(
    median = median(Recommend.Likelihood)
    , stdev = sd(Recommend.Likelihood)
    , n = n()) %>% 
    mutate(freq = n/dim(rawData)[1]) %>% 
  arrange(desc(n))

categorizedTable

treeData <- select(rawData, c("Flight.Travel.Type", "Flight.Cabin.Class", "Flight.Airline.Membership.Class", "Recommend.Likelihood"))

rpartExp <- Recommend.Likelihood ~ 
  # Geom.Arrival.Airport.Longitude + 
  # Geom.Arrival.Airport.Latitude + 
  # Geom.Departure.Airport.Longitude +  
  # Geom.Departure.Airport.Latitude + 
  
  # Personal information
  Person.Age + 
  Person.Gender + 
  Person.Loyalty + 
  Person.Price.Sensitivity + 
  Person.First.Flight.Year + 
  Person.Flights.Per.Year + 
  Person.Total.Freq.Flyer.Accts + 
  
  # Current Flight timing information
  Flight.Departure.Delay.Minute +
  Flight.Departure.Scheduled.Hour +
  Flight.Arrival.Delay.Minute +
  # Flight.Time.Minutes +
  # Flight.Distance.Cnt +
  # Flight.Date +
  Flight.Cancelled +
  # 
  # Cost Related Information
  Flight.Airport.Shopping.Amount +
  Flight.Airport.Food.Amount +
  Flight.Airline.Membership.Class +
  Flight.Travel.Type +
  Flight.Cabin.Class
  # 
  # # Miscellaneous
  # Flight.Ticket.Partner.Code 

scoreTree <- rpart(rpartExp, data=trainSet, method="class") 

View(trainSet)

fancyRpartPlot(scoreTree)

trainSet <- filter(trainSet, Flight.Travel.Type == 'Personal Travel')

scoreTree <- rpart(rpartExp, data=trainSet, method="class") 

fancyRpartPlot(scoreTree)


