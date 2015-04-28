# ui.R

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
                         choices = list("No damage" = 1, "Damaged" = 2, "Destroyed" = 3),
                         selected = c(2,3)
      ),
      hr(),
      textOutput("text1")
     ),
    style = "opacity = 9.2"
   )
  #,
  
)