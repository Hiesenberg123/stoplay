source("utils.R")

uiinfo <- function(id, label = "Counter") {
  ns <- NS(id)
  semanticPage(
    useShinyjs(),
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "main.css")
    ),
    
    
    title = h2(class = "ui header", icon("newspaper outline"), div(class = "content", "Media Insight")),
    includeCSS("main.css"),
    shiny.semantic::grid(myGrid,
                         # We can define the css style of the grid using container_style
                         container_style = "",
                         # We can define the css style of each of the grid elements using area_styles
                         area_styles = list(header = "",
                                            card1 = "margin-top: 10px",
                                            card2 = "margin-top: 10px",
                                            card3 = "margin-top: 10px",
                                            card4 = "margin-top: 10px",
                                            card5 = "margin-top: 10px",
                                            card6 = "margin-top: 10px"
                         ),
                         
                         ## Finally, we define the ui content we would like to have inside each element
                         header = h1(class="ui header", icon("newspaper"), theme = "cosmo", div(style = "margin-left: 50px", class="content", "Media Insight")),
                         
                         card1 = card(class = "red",
                                       div(class = "content",
                                           div(class = "description", verbatimTextOutput(ns("artcnt1")))
                                       )
                         ),
                         
                         card2 = card(class = "red",
                                      div(class = "content",
                                          div(class = "description", verbatimTextOutput(ns("artcnt1")))
                                      )
                         ),
                         
                         card3 = card(class = "red",
                                      div(class = "content",
                                          div(class = "description", verbatimTextOutput(ns("artcnt1")))
                                      )
                         ),
                         
                         card4 = card(class = "red",
                                      div(class = "content",
                                          div(class = "description", verbatimTextOutput(ns("artcnt1")))
                                      )
                         ),
                         
                         card5 = card(class = "red",
                                      div(class = "content",
                                          div(class = "description", verbatimTextOutput(ns("artcnt1")))
                                      )
                         ),
                         
                         card6 = card(class = "red",
                                      div(class = "content",
                                          div(class = "description", verbatimTextOutput(ns("artcnt1")))
                                      )
                         )
    )
  )
}

infoServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    output$artcnt1 <- renderText({
      str11<- paste("Total Articles: ", " ")
      str12<- paste("Hindi Articles: ", " ")
      str13<- paste("English Articles: ", " ")
      
      paste(str11, str12, str13, sep = "\n")
    })
    
  })
}
