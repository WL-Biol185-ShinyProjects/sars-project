#Load all libraries here
library(shinydashboard)




#Page Aesthetics
dashboardPage(
  dashboardHeader(title = "The 2003 SARs Epidemic"),
  #content to put in our sidebar
  dashboardSidebar(
      sidebarMenu(
        menuItem("Introduction", tabName = "introduction", icon = icon("info-circle", lib = "font-awesome")),
        menuItem("TotalCases", tabName = "totalcases", icon = icon("dashboard")),
        menuItem("Recoveries", tabName = "recoveries", icon = icon("th"))
      )
    ),
  #content to put in the body
    # Second tab content
  tabItem(tabName = "introduction",
          h2("intro tab content")
  ),
          
  tabItem(tabName = "totalcases",
            fluidRow(
               box(plotOutput("plot1", height = 250)),
                
              box(
                 title = "Controls",
                 sliderInput("slider", "Number of observations:", 1, 100, 50)
          )
        )
      ),
    
      tabItem(tabName = "recoveries",
              h2("Recoveries tab content")
     )
    )