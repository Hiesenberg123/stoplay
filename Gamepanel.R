#source("utils.R")


# uipanel<- function(id, label = "Counter") {
#   ns <- NS(id)
#   includeCSS("main.css")
#   tabPanel('Stock', value = 'tab_binom',
#            
#            tabset(
#              tabs = list(
#                list(menu = div(shiny::tags$h6("Portfolios" , style="color:black")), class = "teal", content = uipanel(id), id = "first_tab"),
#                list(menu = div(shiny::tags$h6("Portfolios Performance" , style="color:black")), class = "teal", content = plotOutput(ns('Port_performance')) %>% shinycssloaders::withSpinner(), id = "second_tab"),
#                list(menu = div(shiny::tags$h6("Portfolio Table", style="color:black")), class = "teal", content = dataTableOutput(ns('port_table')) %>% shinycssloaders::withSpinner(), id = "third_tab")
#              )))
# }
# 
# panelServer<- function(id) {
#   moduleServer(id, function(input, output, session) {
#     # output$ibox <- renderUI({
#     #   lapply(1:length(id$Portfolio), uiPort, Game= id)
#     # })
#     
#     
#     
#   })
# }

uipanel<- function(id) {
  #ns <- NS(id)
  lapply(1:length(id$Portfolio), uiPort, Game= id)
  #includeCSS("main.css")
  #uiOutput(ns("ibox"))
}

