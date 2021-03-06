
installLibrary("lsr")

mType <- filter(rawData, Person.Gender == 'Male')
fType <- filter(rawData, Person.Gender == 'Female')

# H0 Travel preferences on distance are the same *
# H1 Travel perferences on distance are different

mStat <- mType$Flight.Distance.Cnt
fStat <- fType$Flight.Distance.Cnt

t.test(mStat,fStat)

# H0 Travel preferences on price sensitiveness are the same
# H1 Travel perferences on price sensitiveness are different *

mStat <- mType$Person.Price.Sensitivity
fStat <- fType$Person.Price.Sensitivity

# Blue group is significant different with others
t.test(mStat,fStat)

# H0 Travel preferences on loyalty are the same *
# H1 Travel perferences on loyalty are different

mStat <- mType$Person.Loyalty
fStat <- fType$Person.Loyalty

t.test(mStat,fStat)

# H0 Travel preferences on shopping amount are the same *
# H1 Travel perferences on shopping amount are different

mStat <- mType$Flight.Airport.Shopping.Amount
fStat <- fType$Flight.Airport.Shopping.Amount

t.test(mStat,fStat)

# H0 Travel preferences on food spending are the same
# H1 Travel perferences on food spending are different *

mStat <- mType$Flight.Airport.Food.Amount
fStat <- fType$Flight.Airport.Food.Amount

t.test(mStat,fStat)
