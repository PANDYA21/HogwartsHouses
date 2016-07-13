## ---------------------------------------------------------------------------------------------------------- ##
## The SERVER script for the app
## Bhaumik Pandya
## BLUETRADE E-Commerce Software & Marketing GmbH 
## ---------------------------------------------------------------------------------------------------------- ##


# shiny server
server <<- function(input, output,session) {
  
  
  # Other users' app ----------------------------------------------------
  #### the normal user app server
  output$body1 <- renderUI({ui2})
  
  # chat server chunk
  # delete the temp files on each session end
  session$onSessionEnded(function() {
    if(file.exists(session$token)){
      file.remove(session$token)
    }
    if(file.exists(paste0(session$token, "_usr_inputs.csv"))){
      file.remove(paste0(session$token, "_usr_inputs.csv"))
    }
  })
  
  # observe the send button to chat
  output$chatO <- renderUI({
    btn.val <- input$send
    if(btn.val < 1){
      # initialize
      first.msg <- HTML("Tell me your characteristics and I will put you in your deserving House...",
                        as.character(br()), 
                        "Type @Ex for example.")
      chatt <- HTML(c(as.character(br()),
                      as.character(p(first.msg, 
                                     align = "right", class = "me"))))
      # write a temp file for chat history
      writeLines(chatt, session$token) 
      # write another temp csv file for user inputs
      usr.fil <- paste0(session$token, "_usr_inputs.csv")
      usr.data <- data.frame(x1 = "", x2 = "", stringsAsFactors = F)
      write.table(usr.data, usr.fil, sep = ",", dec = ".", col.names = T, row.names = F)
      return(chatt)
      # end of initialization
      
    } else {
      # chat has begun
      in.txt1 <- isolate(input$txt1)
      if(in.txt1 == ""){
        # no input, but pressed Enter or clicked 'Send' button
        chatt <- readLines(session$token)
        return(HTML(chatt))
        
      # } else if (tolower(in.txt1) %in% c("@example", "@ex", "@eg", "@Zb", "@e.g.")) {
      } else if (grepl("@ex|@eg|@zb|@e", tolower(in.txt1))) {
        
        chatt <- readLines(session$token)
        reply.txt <- paste0(c("I am a brave",
                              "I am bold", 
                              "Hurting people is my hobby.", 
                              "I normally behave wise.", 
                              "I am week."), collapse = as.character(br()))
        chatt <- c(chatt,
                   as.character(p(in.txt1, align = "left", class = "them")),
                   as.character(p(HTML(reply.txt), 
                                  align = "right", class = "me")))
        writeLines(chatt, session$token)
        # auto remove text from the inout filed when message is sent
        updateTextInput(session, "txt1", value = "")
        return(HTML(chatt))
        
      } else {
        chatt <- readLines(session$token)
        # do not process if same text
        last.msg <- tail(chatt[grep("class=\"them\"", chatt)], 1)
        last.msg <- gsub("<p align=\"left\" class=\"them\">", "", last.msg)
        last.msg <- gsub("</p>", "", last.msg)
        if(identical(in.txt1, last.msg)){
          # do nothing
          return(HTML(chatt))
          
        } 
        
        # separate the sentences
        in.sentences <- separateSentences(in.txt1)
        
        # send query to NLC since input changed (one by one)
        reply.txt <-  character(0)
        for(i.sentence in in.sentences){
          # ress <- watson.nlc.processtextreturnclass(classifier, i.sentence)
          ress <- watsonNlcIdentifyClass(classifier, i.sentence)
          if(as.numeric(as.character(ress$confidence[1])) < 0.7){
            reply.txt <- c(reply.txt, sample(c("I could not understand. Type '@ex' for example.", 
                                               "Could not understand that... Type '@ex' for example.", 
                                               "Did not get that... Type '@ex' for example.",
                                               "I did not understand that... Type '@ex' for example.",
                                               "I am afraid I did not understand... Type '@ex' for example.",
                                               "I am sorry that i could not understand... Type '@ex' for example."), 1))
          } else {
            # write user profile for current chat
            usr.fil <- paste0(session$token, "_usr_inputs.csv")
            
            usr.data <- data.frame(x1 = i.sentence, x2 = ress$class[1])
            write.table(usr.data, usr.fil, append = T,
                        sep = ",", dec = ".",
                        row.names = F, col.names = F)
            
            reply.txt <- c(reply.txt, ress$class[1])
          }
        }
        
        chatt <- c(chatt,
                   as.character(p(in.txt1, align = "left", class = "them")),
                   as.character(p(HTML(paste0(reply.txt, collapse = "<br/>")), 
                                  align = "right", class = "me")))
        writeLines(chatt, session$token)
        
        # auto remove text from the inout filed when message is sent
        updateTextInput(session, "txt1", value = "")
        return(HTML(chatt))
      }
    }
  })
  
  
 
#   # the report
#   output$report <- downloadHandler(
#     # filename = paste0("HEAD_racket_recommendation_", Username, ".pdf"),
#     filename = paste0("HEAD_racket_recommendation_", input$userName, ".htm"),
#     
#     content = function(file) {
#       # Sweave2knitr('input.Rnw')
#       # # out = knit2pdf('input-knitr.Rnw', clean = TRUE)
#       pandoc.dir <- Sys.getenv("RSTUDIO_PANDOC")
#       Sys.setenv(RSTUDIO_PANDOC = pandoc.dir)
#       out = rmarkdown::render(input = 'input.Rmd', output_format = "html_document")
#       file.rename(out, file) # move pdf to file for downloading
#     }# ,
#     
#     # contentType = 'application/pdf'
#   )
  #### the app finished
  #----------------------------------------------------------------------
  
}


## ---------------------------------------------------------------------------------------------------------- ##
## End of Code
## ---------------------------------------------------------------------------------------------------------- ##