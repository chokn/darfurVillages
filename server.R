# server.R
library(leaflet)
library(data.table)
#library(rgdal)

villages  <- data.table(read.csv("darfurVillages.csv"))
villages  <- dplyr::filter(villages, Yr.Range1 == 2006, Aprox.Str1 == 0)

baseMap  <- leaflet() %>%
  addTiles()


shinyServer(function(input, output){
  condition.selected <- reactive({
    data <- input$condition
    data[data==1] <- "NO DAMAGE"
    data[data==2]  <- "DAMAGED"
    data[data==3]  <- "DESTROYED"
    data
  })
  
  
  output$text1  <- renderText (
    c("You have selected " , condition.selected())
    
  )
  
  output$map.villages  <- renderLeaflet({
    villages.filtered  <- filter(villages, Status %in% condition.selected())    
    
    baseMap %>%
      addMarkers(lat=villages.filtered$latitude,lng=villages.filtered$longitude)
  })
  
  #   output$table  <- renderTable({
  #     villages.filtered  <- dplyr::filter(villages,Status %in% condition.selected())   
  #     villages.filtered        
  #   })
  
  
})