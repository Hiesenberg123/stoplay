

library(nse2r)
library(shinycssloaders)
library(shiny)
library(shinyBS)
library(shinythemes)
library(magrittr)
library(nse2r)
library(magrittr)

uidash<- function(id, label = "Counter") {
  ns <- NS(id)
  includeCSS("main.css")
  tabPanel('Stock', value = 'tab_binom',
           
    tabset(
      tabs = list(
        list(menu = div(shiny::tags$h6("Symbol & Code" , style="color:black")), class = "teal", content = semantic_DTOutput(ns('stock_code')) %>% shinycssloaders::withSpinner(), id = "first_tab"),
        list(menu = div(shiny::tags$h6("Most Traded" , style="color:black")), class = "teal", content = semantic_DTOutput(ns('stock_most_traded')) %>% shinycssloaders::withSpinner(), id = "second_tab"),
        list(menu = div(shiny::tags$h6("Top Gainers", style="color:black")), class = "teal", content = semantic_DTOutput(ns('stock_top_gainers')) %>% shinycssloaders::withSpinner(), id = "third_tab"),
        list(menu = div(shiny::tags$h6("Top Losers", style="color:black")), class = "teal", content = semantic_DTOutput(ns('stock_top_losers')) %>% shinycssloaders::withSpinner(), id = "fourth_tab"),
        list(menu = div(shiny::tags$h6("52 Week High", style="color:black")), class = "teal", content = semantic_DTOutput(ns('stock_year_high')) %>% shinycssloaders::withSpinner(), id = "five_tab"),
        list(menu = div(shiny::tags$h6("52 Week Low", style="color:black")), class = "teal", content = semantic_DTOutput(ns('stock_year_low')) %>% shinycssloaders::withSpinner(), id = "sixth_tab")
        
    )))
}




dashServer<- function(id) {
  moduleServer(id, function(input, output, session) {
    output$stock_code <- renderDataTable({
      nse2r::nse_stock_code()
    })
    
    output$stock_most_traded <- renderDataTable({
      nse2r::nse_stock_most_traded()
    })
    
    output$stock_top_gainers <- renderDataTable({
      nse2r::nse_stock_top_gainers()
    })
    
    output$stock_top_losers <- renderDataTable({
      nse2r::nse_stock_top_losers()
    })
    
    output$stock_year_high <- renderDataTable({
      nse2r::nse_stock_year_high()
    })
    
    output$stock_year_low <- renderDataTable({
      nse2r::nse_stock_year_low()
    })
    
})
}


