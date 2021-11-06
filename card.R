source("utils.R")

source("nifty.R")


# uicard <- function(id, label = "Counter") {
#   
#   # div(class="ui special cards",
#   #   div(class="card",
#   #     div(class="blurring dimmable image",
#   #       div(class="ui dimmer",
#   #         div(class="content",
#   #           div(class="center",
#   #             div(class="ui inverted button", a(href= route_link(id), "Play!"))
#   #           )
#   #         )
#   #       ), 
#   #       img(src="/elyse.png", height = 100, width = 100)
#   #     ),
#   #       div(class="content",
#   #             div(class="header", a(href= route_link(id), paste(id, " Games", sep = "")),
#   #                 div(class="meta",
#   #                     span(class="date","Created in Sep 2014")
#   #                 )
#   #             ),
#   #             div(class="extra content",
#   #                         a(class="users icon",
#   #                             paste("Total ", dim(Games[Games$Type== id,])[1], " Active Games", sep = "")
#   #                           )))))
#   
#   div(class= "ui card",
#       div(class= "content",
#           div(class= "header", paste(id, " Games", sep = ""))),
#       div(class= "content",
#           h4(class= "ui sub header", "Ongoing games"),
#           div(class= "ui small feed",
#               div(class= "event",
#                   div(class= "content",
#                       div(class= "summary", paste("Total ", dim(Games[Games$Type== id,])[1], " Active Games", sep = "")))))),
#       div(actionButton("button", a(href= route_link(id),"Play!")))
#   )
# }



