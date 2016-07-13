## ---------------------------------------------------------------------------------------------------------- ##
## User Defined  Functions - script 3
## required during conversation with IBM Watson NLC
## Bhaumik Pandya
## BLUETRADE E-Commerce Software & Marketing GmbH 
## ---------------------------------------------------------------------------------------------------------- ##

load_or_install("RCurl", repos='http://cran.rstudio.com/') 
load_or_install("jsonlite", repos='http://cran.rstudio.com/')
options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl"),httpauth=AUTH_BASIC)) 

## Authentication with Watson
creds.potter <- fromJSON("NLC_train/NLC_auth.json")
base_url = "https://gateway.watsonplatform.net/natural-language-classifier/api/v1/classifiers/"
username = creds.potter$credentials$username 
password = creds.potter$credentials$password 
username_password = paste(username,":",password)
##

## JSON based watson class extraction (optimized)
watsonNlcIdentifyClass <- function(classifier_id, query_text, user_pass = username_password){
  library(jsonlite)
  query_text <- URLencode(query_text)
  anss <- fromJSON(getURL(paste(base_url,classifier_id,"/classify","?text=", query_text,sep=""),userpwd = username_password))
  # if(anss$classes$confidence[1] >= 0.7){
  #   return(anss$top_class)
  # } else {
  #   return(NA)
  # }
  return(anss$classes)
}
##


## separate more than one input sentences by "." = full stop.
separateSentences <- function(user.txt){
  in.sentences <- unlist(strsplit(user.txt, "\\."))
  in.sentences <- in.sentences[!(in.sentences %in% " ")]
  in.sentences <- in.sentences[!(in.sentences %in% "")]
  return(in.sentences)
}
##



## ---------------------------------------------------------------------------------------------------------- ##
## End of Code
## ---------------------------------------------------------------------------------------------------------- ##