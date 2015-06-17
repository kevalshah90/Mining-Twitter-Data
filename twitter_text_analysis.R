library("lda")
library("RTextTools")
library("RSiteCatalyst")

require(tm)

# Search high frequency keywords

Dat <- read.csv(file.choose(), header=T, sep=",")
head(Dat$tweet_text)
Dat$tweet_text <- sapply(Dat$tweet_text,function(row) iconv(row,to = 'UTF-8'))
a <- Corpus(VectorSource(Dat$tweet_text))
head(a)
# preprocessing 
a <- tm_map(a, tolower)
a <- tm_map(a, removePunctuation)
a <- tm_map(a, removeNumbers)

# this list needs to be edited and this function repeated a few times to remove high frequency context specific words with no semantic value 
a <- tm_map(a, removeWords, stopwords("english"))

# rows represent terms and columns represent documents they're contained in
mat <- TermDocumentMatrix(a,control = list(weighting = function(x) weightTfIdf(x, normalize = FALSE)))

# Interpreting term document matrix
inspect(mat[1:50,1:50])

#automatic discovery of topics in the text through “topic
#modeling” with latent Dirichlet allocation (LDA), a popular topic modeling
#algorithm.

dim(mat)

mat <- removeSparseTerms(mat, 0.99)

mat <- mat[rowSums(as.matrix(mat)) > 0, ]
dim(mat)

# applyling lda algorithm
k = 10;#number of topics
SEED = 8822; # number of tweets used
CSC_TM <-list(VEM = LDA(mat, k = k, control = list(seed = SEED)),VEM_fixed = LDA(mat, k = k,control = list(estimate.alpha = FALSE, seed = SEED)),Gibbs = LDA(mat, k = k, method = "Gibbs",control = list(seed = SEED, burnin = 1000,thin = 100, iter = 1000)),CTM = CTM(mat, k = k,control = list(seed = SEED,var = list(tol = 10^-4), em = list(tol = 10^-3))))

sapply(CSC_TM[1:2], slot, "alpha")
sapply(CSC_TM, function(x) mean(apply(posterior(x)$topics, 1, function(z) - sum(z * log(z)))))
Topic <- topics(CSC_TM[["VEM"]], 1)
Terms <- terms(CSC_TM[["VEM"]], 8)
Terms
Topic

# generate a LDA model the optimum number of topics
lda <- LDA(mat, 10)
lda
# get keywords for each topic, just for a quick look
get_terms(lda, 10)
# gets topic numbers per document
get_topics(lda, 5) 

lda_topics<-get_topics(lda, 5)
lda_topics
# create object containing parameters of the word distribution for each topic
beta <- lda@beta
beta
# create object containing posterior topic distribution for each document
gamma <- lda@gamma
gamma
# create object containing terms (words) that can be used to line up with beta and gamma
terms <- lda@terms 
terms

# puts the terms (or words) as the column names for the topic weights.
colnames(beta) <- terms 

id <- t(apply(beta, 1, order)) # order the beta values
beta_ranked <- lapply(1:nrow(id),function(i)beta[i,id[i,]])  # gives table of words per topic with words ranked in order of beta values. Useful for determining the most important words per topic
beta_ranked
