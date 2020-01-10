source("https://raw.githubusercontent.com/UKGANG/IST-687/master/mungling/Data_Cleaner.R")

pos <- "https://raw.githubusercontent.com/UKGANG/IST-687/master/analysis/positive-words.txt"
neg <- "https://raw.githubusercontent.com/UKGANG/IST-687/master/analysis/negative-words.txt"
rawData$commented <- as.numeric(!is.na(rawData$Flight.freeText))
comments <- na.omit(rawData$Flight.freeText)
p <- scan(pos, character(0), sep = "\n")
n <- scan(neg, character(0), sep = "\n")
p <- p[-1:-34]
n <- n[-1:-34]

installLibrary("tm")
installLibrary("tidyverse")
tdMatrix <- comments %>% 
  VectorSource() %>% 
  Corpus() %>% 
  tm_map(content_transformer(tolower)) %>% 
  tm_map(removePunctuation) %>% 
  tm_map(removeNumbers) %>% 
  tm_map(removeWords, c(stopwords("english"), 'flight', 'southeast')) %>% 
  tm_map(removeWords, n) %>% 
  # tm_map(n) %>% 
  TermDocumentMatrix()

inspect(tdMatrix)

# Find the most frequent(80 percentile) word among documents, sort in descending order
wordCounts <- tdMatrix %>% 
  as.matrix() %>% 
  rowSums() %>% 
  sort(decreasing = T)
criticalWordCounts <- wordCounts[which(wordCounts > quantile(wordCounts, c(0.95))[[1]])]
head(criticalWordCounts)

# Get the actual words
criticalWords <- names(criticalWordCounts)
head(criticalWords)

# Visualize the word cloud
installLibrary("ggplot")
installLibrary("wordcloud")
criticalCloudFrame <- data.frame(word = criticalWords, freq = criticalWordCounts)
ggplot(data = criticalCloudFrame) + 
  aes(x=reorder(word, freq), y=freq) + 
  geom_point() + 
  theme(axis.text.x=element_text(angle=90, hjust=1))

set.seed(90)
text(x=0.5, y=0.5, "Title of my first plot")
wordcloud(criticalCloudFrame$word, criticalCloudFrame$freq
          , colors = brewer.pal(8, "Dark2"), main="Title")
View(criticalCloudFrame)