# ui.R
library(leaflet)

fluidPage(
  leafletOutput('map.villages'),
#   tableOutput(outputId = 'table'),
  titlePanel(p("hello"),{textOutput("text1")}),
  
  absolutePanel(
    bottom = 20, right = 20, width = 300,
    draggable = TRUE,
    wellPanel(
      h1("Inputs"),
      checkboxGroupInput("condition", label= h3("Village condition"),
                         choices = list("No damage" = "NO DAMAGE", "Damaged" = "DAMAGED", "Destroyed" = "DESTROYED"),
                         selected = c("DAMAGED", "DESTROYED")
      ),
      hr(),
      textOutput("text1"),
      hr(),
      textOutput("village.count")
     ),
    style = "opacity = 9.2"
   )
  #,
  
)