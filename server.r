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
    
    leafletProxy("worldMap") %>%
      setView(lng = sample(lons, 1), lat = sample(lats, 1), zoom = 5)
  })
  
}