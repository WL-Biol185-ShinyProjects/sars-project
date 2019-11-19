#Script file to test visualization ideas (leaflet, ggplot, etc)
library(ggplot2)
library(leaflet)
leaflet(data = tidySARSdata) %>% 
  setView(lng = 0, lat = 10, zoom = 2) %>% 
  addTiles() %>% 
  addMarkers(~longitude, ~latitude)\

tidySARSdata %>% 
  ggplot(aes(x = total, y = deaths)) + geom_jitter(aes(colour = continent))
