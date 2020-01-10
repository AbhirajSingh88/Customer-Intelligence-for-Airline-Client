Partner_Name = character()
proportion = numeric()
length = numeric()
#Create 3 vectors
for(val in unique(rawData$Flight.Ticket.Partner.Name)){
  Partner_Name = append(Partner_Name,val)
  proportion = append(proportion,length(rawData$Flight.Ticket.Partner.Name[rawData$Flight.Ticket.Partner.Name == val])/length(rawData$Flight.Ticket.Partner.Name))
  length = append(length,length(rawData$Flight.Ticket.Partner.Name[rawData$Flight.Ticket.Partner.Name == val]))
}

Partnerdf <- data.frame(Partner_Name,proportion,length)
Partnerdf <- Partnerdf[order(Partnerdf$length,decreasing = TRUE),]
View(Partnerdf)

#Ratio of detractor to total

DetractorProp <- function(Airline_Name)
{
  return(sum(rawData$Recommend.Likelihood[rawData$Flight.Ticket.Partner.Name == Airline_Name] < 7,na.rm = TRUE)/length(rawData$Recommend.Likelihood[rawData$Flight.Ticket.Partner.Name == Airline_Name]))
}

for (var in Partnerdf$Partner_Name) {
  Partnerdf$det_ratio[Partnerdf$Partner_Name == var] <- DetractorProp(var)
}

#Ratio of detractor and passive to total

DetPassProp <- function(Airline_Name)
{
  return(sum(rawData$Recommend.Likelihood[rawData$Flight.Ticket.Partner.Name == Airline_Name] < 9,na.rm = TRUE)/length(rawData$Recommend.Likelihood[rawData$Flight.Ticket.Partner.Name == Airline_Name]))
}

for (var in Partnerdf$Partner_Name) {
  Partnerdf$detpas_ratio[Partnerdf$Partner_Name == var] <- DetPassProp(var)
}

