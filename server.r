function(input, output, session) {
  
  lats <- -90:90
  lons <- -180:180
  
  output$timeMap <- renderLeaflet({
    tidySARSdata %>% 
      filter(firstOnset <= input$dateSlider) %>% 
      leaflet() %>% 
      setView(lng = 10, lat = 20, zoom = 1.5) %>% 
      addTiles() %>% 
      addMarkers(~longitude, ~latitude)
  })
  
  output$sexPlot <- renderPlot({
    gendertidySARSdata %>%
    filter('Areas' == gendertidySARSdata$areas) %>%
    ggplot(gendertidySARSdata, aes(Gender, Incidence)) +
      geom_bar(stat = 'identity')+
      theme(axis.text.x = element_text(angle = 0, hjust = 1))

  })
}
