echo=F
source("https://raw.githubusercontent.com/UKGANG/IST-687/master/mungling/dummy_builder.R")

createIQRBox <- function(data, x, y, xtitle, ytitle="AirlineCode") {
  x = data[,which(colnames(rawData) == x)];
  y = data[,which(colnames(rawData) == y)];
  ggplot() +
    aes(x=x, y=y) +
    geom_boxplot() +
    labs(x = xtitle, y=ytitle) +
    scale_y_continuous(labels=scales::comma)
}

createIQRBox(rawData, "Flight.Ticket.Partner.Code", "Person.Age", "Age")
createIQRBox(rawData, "Flight.Ticket.Partner.Code", "Person.Price.Sensitivity", "Price Sensitivity")
createIQRBox(rawData, "Flight.Ticket.Partner.Code", "Person.First.Flight.Year", "First Flight Year")
# Outlier
createIQRBox(rawData, "Flight.Ticket.Partner.Code", "Person.Flights.Per.Year", "Flight per Year")
# Outlier
createIQRBox(rawData, "Flight.Ticket.Partner.Code", "Person.Total.Freq.Flyer.Accts", "Frequent Flyer Accounts")
# Outlier Null
createIQRBox(rawData, "Flight.Ticket.Partner.Code", "Flight.Departure.Delay.Minute", "Departure Delay Minute")
# Outlier Null
createIQRBox(rawData, "Flight.Ticket.Partner.Code", "Flight.Arrival.Delay.Minute", "Arrival Delay Minute")
# Outlier Null
createIQRBox(rawData, "Flight.Ticket.Partner.Code", "Flight.Time.Minutes", "Flight Minute")
# Outlier
createIQRBox(rawData, "Flight.Ticket.Partner.Code", "Flight.Distance.Cnt", "Flight Distance")
# Outlier
createIQRBox(rawData, "Flight.Ticket.Partner.Code", "Flight.Airport.Shopping.Amount", "Shopping Amount in Airport")
# Outlier
createIQRBox(rawData, "Flight.Ticket.Partner.Code", "Flight.Airport.Food.Amount", "Food Spending in Airport")