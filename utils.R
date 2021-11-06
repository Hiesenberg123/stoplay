library(shinythemes)
library(wordcloud2)
library(knitr)
library(DT)
library(shinydashboard)
library(shinyWidgets)

library(rtweet) 
library(RSQLite)
library(ggplot2)
library(dplyr)
# text mining library
library(tidytext)
library(lattice)   # word-cloud generator 
library(RColorBrewer) # color palettes
library(stopwords) 

library(rtweet)
library(tm)
library(wordcloud)
library(RColorBrewer)
library(utf8)
library(latexpdf)
library(stringr)
library(twitteR)
library(DT)
library(rvest)
library(xml2)
library(chron)

library(keras)
library(dplyr)
library(ggplot2)
library(purrr)
library(quanteda)

library(dplyr)

library(tidytext)

library(tidytext)

get_sentiments("bing")

library(janeaustenr)
library(dplyr)
library(stringr)
library(tidyr)
library(ggplot2)

library(dplyr)
library(tidyr)
library(tidytext)
library(ggplot2)
library(igraph)
library(ggraph)

library(widyr)
library(stringr)
library(magrittr)
library(shiny.semantic)
library(tidyr)

Games <- read_csv("Data/Games.csv")
Users <- read_csv("Data/Users.csv")
EQUITY_L <- read_csv("Data/EQUITY_L.csv")

myGrid <- grid_template(
  default = list(
    # Here we define the data.frame describing our layout
    # The easiest way is to use rbind so that the layout can be 'visualized' in code
    areas = rbind(
      c("header", "header", "header", "header", "header", "header"),
      c("Type1", "Type1", "Type1", "Type1", "Type1", "Type1"),
      c("Game11",   "Game11",   "Game12", "Game12", "click1", "click1"),
      c("Type2", "Type2", "Type2", "Type2", "Type2", "Type2"),
      c("Game21",   "Game21",   "Game22", "Game22", "click2", "click2"),
      c("Type3", "Type3", "Type3", "Type3", "Type3", "Type3"),
      c("Game31",   "Game31",   "Game32", "Game32", "click3", "click3"),
      c("input11", "input12", "input13", "input14", "click4", "click4")
    ),
    # Then we define the dimensions of the different elements of the layout
    # We can use any valid css units to make the layout behave exactly as desired
    rows_height = c("100px", "50px", "2fr", "50px", "2fr", "50px", "2fr", "50px"),
    cols_width = c("16.66%", "16.66%", "16.66%", "16.66%", "16.66%", "16.70%")
  ),
  # This is optional, but we can define a specific layout for mobile (screen width below 768px)
  mobile = list(
    areas = rbind(
      c("header", "header", "header", "header", "header", "header"),
      c("Type1", "Type1", "Type1", "Type1", "Type1", "Type1"),
      c("Game11",   "Game12",   "Game13", "Game14", "Game15", "click1"),
      c("Type2", "Type2", "Type2", "Type2", "Type2", "Type2"),
      c("Game21",   "Game22",   "Game23", "Game24", "Game25", "click2"),
      c("Type3", "Type3", "Type3", "Type3", "Type3", "Type3"),
      c("Game31",   "Game32",   "Game33", "Game34", "Game35", "click3"),
      c("input11", "input12", "input13", "input14", "click4", "click4")
    ),
    rows_height = c("100px", "100px", "2fr", "100px", "2fr", "100px", "2fr", "100px"),
    cols_width = c("16.66%", "16.66%", "16.66%", "16.66%", "16.66%", "16.70%")
  )
)


uicard <- function(id, label = "Counter") {
  div(class= "ui card",
      div(class= "content",
          div(class= "header", paste(id, " Games", sep = ""))),
      div(class= "content",
          h4(class= "ui sub header", "Ongoing games"),
          div(class= "ui small feed",
              div(class= "event",
                  div(class= "content",
                      div(class= "summary", paste("Total ", dim(Games[Games$Type== id,])[1], " Active Games", sep = "")))))),
      div(actionButton("ui bottom attached green button", a(href= route_link(id),"Play!")))
  )
}

uiGame<- function(id, label = "Counter") {
  div(class= "ui card",
      div(class= "content",
          div(class= "header", paste(Game_list[[id]]$name, " Game", sep = ""))),
      div(class= "content",
          h4(class= "ui sub header", ),
          div(class= "ui small feed",
              div(class= "event",
                  div(class= "content",
                      div(class= "summary", paste("Maximum Participant: ", Game_list[[id]]$Max, sep = "")))),
              div(class= "event",
                  div(class= "content",
                      div(class= "summary", paste("Participation Cost: ", Game_list[[id]]$Fees, sep = "")))),
              div(class= "event",
                  div(class= "content",
                      div(class= "summary", paste("Vacancy: ", Game_list[[id]]$Vacancy, sep = "")))),
              div(class= "event",
                  div(class= "content",
                      div(class= "summary", paste("Opening Date: ", Game_list[[id]]$Start, sep = "")))),
              div(class= "event",
                  div(class= "content",
                      div(class= "summary", paste("Closure Date: ", Game_list[[id]]$End, sep = "")))),
          )),
      div(class= "extra content",
          div(class= "ui bottom attached red button", a(href= route_link(id), style = "color: black", "Join")))
  )
}

uiNumb<- function(id, label = "Counter") {
  div(class= "ui card",
      div(class= "content",
          div(class= "header", paste(id, " Games", sep = ""))),
      div(class= "content",
          h4(class= "ui sub header", ),
          div(class= "ui small feed",
              div(class= "event",
                  div(class= "content",
                      div(class= "summary", paste("Total ", dim(Games[Games$Type== id,])[1], " Active Games", sep = "")))))),
      div(actionButton("ui bottom attached green button", a(href= route_link(id),"Play!")))
  )
}





User <- R6Class(
  classname = "User", 
  public = list(
    name= NULL,
    age = NA,
    password = NA,
    balance = 0,
    Winning = 0,
    Game = NULL,
    initialize = function(name, age = NA, password) {
      self$name <- name
      self$age <- age
      self$password <- password
    },
    deposit = function(dep = 0) {
      self$balance <- self$balance + dep
      invisible(self)
    },
    
    withdraw = function(draw = 0) {
      if (self$balance - draw < 0) {
        stop("Your `withdraw` must be smaller ",
             "than your `balance`.",
             call. = FALSE
        )
      } else {
        self$balance <- self$balance - draw
        invisible(self)
      }
    },
    
    NewGame = function(name) {
      self$Game<- append(self$Game, name)
    }
  )
)


Game<- R6Class(
  classname = "Game",
  public = list(
    name=  NULL,
    Max = 0,
    Vacancy = NA,
    Type= NULL,
    challengers= NULL,
    Fees= NA,
    Duration= NULL,
    Start= NULL,
    Status= NULL,
    Day = NA,
    End= NULL,
    Portfolio= NULL,
    
  initialize = function(name, Max, Fees, Start, Day) {
      self$name <- name
      self$Max <- Max
      self$End <- Start +Day
      self$Fees <- Fees
      self$Duration <- Day
      self$Start <- Start
      self$Vacancy<- Max
      },
 
  
    status = function(){
      if (self$Start> Sys.Date()) {
        return("Not Started")
      } else if (self$End < Sys.Date()) {
        return("Completed")
      } else { return("Active")}
    },
  
  NewChallenger = function(id) {
    if (self$Vacancy== 0) {
      stop("Game is full.",
           call. = FALSE
      )
    } else {
      self$challengers <- append(self$challengers, id)
      self$Vacancy<- self$Vacancy-1
    }
  },
  
  NewPortfolio = function(id) {
    
      self$Portfolio <- append(self$Portfolio, id)
      #names(self$Portfolio)<- append(names(self$Portfolio), id$name)
  },
  
  ModifyPortfolio = function(id){
    self$Portfolio[[which(names(self$Portfolio) %in% id$name)]] <- id
  }
  )
)



Nifty221<- Game$new("Nifty221", 100, 100, Sys.Date(), 5)
Nifty222<- Game$new("Nifty222", 10, 1000, Sys.Date()-8, 5)
Nifty223<- Game$new("Nifty223", 1000, 50, Sys.Date()+4, 5)
Nifty224<- Game$new("Nifty224", 4, 500, Sys.Date()+4, 5)
Nifty225<- Game$new("Nifty225", 2, 5000, Sys.Date()+4, 10)
Nifty226<- Game$new("Nifty226", 1000, 40, Sys.Date()+4, 15)
Nifty227<- Game$new("Nifty227", 75, 500, Sys.Date()+4, 25)
Nifty228<- Game$new("Nifty228", 6, 500, Sys.Date()+3, 1)
Nifty229<- Game$new("Nifty229", 15, 100, Sys.Date()+4, 1)
Nifty230<- Game$new("Nifty230", 750, 50, Sys.Date()+14, 1)

Game_list<- c(Nifty221, Nifty222, Nifty223, Nifty224, Nifty225, Nifty226, Nifty227, Nifty228, Nifty229, Nifty230)

Oneday<- c(1:length(Game_list))
Week<- c(1:length(Game_list))
Month<- c(1:length(Game_list))

for (i in 1:length(Game_list)) {
  Oneday[i]<- (Game_list[[i]]$Vacancy!=0 && Game_list[[i]]$Duration==1)
  Week[i]<- (Game_list[[i]]$Vacancy!=0 && Game_list[[i]]$Duration>1 && Game_list[[i]]$Duration<8)
  Month[i]<- (Game_list[[i]]$Vacancy!=0 && Game_list[[i]]$Duration>7)
}

One<- which(Oneday==1)
week<- which(Week==1)
month<- which(Month==1)


Portfolio <- R6Class(
  classname = "Portfolio",
  public = list(
    name=  NULL,
    User = NULL,
    Game = NULL,
    Size= NA,
    Deposit= NA,
    port= NULL,
    table= NULL,
  
  initialize = function(name, User, Game, Size, Deposit) {
    self$name <- name
    self$User <- User
    self$Game <- Game
    self$Size <- Size
    self$Deposit <- Deposit
    self$table<- c("Deposit", 0, 0, 0, Deposit) %>%t() %>% as.data.frame()
    colnames(self$table)<- c("Stock", "Quantity", "Unit Price", "Purchasing Price", "Current Value")
    
  },
  
  buy = function(stock, quantity){
    if (as.numeric(self$Deposit)<1.005*nse_stock_quote(stock)*quantity) {
      stop("Allocated Budget exhausted",
           call. = FALSE
      )
    } else {
      self$Deposit<- as.numeric(self$Deposit)- 1.005*nse_stock_quote(stock)*quantity
      self$table[1,5]<- as.numeric(self$Deposit)
      self$table<- rbind(self$table, c(stock, quantity, nse_stock_quote(stock), nse_stock_quote(stock), quantity*nse_stock_quote(stock)))
    }
  },
  
  sell = function(stock, quantity){
    if (as.numeric(self$table[self$table[,1]==stock, 2])< quantity) {
      stop("More than stock in account",
           call. = FALSE
      )
    } else {
      self$Deposit<- self$Deposit+ 0.995*nse_stock_quote(stock)*quantity
      self$table[self$table[,1]==stock, 2] <- as.numeric(self$table[self$table[,1]==stock, 2])- quantity
    }
  },
  
  size = function(){
    return(sum(as.numeric(self$table$`Current Value`)))
  },
  
  performance = function(){
    return((sum(as.numeric(self$table$`Current Value`))- self$Size)/ self$Size)
  }
  )
)


uiPort<- function(id, Game, label = "Counter") {
  div(class= "ui card",
      div(class= "content",
          div(class= "header", paste(Game$Portfolio[[id]]$name, " Game", sep = ""))),
      div(class= "content",
          h4(class= "ui sub header", ),
          div(class= "ui small feed",
              div(class= "event",
                  div(class= "content",
                      div(class= "summary", paste("User: ", Game$Portfolio[[id]]$User, sep = "")))),
              div(class= "event",
                  div(class= "content",
                      div(class= "summary", paste("Unused Capital: ", Game$Portfolio[[id]]$Deposit, sep = "")))),
              # div(class= "event",
              #     div(class= "content",
              #         div(class= "summary", paste("Portfolio Size: ", Game$Portfolio[[id]]$size(), sep = "")))),
              # div(class= "event",
              #     div(class= "content",
              #         div(class= "summary", paste("Performance: ", Game$Portfolio[[id]]$performance(), sep = ""))))
          )),
      div(class= "extra content",
          div(class= "ui bottom attached green button", a(href= route_link(id), style = "color: black", "See Portfolio")))
  )
}

Mantu11<- Portfolio$new("Mantu11", "kunala", Nifty221, 1000000, 1000000)
Mantu11$buy("ADANITRANS", 10)
Mantu11$buy("M&M", 15)

Mantu12<- Portfolio$new("Mantu12", "kunala", Nifty221, 1000000, 1000000)
Mantu12$buy("ADANITRANS", 15)
Mantu12$buy("M&M", 20)

Nifty221$NewPortfolio(Mantu11)
Nifty221$NewPortfolio(Mantu12)




