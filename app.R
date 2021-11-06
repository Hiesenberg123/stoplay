# Concepts about Reactive programming used by Shiny, 
# https://shiny.rstudio.com/articles/reactivity-overview.html

# Load R packages
library(glue)
library(DT)
library(ggpubr)
library(tibble)
library(shiny)
library(shiny.router)
library(shiny.semantic)
library(shinyjs)
library(leaflet)
library(dplyr)
library(R6)
library(tidyverse)
library(twitterwidget)
library(shinymanager)
library(shinyWidgets)
library(nse2r)
library(shinycssloaders)

source("utils.R")
source("nifty.R")
source("crypto.R")
source("nyse.R")
source("comm.R")
source("curr.R")
source("Gamepage.R")


credentials <- data.frame(
  user = Users$Username , # mandatory
  password = Users$Password  , # mandatory
  
  comment = "Simple and secure authentification mechanism 
  for single ‘Shiny’ applications.",
  stringsAsFactors = FALSE
)

info_page <- div(
  div(class = "ui two column stackable grid container",
      div(class = "ten wide column",
          div(class="ui center aligned big header", style = "color: white", h2("FundU")),
          p("This app was created for the purpose of giving a real life experience to a non trader about fund management.
             FundU has gamified the normal fund management process. Users can familiarise themselves with real life fund management without risking their real money.",
            ),
          p("Explore the various games and features of this game to improve your fund managment skills and ",
            "compete with your friends"),
          div(class="ui center aligned", style = "text-align: center;",
              action_button("go_modal", "Learn more", class = "teal"),
              br(),br()),
          div(class = "ui two column stackable grid container", 
              div(class = "eight wide column",
                  uicard("Nifty")), 
              div(class = "eight wide column",
                  uicard("NYSE")), br()),
          div(class = "ui two column stackable grid container", 
              div(class = "eight wide column",
                  uicard("Crypto")), 
              div(class = "eight wide column",
                  uicard("Commodity")), br()),
          div(class = "ui two column stackable grid container", 
              div(class = "eight wide column",
                  uicard("Currency")), 
              div(class = "eight wide column",
                  uicard("Hybrid")), br())
          
      ),
      div(class = "six wide column",
          img(height = 520, width = 325, src="https://i.pinimg.com/564x/2f/26/3c/2f263c9d0441260f9fcbf2f4fdafa8cd.jpg"), br())
      #twitterwidgetOutput("tweet", width = "100%", height = "400px")
      
  ))

router <- make_router(
  route("index", info_page),
  route("Nifty", uinifty("p1")),
  route("Crypto", uicrypto("p2")),
  route("NYSE", uinyse("p3")),
  route("Commodity", uicomm("p4")),
  route("Currency", uicurr("p5")),
  # for (i in 1:length(Game_list)) {
  #   route(as.character(i), uiGamepage(as.character(i)))
  #   
  # }
  route("1", uiGamepage("1")),
  route("2", uiGamepage("2")),
  route("3", uiGamepage("3")),
  route("4", uiGamepage("4")),
  route("5", uiGamepage("5")),
  route("6", uiGamepage("6")),
  route("7", uiGamepage("7")),
  route("8", uiGamepage("8")),
  route("9", uiGamepage("9")),
  route("10", uiGamepage("10"))
  # route("Currency", uicurr("p5"))
)

# router <- make_router(
#   route("index", info_page),
#   route("1", uiGamepage("1"))
# )


server <- function(input, output, session) {
  # router pages
  router$server(input, output, session)#router(input, output) #
  niftyServer("p1")
  cryptoServer("p2")
  nyseServer("p3")
  commServer("p4")
  currServer("p5")
  for (i in 1:length(Game_list)) {
    GamepageServer(as.character(i))
  }
  # GamepageServer("1")
  # GamepageServer("2")
  # GamepageServer("3")
  # GamepageServer("4")
  # GamepageServer("5")
  # GamepageServer("6")
  # GamepageServer("7")
  # GamepageServer("8")
  # GamepageServer("9")
  # GamepageServer("10")
  
  # call the server part
  # check_credentials returns a function to authenticate users
  res_auth <- secure_server(
    check_credentials = check_credentials(credentials)
  )
  output$welcomeModal <- renderUI({
    create_modal(modal(
      id = "simple-modal",
      title = "Information",
      header = h2(class = "ui header", icon("dollar"), div(class = "content", "FundU- Fantasy Fund Management")),
      content = shiny.semantic::grid(
        grid_template = grid_template(
          default = list(
            areas = rbind(c("photo", "text")),
            cols_width = c("50%", "50%")
          ),
          mobile = list(
            areas = rbind(c("photo"), c("text")),
            cols_width = c("100%"),
            rows_height = c("50%", "50%")
          )
        ),
        container_style = "grid-gap: 20px",
        area_styles = list(text = "padding-right: 20px"),
        photo = tags$img(src = "https://images.unsplash.com/photo-1582517378602-f109b395ce40?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2851&q=80", style = "width: 75%", alt = ""),
        text = HTML(
          sprintf(
            paste("Welcome ", res_auth$user, ". Have a great time playing FundU")
          )
        )
      )
    ))
  })
  
  }


ui <- semanticPage(
  #uiOutput("welcomeModal"),
  title = "Fund Management Fantasy Game",
  tags$head(
    tags$link(rel="stylesheet", href="main.css", type="text/css")
  ),
  horizontal_menu(
    list(
      list(name = "Home", link = route_link("index"), icon = "world")
      ), #logo = "https://www.pulsex.co.in/images/logo.png"
  ),
  router$ui,#router_ui(),
  tags$footer("Created by PulseX for Traders", align = "center", style = "position:fixed; bottom:0; right:0; left:0; background:black; color: white; padding:10px; box-sizing:border-box; z-index: 1000; text-align: center")
)

# Wrap your UI with secure_app
#ui <- secure_app(ui)


shinyApp(ui, server)
