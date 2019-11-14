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
    barplot(SARS_data_ll[,input$Areas]*1000,
            main=input$Areas,
            ylab = "Number of Cases",
            xlab = "Group")
  })
}
