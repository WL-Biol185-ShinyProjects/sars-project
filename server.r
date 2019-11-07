function(input, output, session) {
  
  lats <- -90:90
  lons <- -180:180
    
  output$timeMap <- renderLeaflet({
    tidySARSdata %>% 
      filter(firstOnset <= input$dateSlider) %>% 
      leaflet() %>% 
      setView(lng = 0, lat = 10, zoom = 2) %>% 
      addTiles() %>% 
      addMarkers(~longitude, ~latitude)
  })
}
