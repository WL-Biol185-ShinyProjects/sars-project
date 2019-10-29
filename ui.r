#Load all libraries here
library(shiny)
library(shinydashboard)
library(leaflet)
















#Page Aesthetics
dashboardPage(skin = "red",
  dashboardHeader(title = "The 2003 SARs Epidemic",titleWidth = 300),
  #content to put in our sidebar
  dashboardSidebar(width = 300,
      sidebarMenu(
        menuItem("Introduction", tabName = "introduction", icon = icon("info-circle", lib = "font-awesome")),
        menuItem("Place", tabName = "place", icon = icon ("map-marked-alt", lib = "font-awesome")),
        menuItem("Time", tabName = "time", icon = icon ("clock", lib = "font-awesome")),
        menuItem("TotalCases", tabName = "totalcases", icon = icon("list-ol", lib = "font-awesome")),
        menuItem("Recoveries", tabName = "recoveries", icon = icon("clinic-medical", lib = "font-awesome")))
      ),
  
  dashboardBody(
    tabItems(
        tabItem(tabName = "introduction",
                h2("intro tab content")),
        tabItem(tabName = "place",
                h2("place map content")),
        tabItem(tabName = "introduction",
                h2("time map content")),
        tabItem(tabName = "totalcases",
                h2("total cases content")),
        tabItem(tabName = "recoveries",
                h2("recoveries content")))
  )
)


