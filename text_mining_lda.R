require(topicmodels)
require(tm)
require(slam)

Dat <- read.csv(file.choose(), header=T, sep=",")
head(Dat$tweet_text)
Dat$tweet_text <- sapply(Dat$tweet_text,function(row) iconv(row,to = 'UTF-8'))

#Create a corpus
a <- Corpus(VectorSource(Dat$tweet_text))

# preprocessing 
a <- tm_map(a, tolower)
a <- tm_map(a, removePunctuation)
a <- tm_map(a, removeNumbers)
a <- tm_map(a, removeWords, stopwords("english"))

# Create Document Term Matrix
mat <- TermDocumentMatrix(a,control = list(minWordLength = 4))
dim(mat)

# tf - idf
term_tfidf <- 
  tapply(mat$v/row_sums(mat)[mat$i], mat$j, mean) * 
    log2(nDocs(mat)/col_sums(mat > 0))

term_tfidf

summary(term_tfidf)

dim(mat)

mat <- mat[row_sums(mat) > 0,]

dim(mat)
