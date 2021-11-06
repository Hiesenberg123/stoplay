#source("utils.R")
source("dash.R")
source("Gamepage.R")

uinifty <- function(id, label = "Counter") {
  ns <- NS(id)
  semanticPage(
    useShinyjs(),
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "main.css")
    ),
    
    
    div(class = "ui form", style = "text-align: center; color: black",
        h1(class= "ui top attached header", div(icon("rupee"), "NIFTY Games"),
        div(class = "ui bottom attached segment",
        #title = h2(class = "ui center aligned big header", div(icon("rupee"), "NIFTY Games")), 
        includeCSS("main.css"),
        div(class="ui center aligned big header", style = "color: white",  h1(class= "stripe-1", icon("rupee"), "NIFTY Games")),
        p("NIFTY stocks have been gamified for the purpose of understanding the mechanism of NIFTY behaviour for users.",)))),
        br(),
    
    div(class = "ui form", style = "text-align: center; color: black",
        div(class = "ui bottom attached segment",
          h2(class= "ui top attached header", "NIFTY Stocks"),
          p('Get stock symbol and name, top gainers & losers, 52 week high & low and most traded stocks.'),
        br(),
        uidash(ns("R1")))),
        br(),
    
        div(class = "ui two column stackable grid container",
        div(class = "ten wide column",
        div(class = "ui form", style = "text-align: center; color: black",
            h2(class= "ui top attached header", "NIFTY Games on Chart"),
            div(class = "ui bottom attached segment",
            
                  #div(class="ui center aligned", style = "text-align: center;",
                      #action_button("go_modal", "Learn more", class = "teal"),
                      #br(),br()),
                  div(class = "stripe", h4("One Day Competition")),
                      br(),
                  div(class = "ui three column stackable grid container", style = "text-align: center;", 
                      div(class = "six wide column",
                          uiGame(One[1])), 
                      div(class = "six wide column",
                          uiGame(One[2])), br(),
                      div(class = "two wide column",
                          actionButton(ns("create3"), "List"))), br(),
                  div(class = "stripe", h4("Week Long Competition")),
                  br(),
                  div(class = "ui three column stackable grid container", style = "text-align: center;", 
                      div(class = "six wide column",
                          uiGame(week[1])), 
                      div(class = "six wide column",
                          uiGame(week[2])), br(),
                      div(class = "two wide column",
                          actionButton(ns("create3"), "List"))), br(),
                  div(class = "stripe", h4("Longer version Competition")),
                  br(),
                  div(class = "ui three column stackable grid container", style = "text-align: center;", 
                      div(class = "six wide column",
                          uiGame(month[1])), 
                      div(class = "six wide column",
                          uiGame(month[2])), br(),
                      div(class = "two wide column",
                          actionButton(ns("create3"), "List")), br()
                  
              )))),
          
        div(class = "six wide column",
          div(class = "ui form", style = "color: black",
              h2(class= "ui top attached header", "Other Market Games"),
              div(class = "ui bottom attached segment",
                 
                      div(class = "six wide column",
                          uicard("Crypto")), br(),
                      div(class = "six wide column",
                          uicard("Commodity")), br(),
                      div(class = "six wide column",
                          uicard("Currency")), br(),
                      div(class = "six wide column",
                          uicard("Hybrid")), br())
              #twitterwidgetOutput("tweet", width = "100%", height = "400px")
              
          ))))
    
  
    # shiny.semantic::grid(myGrid,
    #                      # We can define the css style of the grid using container_style
    #                      container_style = "",
    #                      # We can define the css style of each of the grid elements using area_styles
    #                      area_styles = list(header = "",
    #                                         input11 ="color: black",
    #                                         input12 ="color: black",
    #                                         input13 ="color: black",
    #                                         input14 ="color: black",
    #                                         
    #                                         click4 ="margin-top: 40px; margin-left: 40px;",
    #                                         click3 ="margin-top: 40px; margin-left: 40px;",
    #                                         click2 ="margin-top: 40px; margin-left: 40px;",
    #                                         click1 ="margin-top: 40px; margin-left: 40px;",
    #                                         
    #                                         Type1 = "margin-top: 10px",
    #                                         Type2 = "margin-top: 10px",
    #                                         Type3 = "margin-top: 10px",
    #                                         
    #                                         Game11 = "margin-bottom: 5px; margin-left: 5px; border: 1px solid #0099f9; background-color: white",
    #                                         Game12 = "margin-bottom: 5px; margin-left: 5px; border: 1px solid #0099f9; background-color: white",
    #                                         
    #                                         Game21 = "margin-bottom: 5px; margin-left: 5px; border: 1px solid #0099f9; background-color: white",
    #                                         Game22 = "margin-bottom: 5px; margin-left: 5px; border: 1px solid #0099f9; background-color: white",
    #                                         
    #                                         Game31 = "margin-bottom: 5px; margin-left: 5px; border: 1px solid #0099f9; background-color: white",
    #                                         Game32 = "margin-bottom: 5px; margin-left: 5px; border: 1px solid #0099f9; background-color: white"
    #                                         
    #                                         
    #                      ),
    #                      
    #                      # Finally, we define the ui content we would like to have inside each element
    #                      header = h1(class="ui header", align= "center", icon("rupee"), theme = "cosmo", div(class="content", "NIFTY Portfolios")),
    #                      
    #                      Type1 = h3(class="ui header", align= "center", icon("twitter square"), theme = "cosmo", div( class="content", "One Day Games")),
    #                      Type2 = h3(class="ui header", align= "center", icon("twitter square"), theme = "cosmo", div( class="content", "Week Games")),
    #                      Type3 = h3(class="ui header", align= "center", icon("twitter square"), theme = "cosmo", div( class="content", "Month Games")),
    #                      
    #                      Game11 = card(class = "red",
    #                                   div(class = "content",
    #                                       div(class = "description", verbatimTextOutput(ns("tweetcount")))
    #                                   )
    #                      ),
    #                      
    #                      Game12 = card(class = "red",
    #                                     div(class = "content",
    #                                         div(class = "description", verbatimTextOutput(ns("tweetcount1")))
    #                                     )
    #                      ),
    #                      
    #                      Game21 = card(class = "red",
    #                                   div(class = "content",
    #                                       div(class = "description", verbatimTextOutput(ns("tweetcount2")))
    #                                   )
    #                      ),
    #                      
    #                      Game22 = card(class = "red",
    #                                    div(class = "content",
    #                                        div(class = "description", verbatimTextOutput(ns("tweetcount3")))
    #                                    )
    #                      ),
    #                      
    #                      Game31 = card(class = "red",
    #                                    div(class = "content",
    #                                        div(class = "description", verbatimTextOutput(ns("tweetcount4")))
    #                                    )
    #                      ),
    #                      
    #                      Game32 = card(class = "red",
    #                                    div(class = "content",
    #                                        div(class = "description", verbatimTextOutput(ns("tweetcount5")))
    #                                    )
    #                      ),
    #                      
    #                      input11 = textInput(inputId = ns("name"), label = div(shiny::tags$h3("Challenge Name", style="color:black")), width = 200, placeholder = "Name"),
    #                      
    #                      input12 = selectInput(
    #                        inputId = ns("duration"),
    #                        label = div(shiny::tags$h3("Duration" , style="color:black")),
    #                        choices = c("Intraday", "Week", "Month"),
    #                        selected = "Week",
    #                        width = 200
    #                      ),
    #                      
    #                      input13= numericInput(ns("fees"), "Entry fees:", 10, min = 1, max = 200),
    #                      
    #                      input14= dateRangeInput(ns('dateRange'), label = div(shiny::tags$h3("Date" , style="color:black")), start = Sys.Date() - 2, end = Sys.Date() + 2, min = NULL,
    #                                             max = NULL, format = "yyyy-mm-dd", startview = "month", weekstart = 0,
    #                                             language = "en", separator = " to ", width = 300),
    #                      
    #                      click4= actionButton(ns("create4"), "Create"),
    #                      click3= actionButton(ns("create3"), "List"),
    #                      click2= actionButton(ns("create2"), "List"),
    #                      click1= actionButton(ns("create1"), "List")
    #)
  #)
  
  
}

niftyServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    dashServer("R1")
    
    
    
  })
}
