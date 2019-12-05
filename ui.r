library(shiny)
library(shinydashboard)
library(leaflet)
library(tidyverse)
library(readxl)
library(htmltools)
library(leaflet)
library(ggplot2)

#Page Aesthetics
dashboardPage(skin = "purple",
              dashboardHeader(title = "The 2003 SARS Epidemic: Jenna Kim and Tiffany Ko", titleWidth = 500),
              #content to put in our sidebar
              dashboardSidebar(width = 200,
                               sidebarMenu(
                                 menuItem("Introduction", tabName = "introduction", icon = icon("info-circle", lib = "font-awesome")),
                                 menuItem("Time and Place", tabName = "timeandplace", icon = icon ("map-marked-alt", lib = "font-awesome")),
                                 menuItem("Case by Sex", tabName = "casebysex", icon = icon("list-ol", lib = "font-awesome")),
                                 menuItem("Case by HDI", tabName = "caseByHDI", icon = icon("user-friends", lib = "font-awesome")),
                                 menuItem("Recoveries", tabName = "recoveries", icon = icon("prescription", lib = "font-awesome")),
                                 menuItem("Data Explorer", tabName = "dataExplorer", icon = icon("table", lib = "font-awesome")))
              ),
              #content to put in our main body
              
              dashboardBody(
                
                tabItems(
                  
                  tabItem(tabName = "introduction",
                          fluidRow(
                            titlePanel("Severe Acute Respiratory Syndrome (SARS): An Overview"),
                            column(width = 5,
                                   box(
                                     title = "History of SARS", width = NULL, solidHeader = TRUE, status = "primary",
                                     "The first cases of SARS in late 2002 and early 2003 in Asia were recorded as atypical pneumonia. By March 2003, World Health Organization released a global alert for this atypical, severe pneuomonia of unknown origin, and the Center for Disease Control began to issue health alerts. 
                                       SARS became the first major pandemic of the millenium.A novel coronavirus (named SARS-CoV) was determined to cause SARS. 
                                       SARS-CoV has been found in the civet, a mammalian animal found in China, and horseshoe bats.
                                       Since 2004, there have not been any reported cases of SARS, but the disease has been watched for possible reemergence."
                                   ),
                                   box(
                                     title = "Relevance", width = NULL, solidHeader = TRUE, status = "primary",
                                     "Why are we concerned about a past epidemic? SARS is being watched closely for possible reemergence since it has not been completely eradicated.
                                       Pandemics of infectious diseases are predicted to only increase with globalization. Yet, globalization also allowed for a more coordinated response to control SARS outbreaks.
                                       Data on the 2003 SARS epidemic and global responses to the epidemic are an invaluable resource for coordinating global responses to epidemics in the future. 
                                       In 2012, SARS Co-V was declared a select agent, which means it could possibly pose severe threats to public health and safety.
                                       This means that SARS Co-V, and related coronaviruses, are potential candidates for bioterrorism.
                                       Studying the epidemiology of this coronavirus is important in understanding the nature of infectious diseases as a whole."
                                   ),
                                   box(title = "Links for More Information", width = NULL, background = "blue",
                                       "https://www.cdc.gov/about/history/sars/timeline.htm",
                                       tags$br(),
                                       "https://www.cdc.gov/sars/index.html",
                                       tags$br(),
                                       "https://www.who.int/csr/sars/en/",
                                       tags$br(),
                                       "https://cmr.asm.org/content/20/4/660",
                                       tags$br(),
                                       "https://www.ncbi.nlm.nih.gov/books/NBK92458/",
                                       tags$br(),
                                       "https://www.ncbi.nlm.nih.gov/pubmed/14703130
                                       ")
                                   ),
                            
                                    
                                   box(background = "blue", img(src = "particles_928px.jpg", style = "max-width: 100%;"),
                                 
                                   h5()
                            )
                          )
                  ),
                  
                  tabItem(tabName = "timeandplace",
                          navbarPage("Time and Place of the Epidemic",
                                     tabPanel("Time",
                                              fluidRow(
                                                (leafletOutput("timeMap", height = 455, width = 1000)),
                                                sliderInput("dateSlider", 
                                                            label = "Date", 
                                                            min = as.Date("2002-11-16", "%Y-%m-%d"),
                                                            max = as.Date("2003-05-05", "%Y-%m-%d"),
                                                            value = as.Date("2002-11-16", "%Y-%m-%d"),
                                                            timeFormat = "%Y-%m-%d",
                                                            animate = TRUE,
                                                            step = 7)
                                              )
                                     ),
                                     
                                     
                                     tabPanel("Place",
                                              leaflet(data = SARS_data_ll) %>% 
                                                addTiles() %>% 
                                                addMarkers(popup = ~popupText)
                                     )
                          )
                  ),
                  
                  tabItem(tabName = "casebysex",
                          fluidPage(
                            titlePanel("Case by sex"),
                            sidebarLayout(
                              sidebarPanel(
                                selectInput("region", "Region:",
                                            choices = sort(sextidySARSdata$areas),
                                            selected = 1)
                              ),
                              mainPanel(
                                plotOutput("sexPlot")
                                
                                
                              )
                            )
                          )
                  ),
                  
                  tabItem(tabName = "caseByHDI",
                          navbarPage("Total Cases and Deaths by HDI and Continent",
                                     tabPanel("Human Development Index",
                                              fluidRow(
                                                plotOutput("HDIplot"),
                                                checkboxGroupInput("continentBox", "Continent:",
                                                                   choices = unique(tidySARSdata$continent),
                                                                   selected = "Oceania")
                                              )),
                                     tabPanel("Individual Country Data",
                                              fluidRow(
                                                dataTableOutput("casesAndDeathsDF")
                                              ))
                          )
                  ),
                  
                  tabItem(tabName = "recoveries",
                          titlePanel("Recoveries by Region"),
                          fluidRow(
                            plotOutput("recoveryPlot")
                          )
                          
                  ),
                  tabItem(tabName = "dataExplorer",
                          titlePanel("Data Explorer"),
                          fluidPage(
                            div(dataTableOutput("SARSdataExplorer"), style = "font-size:72%")
                          )
                  )
                )
              )
)
              

