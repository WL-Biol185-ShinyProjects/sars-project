#Script file to test visualization ideas (leaflet, ggplot, etc)
library(ggplot2)
library(leaflet)
leaflet(data = tidySARSdata) %>% 
  setView(lng = 0, lat = 10, zoom = 2) %>% 
  addTiles() %>% 
  addMarkers(~longitude, ~latitude)

tidySARSdata %>% 
  ggplot(aes(x = total, y = deaths)) + geom_jitter(aes(colour = continent))

recoverydata <- tidySARSdata %>%
  select(areas, casesRecovered, total) %>% 
  mutate(recoveryRate = casesRecovered/total) %>% 
  arrange(recoveryRate)
names(recoverydata) <- c("Countries", "casesRecovered", "total", "Recovery Rate")

recoverydata %>%
  ggplot(aes(`Recovery Rate`, Countries)) +
  geom_segment(aes(x = 0, y = Countries, xend = `Recovery Rate`, yend = Countries), color = "grey50") +
  geom_point(color = "skyblue", size = 3) +
  theme_grey(base_size = 16)
