
#Load all libraries here
library(shiny)
library(shinydashboard)
library(leaflet)
library(htmltools)
library(leaflet)


#Data Frame for Place Map
SARS_data_ll <- data.frame(
  lat = c(-25.274398, -14.235004, 56.130366	, 35.861660 , 22.396428, 22.198745, 23.697810, 4.570868, 
          61.924110, 46.227638, 51.165691, 20.593684,-0.789275, 41.871940, 29.311660, 4.210484, 46.862496,
          -40.900557, 12.879721, 53.412910, 35.907757, 45.943161, 61.524010, 1.352083, -30.559482, 40.463667,
          60.128161, 46.818188, 15.870032, 55.378051, 37.090240, 14.058324),
  lng = c(133.775136, -51.925280, -106.346771, 104.195397, 114.109497, 113.543873, 120.960515, -74.297333,
          25.748151, 2.213749, 10.451526, 78.962880, 113.921327, 12.567380, 47.481766, 101.975766, 103.846656,
          174.885971, 121.774017, -8.243890, 127.766922, 24.966760, 105.318756, 103.819836, 22.937506, -3.749220,
          18.643501, 8.227512, 100.992541, -3.435973, -95.712891, 108.277199),
  Areas = c("Australia", "Brazil", "Canada", "China", "China, Hong Kong Special Administrative Region", 
            "China, Macao Special Administrative Region","China, Taiwan", "Colombia", "Finland", "France",
            "Germany", "India", "Indonesia", "Italy", "Kuwait", "Malaysia", "Mongolia", "New Zealand", 
            "Philippines", "Republic of Ireland", "Republic of Korea", "Romania", "Russian Federation",
            "Singapore", "South Africa", "Spain", "Sweden", "Switzerland", "Thailand", "United Kingdom",
            "United States", "Vietnam"),
  Total = c("6", "1", "251", "5327", "1755", "1", "665", "1", "1", "7", "9", "3", "2", "4", "1", "5", "9", "1", "14", "1",
            "3", "1", "1", "238", "1", "1", "3", "1", "9", "4", "33", "63"),
  
  NumberofDeaths = c("0", "0", "41", "349", "300", "0", "180", "0", "0", "1", "0", "0", "0", "0", "0", "2", "0", "0", "2",
                     "0", "0", "0", "0", "33", "1", "0", "0", "0", "2", "0", "0", "5"),
  
  stringsAsFactors = FALSE
)

SARS_data_ll$popupText <- paste(strong("Area:"), SARS_data_ll$Areas, br(), strong("Total Cases:"), SARS_data_ll$Total, br(), strong("Total Deaths:"), SARS_data_ll$NumberofDeaths)










#Page Aesthetics
dashboardPage(skin = "red",
  dashboardHeader(title = "The 2003 SARs Epidemic: Jenna Kim and Tiffany Ko",titleWidth = 500),
  #content to put in our sidebar
  dashboardSidebar(width = 200,
      sidebarMenu(
        menuItem("Introduction", tabName = "introduction", icon = icon("info-circle", lib = "font-awesome")),
        menuItem("Time and Place", tabName = "timeandplace", icon = icon ("map-marked-alt", lib = "font-awesome")),
        menuItem("TotalCases", tabName = "totalcases", icon = icon("list-ol", lib = "font-awesome")),
        menuItem("Recoveries", tabName = "recoveries", icon = icon("clinic-medical", lib = "font-awesome")))
      ),
  
  dashboardBody(
    tabItems(
        tabItem(tabName = "introduction",
                h2("place introductory elements here")),
        
        tabItem(tabName = "timeandplace",
                navbarPage("Time and Place of the Epidemic",
                           tabPanel("Time",
                                    fluidRow(
                                       (leafletOutput("timeMap", height = 400, width = 700)),
                                       sliderInput("dateSlider", 
                                                   label = "Date", 
                                                   min = as.Date("2002-11-16", "%Y-%m-%d"),
                                                   max = as.Date("2003-05-05", "%Y-%m-%d"),
                                                   value = as.Date("2002-11-16", "%Y-%m-%d"),
                                                   timeFormat = "%Y-%m-%d",
                                                   animate = TRUE)
                                                  
                                       )),
                           tabPanel("Place",
                                    leaflet(data = SARS_data_ll) %>% 
                                      addTiles() %>% 
                                      addMarkers(popup = ~popupText)))),
        
        tabItem(tabName = "totaldeaths",
                h2("total deaths graph")),
        
        tabItem(tabName = "recoveries",
                h2("recoveries content")))
  )
)

