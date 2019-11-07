function(input, output, session) {
  
  lats <- -90:90
  lons <- -180:180
<<<<<<< HEAD
  
  output$worldMap <- renderLeaflet({
    leaflet() %>% 
      setView(lng = -79.442778, lat = 37.783889, zoom = 5) %>% 
      addTiles()
  })
  
  observe({
    # note the dummy use of the action button input
    btn <- input$newButton

    leafletProxy("worldMap") %>%
      setView(lng = sample(lons, 1), lat = sample(lats, 1), zoom = 5)
  })
  
}

  
=======
    
  output$timeMap <- renderLeaflet({
    leaflet(data = tidySARSdata) %>% 
      setView(lng = 0, lat = 10, zoom = 2) %>% 
      addTiles() %>% 
      addMarkers(~longitude, ~latitude)
    })
    
}

>>>>>>> 9dc4341a1095419fa467d926c07e2d75b12c5ea2
