## ---------------------------------------------------------------------------------------------------------- ##
## The core UI script
## Bhaumik Pandya
## BLUETRADE E-Commerce Software & Marketing GmbH 
## ---------------------------------------------------------------------------------------------------------- ##

## header
# for the User-info dropdown menu
myHeader <- dashboardHeader(title = "Going to Hogwarts", titleWidth = "100%")

# for the HEAD logo and link
myHeader$children[[2]]$children <-  tags$a(href='https://en.wikipedia.org/wiki/Hogwarts',
                                           tags$img(src='https://upload.wikimedia.org/wikipedia/commons/f/f2/Hogwarts_coat_of_arms_colored_with_shading.svg',
                                                    height='25',width='100'))
# Global variable across all users and all sessions
myHeader <<- myHeader

## core UI page
ui <<- dashboardPage(myHeader,
                   dashboardSidebar(disable = T), 
                   body = dashboardBody({
                     source("App/UI/chat_chunk_ui.R")
                   },
                   tags$head(tags$style(HTML('
                                             /* logo */
                                             .skin-blue .main-header .logo {
                                             background-color: #000000;
                                             }
                                             
                                             /* logo when hovered */
                                             .skin-blue .main-header .logo:hover {
                                             background-color: #888888; 
                                             }
                                             
                                             /* navbar (rest of the header) */
                                             .skin-blue .main-header .navbar {
                                             background-color: #000001;
                                             }        
                                             
                                             .content-wrapper,
                                             .right-side {
                                             background-color: #000000;
                                             }
                                             
                                             '))),
                   includeCSS("App/CSS/imessage.css"),
                   includeScript(("App/JS/sendOnEnter.js"))
                   ))

## ---------------------------------------------------------------------------------------------------------- ##
## End of Code
## ---------------------------------------------------------------------------------------------------------- ##