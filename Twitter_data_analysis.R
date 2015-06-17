# Authenticate Twitter API 

install.packages("igraph")
install.packages("plyr")
install.packages("twitteR")
install.packages("ROAuth")
install.packages("ggplot2")

library(igraph)
library(plyr)
library(twitteR)
library(ROAuth)
library(ggplot2)

requestURL <- "https://api.twitter.com/oauth/request_token"
accessURL <- "https://api.twitter.com/oauth/access_token"
authURL <- "https://api.twitter.com/oauth/authorize"
consumerKey <- "QXJu8jGLpw9Y72ZC6bSGQTKDR"
consumerSecret <- "T9z9aMEOwn6Dre2SUIWueN9LjH0FKSRmjvGeStESa8ZyxUc4cA"

Cred <- OAuthFactory$new(consumerKey=consumerKey,
                         consumerSecret=consumerSecret,
                         requestURL=requestURL,
                         accessURL=accessURL,
                         authURL=authURL)
Cred$handshake(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl") )
5441225
registerTwitterOAuth(Cred)
save(Cred, file="Twitter_authentication.rdata")
