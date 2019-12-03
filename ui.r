#Load all libraries here
library(shiny)
library(shinydashboard)
library(leaflet)
library(tidyverse)
library(readxl)
library(htmltools)
library(leaflet)
library(ggplot2)

#Page Aesthetics
dashboardPage(skin = "red",
              dashboardHeader(title = "The 2003 SARs Epidemic: Jenna Kim and Tiffany Ko",titleWidth = 500),
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
                  
                  tabItem(tabName = "introduction"),
                  
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
                            
                          )
                  )
                  ),
              
                  tabItem(tabName = "dataExplorer",
                          fluidRow(column(width = 4,
                                           dataTableOutput("SARSdataExplorer"))
                          ))
                )
              

   

                                
