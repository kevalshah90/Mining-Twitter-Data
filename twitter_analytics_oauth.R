# Twitter OAuth 
install.packages("twitteR")
require(twitteR)
reqURL <- "https://api.twitter.com/oauth/request_token"
accessURL <- "https://api.twitter.com/oauth/access_token"
authURL <- "https://api.twitter.com/oauth/authorize"
consumerKey <- "KD8D0VgQrfq18Vo6xTPxa7yIG"
consumerSecret <- "GrvleZQTszK910bBC1V8pRNKIAlfJ4MXCSaxBzKat54NgnJ95u"
twitCred <- OAuthFactory$new(consumerKey=consumerKey,
                             consumerSecret=consumerSecret,
                             requestURL=reqURL,
                             accessURL=accessURL,
                             authURL=authURL)
twitCred$handshake()
0170217
registerTwitterOAuth(twitCred)

public_tweets = publicTimeline(37.6,-95.665)
