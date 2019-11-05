#this is where our server code goes
library(shiny)
library(leaflet)

function(input, output, session) {
    
    lats <- -90:90
    lons <- -180:180
    
    output$worldMap <- renderLeaflet({
      
      leaflet() %>% 
        setView(lng = 0, lat = 10, zoom = 2) %>% 
        addTiles()
      worldMap$
    })
    
  }