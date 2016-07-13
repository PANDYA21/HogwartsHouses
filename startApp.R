## ---------------------------------------------------------------------------------------------------------- ##
## server side starter script to start an httpd server and then run shiny server on the provided port by Bluemix
## Bhaumik Pandya
## BLUETRADE E-Commerce Software & Marketing GmbH 
## ---------------------------------------------------------------------------------------------------------- ##

# working directory
oldwd <- getwd()
on.exit(setwd(oldwd))

# source the udf files
source("App/UDF/load_libs.R")
source("App/UDF/udfs_app.R")
source("App/UDF/udfs_watson.R")

# source the server and ui scripts
source("App/UI/UI.R")
source("App/Server/server.R")

# the IBM NLC
classifier <<- "e295e0x75-nlc-92"

# run the app
app <- shinyApp(ui = ui, server = server)

if (Sys.getenv('VCAP_APP_PORT') == "") {
  # In case we're on a local system, run this:
  print('running locally')
  runApp(app, port=1234, launch.browser=F)
  
} else {
  # In case we're on Cloudfoundry, run this:
  print('running on CF')
  
  # Starting Rook server during CF startup phase - after 60 seconds start the actual Shiny server
  library(Rook)
  myPort <- as.numeric(Sys.getenv('VCAP_APP_PORT'))
  myInterface <- Sys.getenv('VCAP_APP_HOST')
  status <- -1
  
#   # R 2.15.1 uses .Internal, but the next release of R will use a .Call.
#   # Either way it starts the web server.
#   if (as.integer(R.version[["svn rev"]]) > 59600) {
#     status <- .Call(tools:::startHTTPD, myInterface, myPort)
#   } else {
#     status <- .Internal(startHTTPD(myInterface, myPort))
#   }
#   
#   if (status == 0) {
#     unlockBinding("httpdPort", environment(tools:::startDynamicHelp))
#     assign("httpdPort", myPort, environment(tools:::startDynamicHelp))
#     
#     s <- Rhttpd$new()
#     s$listenAddr <- myInterface
#     s$listenPort <- myPort
#     
#     s$print()
#     Sys.sleep(5) # Sys.sleep(60)
#     s$stop()
# 
# 
# # check for newer version
#     # getSettable <- function(default){
#     #   function(obj = NA){if(!is.na(obj)){default <<- obj};
#     #     default}
#     # }
#     # myHttpdPort <- getSettable(myPort)
#     # unlockBinding("httpdPort", environment(tools:::startDynamicHelp))
#     # assign("httpdPort", myHttpdPort, environment(tools:::startDynamicHelp))
#     
#     # s <- Rhttpd$new()
#     # s$listenAddr <- myInterface
#     # s$listenPort <- myPort
#     
#     # s$print()
#     # Sys.sleep(60)
#     # s$stop()
#   }
  
  
  # run shiny server
  sink(stderr())
  # library(Cairo)
  options(bitmapType='cairo-png')
  getOption("bitmapType")
  print("test")
  write("prints to stderr", stderr())
  write("prints to stdout", stdout())
  # runApp(app, port=myPort, host="0.0.0.0", launch.browser=F)
  runApp(app, port=myPort, host=myInterface, launch.browser=F)
}

## ---------------------------------------------------------------------------------------------------------- ##
## End of Code
## ---------------------------------------------------------------------------------------------------------- ##