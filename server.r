function(input, output, session) {
  
  lats <- -90:90
  lons <- -180:180
  
  output$worldMap <- renderLeaflet({
    leaflet() %>% 
      setView(lng = -79.442778, lat = 37.783889, zoom = 5) %>% 
      addTiles()
  })
  
  observe({
    # note the dummy use of the action button input
    btn <- input$newButton
    
<<<<<<< HEAD
    leafletProxy("worldMap") %>%
      setView(lng = sample(lons, 1), lat = sample(lats, 1), zoom = 5)
  })
  
}
=======
    lats <- -90:90
    lons <- -180:180
    
    output$timeMap <- renderLeaflet({
      
      leaflet() %>% 
        setView(lng = 0, lat = 10, zoom = 2) %>% 
        addTiles()
    })
    
}
<<<<<<< HEAD
=======
#function(input, output) {
 # output$worldMap <- renderPrint(
  #  {input$dateSlider}
  #)
#}
>>>>>>> 461d2f67b31da80e0db0fe2898913bcf5640f0d6
>>>>>>> 8bc07fdbf19becc88ac411ecb302e6cd31da2743
