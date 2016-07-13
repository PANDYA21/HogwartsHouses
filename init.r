## ---------------------------------------------------------------------------------------------------------- ##
## Server side initialization script to install the required libraries on Bluemix - R
## Bhaumik Pandya
## BLUETRADE E-Commerce Software & Marketing GmbH 
## ---------------------------------------------------------------------------------------------------------- ##

sink(stderr())
print("Running init.R to install the required packages ...")

install.packages("Rcpp", type="source", dependencies=TRUE, repos='http://cran.rstudio.com/')
install.packages("Rook",clean=T, dependencies=TRUE, repos='http://cran.rstudio.com/')
install.packages("shiny", dependencies=TRUE, repos='http://cran.rstudio.com/')
install.packages("shinydashboard", dependencies=TRUE, repos='http://cran.rstudio.com/')

# other packages

## the very first function to install or load namespaces
load_or_install <- function(func = "", ...){
  if(require(package =  func, character.only = T) == FALSE){
    install.packages(func, clean = T, ...)
    require(package =  func, character.only = T)
  } else {
    require(package =  func, character.only = T)
  }
}
###

## Load libs
load_or_install("RCurl", repos='http://cran.rstudio.com/') 

print("All packages installed...")
