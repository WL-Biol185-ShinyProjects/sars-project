data(SARS_data_ll)
     
  leaflet(data = SARS_data_ll[1:20,]) %>% addTiles() %>%
    
  addMarkers(~Longitudes, ~Latitudes, popup = ~as.character(mag), label = ~as.character(mag))