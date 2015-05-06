# server.R
library(shiny)
library(leaflet)
library(data.table)
library(dplyr)
# a comment
#library(rgdal)

villages  <- read.csv("darfurVillages.csv")
villages  <- dplyr::filter(villages, Yr.Range1 == 2006, Aprox.Str1 == 0)

village.colors  <- c(
         "DESTROYED" ="#ff0000",
         "DAMAGED"='yellow',
         "NO DAMAGE"='green'
         )

colorPal  <- colorFactor(village.colors, names(village.colors))



baseMap  <- leaflet() %>%
  addTiles()
villages.popup = paste0("<strong>Name: </strong>", villages$Name,
                       "<br><strong>Status: </strong>", villages$Status,
                       "<br><strong>Year confirmed: </strong>", villages$Yr.Confirm)

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
  
  villages.filtered  <- reactive({
    dplyr::filter(villages, villages$Status %in% input$condition)
    
  })
  
  output$map.villages  <- renderLeaflet({
    if(as.integer(count(villages.filtered())) == 0)
      {leaflet()}
      else
    
    {baseMap %>%
      addCircleMarkers(data=villages.filtered(), lat= villages.filtered()$Lat.Dd, 
                 lng= villages.filtered()$Long.Dd, 
                 color = ~colorPal(Status),
                 radius = 2,
                 popup = villages.popup
                 )
    }
  })
  
  output$village.count  <- renderText({
    c("Number of villages: ", as.integer(count(villages.filtered())))
    
  })
  
  #   output$table  <- renderTable({
  #     villages.filtered  <- dplyr::filter(villages,Status %in% condition.selected())   
  #     villages.filtered        
  #   })
  
  
})