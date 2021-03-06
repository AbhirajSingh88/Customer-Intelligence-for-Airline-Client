

partnerFilter <- function(data, type) {
  return (filter(data, Flight.Ticket.Partner.Code %in% type));
}

nameVectors <- c("Person.Flights.Per.Year"
                 , "Person.Total.Freq.Flyer.Accts"
                 , "Flight.Distance.Cnt"
                 , "Flight.Airport.Shopping.Amount"
                 , "Flight.Airport.Food.Amount"
                 
                 , "Flight.Departure.Delay.Minute"
                 , "Flight.Arrival.Delay.Minute"
                 , "Flight.Time.Minutes"
);

# Outlier customizing
for (vec in nameVectors) {
  rawData[which(!is.na(rawData[,vec])), vec] <- strategy.winsorizeStrategy(rawData[which(!is.na(rawData[,vec])),], c(vec))[,vec]
}

for (vec in nameVectors) {
  print(head(sort(rawData[which(!is.na(rawData[,vec])), vec], decreasing = T)))
}

rawData <- dummy_columns(rawData, "Person.Gender")
rawData <- dummy_columns(rawData, "Flight.Airline.Membership.Class")
rawData <- dummy_columns(rawData, "Flight.Cabin.Class")
rawData <- dummy_columns(rawData, "Flight.Travel.Type")

rawData <- select(rawData, -c("Person.Gender_Male"
                              , "Flight.Airline.Membership.Class_Platinum"
                              , "Flight.Cabin.Class_Business"
                              , "Flight.Travel.Type_Business travel"
                              ))


rawData$Flight.Cabin.Class_Eco_Plus <- rawData[,"Flight.Cabin.Class_Eco Plus"]
rawData$Flight.Travel.Type_Personal_Travel <- rawData[,"Flight.Travel.Type_Personal Travel"]
rawData$Flight.Travel.Type_Mileage_tickets <- rawData[,"Flight.Travel.Type_Mileage tickets"]
rawData$Flight.Cancelled <- as.numeric(ifelse(rawData$Flight.Cancelled =="Yes" | rawData$Flight.Cancelled == 1, 1, 0))
rawData$Flight.Departure.Delay <- as.numeric(rawData$Flight.Departure.Delay.Minute > 0)

type <- c(""
          , "WN"
          , "DL"
          # , "OO"
          , "EV"
          , "OU"
          , "US"
          , "AA"
          , "MQ"
          , "B6"
          , "AS"
          , "FL"
          , "F9"
          , "VX"
          , "HA"
);

rawData <- partnerFilter(rawData, type)
trainList <- createDataPartition(y=rawData$Recommend.Likelihood, p=.67, list=F)

trainSet <- rawData[trainList,]
testSet <- rawData[-trainList,]
modelData <- trainSet

View(rawData)

modelData <- trainSet
model <- lm(formula = Recommend.Likelihood~
              Monday +
              Tuesday +
              Wednesday +
              Thursday +
              Friday +
              Saturday +
              Sunday +
              Person.Age +
              Person.Gender_Female + 
              Person.Loyalty + 
              Person.Price.Sensitivity + 
              Person.First.Flight.Year + 
              Person.Flights.Per.Year + 
              Person.Total.Freq.Flyer.Accts +
              Flight.Departure.Delay +
              Flight.Departure.Delay.Minute +
              Flight.Arrival.Delay.Minute +
              Flight.Time.Minutes +
              Flight.Distance.Cnt +
              Flight.Cancelled +
              
              Flight.Airport.Shopping.Amount + 
              Flight.Airport.Food.Amount + 
              Flight.Airline.Membership.Class_Blue +
              Flight.Airline.Membership.Class_Silver + 
              Flight.Airline.Membership.Class_Gold + 
              Flight.Travel.Type_Personal_Travel +
              Flight.Travel.Type_Mileage_tickets +

              Flight.Cabin.Class_Eco +  
              Flight.Cabin.Class_Eco_Plus + 

              Flight.Ticket.Partner.Code 
            , data = modelData)
summary(model)
