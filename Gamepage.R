source("utils.R")
source("Gamepanel.R")

uiGamepage<- function(id, label = "Counter") {
  ns <- NS(id)
  includeCSS("main.css")
  semanticPage(
    useShinyjs(),
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "main.css")
    ),
    
    title = h2(class = "ui center aligned big header", div(icon("rupee"), "NIFTY Games")), 
    includeCSS("main.css"),
    div(class="ui center aligned big header", style = "color: white",  h2(class= "stripe-1", icon("rupee"), "NIFTY Games")),
    p("NIFTY stocks have been gamified for the purpose of understanding the mechanism of NIFTY behaviour for users.",),
    br(),
    div(h3(class= "stripe", 'NIFTY Stocks'),
        div(p('Get stock symbol and name, top gainers & losers, 52 week high & low and most traded stocks.'))),
    br(),
    uipanel(Game_list[[id]]),
    br(),
    
    div(h3(class= "stripe", 'Create Portfolio'),
        div(p('Add stocks to your portfolio'))),
    br(),
    
    div(class = "ui form", style = "text-align: center; color: black",
        h4(class= "ui top attached header", "Buy and Sale Stocks"),
          div(class = "ui bottom attached segment",
                      radioButtons(ns("act"), "Choose to buy or sell stocks", choices =c("Buy", "Sale"), selected = "Buy", inline = TRUE),
        h4(class= "ui dividing header"),
        div(class= "ui inverted form",
            div(class= "six fields",
                div(class= "field",
                    "Select Stock",  uiOutput(ns("stock"))),
                div(class= "field",
                    "Stock Name", verbatimTextOutput(ns("amount"))),
                div(class= "field",
                    "Unit Price", verbatimTextOutput(ns("price"))),
                div(class= "field",
                    "Quantity", numericInput(ns("quantity"), "", 0, min = 0, max = NA, width = "50%")),
                div(class= "field",
                    "Taxes and Charges (0.5%)", verbatimTextOutput(ns("amount1"))),
                div(class= "field",
                    "Total Cost", verbatimTextOutput(ns("amount2"))),
                
                div(class= "field",
                    actionButton("goButton", "Go!", class = "btn-success"),)
                    )))),
    br(),br(),br(),
    
    div(class = "ui form", style = "text-align: center; color: black",
        h4(class= "ui top attached header", "Buy and Sale Stocks"),
        div(class = "ui bottom attached segment",
            semantic_DTOutput(ns("table"))))
    
    
  )
}

GamepageServer<- function(id) {
  moduleServer(id, function(input, output, session) {
   
    observe({ 
    if(input$act== "Buy"){    
      output$stock<- renderUI({
      ns <- session$ns
      selectInput(ns("stock"),"" , EQUITY_L$SYMBOL, selected = EQUITY_L$SYMBOL[1], width = "75%")
      })
    } else {
      output$stock<- renderUI({
        ns <- session$ns
        selectInput(ns("stock"),"" , EQUITY_L$SYMBOL[1:10], selected = EQUITY_L$SYMBOL[1], width = "75%")
      })
    }
    })
  
    output$amount<- renderText({EQUITY_L$`NAME OF COMPANY`[EQUITY_L$SYMBOL== input$stock]})
    price<- reactive({nse_stock_quote(input$stock)})
    output$price<- renderText({price()})
    output$amount1<- renderText({0.005*price()*input$quantity})
    observe({ 
      if(input$act== "Buy"){    
        output$amount2<- renderText({1.005*price()*input$quantity})
      } else {
        output$amount2<- renderText({0.995*price()*input$quantity})
      }
    })
    
    output$table <- DT::renderDataTable(
      semantic_DT(Users)
    )
    
    #panelServer(Game_list[[id]])
    
    })
}
