## ---------------------------------------------------------------------------------------------------------- ##
## The chat chunk
## Bhaumik Pandya
## BLUETRADE E-Commerce Software & Marketing GmbH 
## ---------------------------------------------------------------------------------------------------------- ##

column(12, align="center", offset = 0,

       column(1, align="center", offset = 1),
       column(6, align="center", offset = 1, 
              column(12, align="center", offset = 0, uiOutput("chatO")),
              wellPanel(style = "background-color: #ffffff; ",
                        fluidRow(
                          column(10, align="center", offset = 0,
                                 # textInput as RAW HTML in order to get better customization ;-)
                                 tags$div(HTML('<div class="form-group shiny-input-container" style="width: 100%;">
                                        <label for="txt1"></label>
                                        <input id="txt1" type="text" class="form-control" value=""/>
                                        </div>'))),
                          column(2, align="center", offset = 0,
                                 # the 'Send' button
                                 tags$div(HTML('<button id="send" type="button" class="btn btn-default action-button isend">Send</button>'))
                          )
                        )
              )
       ),
       column(2, align="center", offset = 1)
       
)


## ---------------------------------------------------------------------------------------------------------- ##
## End of Code
## ---------------------------------------------------------------------------------------------------------- ##