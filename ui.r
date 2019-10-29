#Load all libraries here
library(shinydashboard)




#Page Aesthetics
dashboardPage(
  dashboardHeader(title = "The 2003 SARs Epidemic"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("TotalCases", tabName = "totalcases", icon = icon("fas fa-book-medical", lib = "glyphicon")),
      menuItem("Recoveries", tabName = "recoveries", icon = icon("th"))
    )
  ),
  dashboardBody(
    tabItems(
      
    
      tabItem ("totalcases",
             h2("totalcases content"),
             
      tabItem(tabName = "recoveries",
             h2("recoveries tab content")
        )
      )
    )
  )
) 
