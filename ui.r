#Load all libraries here
library(shiny)
library(shinydashboard)

#Page Aesthetics
dashboardPage(
  dashboardHeader(title = "The 2003 SARs Epidemic"),
  #content to put in our sidebar
  dashboardSidebar(
      sidebarMenu(
        menuItem("Introduction", tabName = "introduction", icon = icon("info-circle", lib = "font-awesome")),
        menuItem("TotalCases", tabName = "totalcases", icon = icon("dashboard")),
        menuItem("Recoveries", tabName = "recoveries", icon = icon("th"))),
      ),
  
  dashboardBody(
    tabItems(
        tabItem(tabName = "introduction",
                h2("intro tab content")),
        tabItem(tabName = "totalcases",
                h2("total cases content")),
        tabItem(tabName = "recoveries",
                h2("recoveries content")))
  )



