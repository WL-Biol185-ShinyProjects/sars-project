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
    HDIcopyTidySARSdata %>% 
      filter(continent %in% input$continentBox) %>% 
      ggplot(aes(x = `Total Cases`, y = Deaths)) + geom_jitter(aes(colour = `HDI Quartile`), size = 2.5)
  })
  
  
  output$casesAndDeathsDF <- renderDataTable({
    HDIcopyTidySARSdata %>% 
      filter(continent %in% input$continentBox) %>% 
      select(Country, `Total Cases`, Deaths, `Human Development Index (HDI)`)
  })
  

  output$SARSdataExplorer <- renderDataTable({
    tidyDataExplorer %>% 
      select(Country, HDI, `Total Cases`, Female, Male, `Median Age`,
             `Youngest Case`, `Oldest Case`, `First Case`, `Last Case`, `Cases Recovered`,
             Deaths, `Fatality Rate`, `Percentage of Imported Cases`, `Healthcare Workers Affected`)
  })
  

  output$recoveryPlot <- renderPlot({
    recoverydata %>%
      ggplot(aes(`Recovery Rate`, Countries)) +
      geom_segment(aes(x = 0, y = Countries, xend = `Recovery Rate`, yend = Countries), color = "grey50") +
      geom_point(color = "skyblue", size = 3) +
      theme_grey(base_size = 16)
      
  })

}
