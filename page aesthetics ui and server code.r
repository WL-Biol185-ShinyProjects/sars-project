#code for ui aethestics
#Load all libraries here
library(shiny)
library(shinydashboard)
library(leaflet)


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
                                                (leafletOutput("worldMap", height = 400, width = 700)))),
                                     tabPanel("Place"))),
                  
                  tabItem(tabName = "totalcases",
                          h2("total cases content")),
                  tabItem(tabName = "recoveries",
                          h2("recoveries content")))
              )
)

#code for server aesthestics#this is where our server code goes
library(shiny)
library(leaflet)

function(input, output, session) {
  
  lats <- -90:90
  lons <- -180:180
  
  output$worldMap <- renderLeaflet({
    
    leaflet() %>% 
      setView(lng = 0, lat = 10, zoom = 2) %>% 
      addTiles()
  })
  
}