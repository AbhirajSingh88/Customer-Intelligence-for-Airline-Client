echo = F
source("https://raw.githubusercontent.com/UKGANG/IST-687/master/mungling/Data_Cleaner.R")

#install packages
#install.packages("arules")
library(arules)
#install.packages("arulesViz")
library(arulesViz)
view(rawData)

#Create a dummy variable
rawData$DetractorDummy <- as.factor(as.integer(rawData$Recommend.Likelihood < 9))

#Remove Flight.Ticket.Partner.Code field
rawDataarm <- subset(rawData, select = -Flight.Ticket.Partner.Code)

str(rawDataarm)
# Create Transactions DataSet
rawDatax <- as(rawDataarm[, sapply(rawDataarm, class) %in% c('character', 'factor')],"transactions")

#Create Association Rules
ruleset <- apriori(rawDatax, 
                   # Set a minimum value for support and confidence
                   parameter=list(support=0.05,confidence=0.5),
                   # Limit the right hand side to Survived = Yes
                   appearance = list(default="lhs", rhs=("DetractorDummy=0")))
#View Association rules
inspectDT(ruleset)
# Plot Parallel coordinates plot
plot(ruleset, method = "paracoord")

#Create Association Rules
ruleset <- apriori(rawDatax, 
                   # Set a minimum value for support and confidence
                   parameter=list(support=0.25,confidence=0.6),
                   # Limit the right hand side to Survived = Yes
                   appearance = list(default="lhs", rhs=("DetractorDummy=1")))
#View Association rules
inspectDT(ruleset)
# Plot Parallel coordinates plot
plot(ruleset, method = "paracoord")



