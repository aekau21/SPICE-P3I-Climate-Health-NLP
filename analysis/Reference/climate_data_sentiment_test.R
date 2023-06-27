# install.packages("syuzhet")
# install.packages("textdata")
# install.packages("ggplot2")
# install.packages("jsonlite")

library(syuzhet) # sentiment analysis functions
library(ggplot2) # ggplot functions
library(jsonlite) # allows us to read json files

 
# import dataset
climate_fever_data <- stream_in(file("data/climate-fever-dataset-r1.jsonl"))
View(climate_fever_data)

# create lexicon
nrc_lexicon <- get_sentiments("nrc")
nrc_lexicon

# make a vector
climate_fever_vector <- as.character(climate_fever_data$claim)
climate_fever_vector

# Make sentiment analysis raw
climate_fever_sentiment <- get_nrc_sentiment(climate_fever_vector)
climate_fever_sentiment

# Make sentiment analysis numbered
climate_fever_sentiment_score <- data.frame(colSums(climate_fever_sentiment[,]))
climate_fever_sentiment_score

# Viz Prep 1
names(climate_fever_sentiment_score) <- 'score'
names(climate_fever_sentiment_score)

# Viz Prep 2
climate_fever_sentiment_score <- cbind("sentiment"=rownames(climate_fever_sentiment_score),
                                       climate_fever_sentiment_score)
names(climate_fever_sentiment_score)

# Viz Prep 3
rownames(climate_fever_sentiment_score) <- NULL
climate_fever_sentiment_score

# Sentiment analysis visualization
ggplot(data=climate_fever_sentiment_score, aes(x=sentiment, y=score)) +
  geom_bar(aes(fill=sentiment), stat="identity") +
  theme(legend.position="none") +
  xlab("Sentiments") +
  ylab("Scores") +
  ggtitle("Sentiment Analysis on Climate Fever Data")

#Remove the positive and negative sentiment results
climate_fever_sentiment_score[,]
climate_fever_sentiment_score_TWO <- climate_fever_sentiment_score[1:8,]

# Rerun sentiment analysis visualization
ggplot(data=climate_fever_sentiment_score_TWO, aes(x=sentiment, y=score))+
  geom_bar(aes(fill=sentiment), stat="identity") +
  theme(legend.position="none")+
  xlab("Sentiments")+
  ylab("Scores")+
  ggtitle("Sentiment Analysis on Climate Fever Data")

