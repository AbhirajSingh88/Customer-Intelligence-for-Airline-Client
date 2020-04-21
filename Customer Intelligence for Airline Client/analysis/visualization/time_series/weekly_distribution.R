

ggplot(rawData) + 
  aes(x=weekDay) + 
  geom_histogram(binwidth = 1, color="white",alpha=0.5, position="identity")

