#Load all libraries here
library(shinydashboard)




#Page Aesthetics
dashboardPage(
  dashboardHeader(title = "The 2003 SARs Epidemic"),
  #content to put in our sidebar
  dashboardSidebar(
      sidebarMenu(
        menuItem("TotalCases", tabName = "totalcases", icon = icon("dashboard")),
        menuItem("Recoveries", tabName = "recoveries", icon = icon("th"))
      )
    ),
  #content to put in the body
  dashboardBody(
    tabItems(
      # First tab content
      tabItem(tabName = "totalcases",
              fluidRow(
                box(plotOutput("plot1", height = 250)),
                
                box(
                  title = "Controls",
                  sliderInput("slider", "Number of observations:", 1, 100, 50)
          )
        )
      ),
      
      # Second tab content
      tabItem(tabName = "recoveries",
              h2("Recoveries tab content")
     )
    )
  )
)