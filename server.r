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
    sextidySARSdata %>%
      filter(areas == input$region) %>%
      arrange(Incidence) %>%
      ggplot(aes(Sex,Incidence, fill = Sex)) + 
      geom_histogram(stat= "identity")+
      theme(axis.text.x = element_text(angle = 0, hjust = 1))
  })
  
  output$HDIplot <- renderPlot({
    tidySARSdata %>% 
      filter(continent %in% input$continentBox) %>% 
      ggplot(aes(x = total, y = deaths)) + geom_jitter(aes(colour = HDIquart))
  })
  
  
  output$casesAndDeathsDF <- renderDataTable({
    tidySARSdata %>% 
      filter(continent %in% input$continentBox) %>% 
      select(areas, total, deaths, HDI)
  })
  
  output$recoveryPlot <- renderPlot({
    recoverydata %>%      ggplot(aes(recoveryrate, areas)) +
      geom_segment(aes(x = 0, y = areas, xend = recoveryrate, yend = areas), color = "grey50") +
      geom_point()
      
  })
}
