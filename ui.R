# ui.R
library(leaflet)

fluidPage(
  leafletOutput('map.villages'),
#   tableOutput(outputId = 'table'),
  titlePanel(p("hello"),{textOutput("text1")}),
  
  absolutePanel(
    top = 20, left = 30, width = 200,
    draggable = TRUE,
    wellPanel(
      h1("Inputs"),
      checkboxGroupInput("condition", label= h3("Village condition"),
                         choices = list("No damage" = "NO DAMAGE", "Damaged" = "DAMAGED", "Destroyed" = "DESTROYED"),
                         selected = c("DAMAGED", "DESTROYED")
      ),
      hr(),
      sliderInput("year.range", label = "Year range", min = 2003, max = 2010, sep="",
                  value = c(2006, 2007), ticks = FALSE),
      textOutput("text1"),
      hr(),
      textOutput("village.count")
     ),
    style = "opacity = 9.2"
   )
  #,
  
)