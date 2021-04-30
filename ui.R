library(shiny)
library(shinydashboard)

ui <- dashboardPage( skin = "green",
    
    dashboardHeader(title = "COVID19 Dashboard"),
    
    ## Sidebar content
    dashboardSidebar(
        sidebarMenu(
            menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
            menuItem("Our Team", tabName = "team", icon = icon("user")),
            menuItem("Datasets", tabName = "datasets", icon = icon("book")),
            menuItem("Cases", tabName = "cases", icon = icon("globe")), 
            menuItem("Economic Impact", tabName = "economic", icon = icon("usd")), 
            menuItem("Mental Health Impact", tabName = "mental_health", icon = icon("heart"))
        )
    ),
    
    ## Body content
    dashboardBody(
        
        tabItems(
            # Tab content
            tabItem(tabName = "dashboard",
                    fluidRow(
                        # Input box: changes here applied to plots on the dashboard home
                        box(width = 12,
                            selectInput("countries", "Countries/Regions:", 
                                        choices = unique(covid_data$location),
                                        selected = "Australia",
                                        multiple = TRUE),
                            checkboxInput("smooth", "Smoothed", value = TRUE),
                            dateRangeInput("daterange", "Date range:",
                                           start  = min(covid_data$date),
                                           end    = max(covid_data$date),
                                           min    = min(covid_data$date),
                                           max    = max(covid_data$date),
                                           format = "mm/dd/yy",
                                           separator = " - "),
                            ),
                        box(
                            title = "New COVID19 Cases", status="warning",
                            plotlyOutput(outputId = "new_cases_plot")
                        ),
                        box(
                            title = "Total COVID19 Cases", status="warning",
                            plotlyOutput(outputId = "total_cases_plot")
                        ),
                        box(
                          title = "New COVID-19 Deaths", status = "danger",
                          plotlyOutput(outputId = "new_deaths_plot")
                        ),
                        box(
                            title = "Total COVID-19 Deaths", status = "danger",
                            plotlyOutput(outputId = "total_deaths_plot")
                        ),
                        box(
                            title = "New COVID-19 Vaccinations", status = "success",
                            plotlyOutput(outputId = "new_vaccinations_plot")
                        ),
                        box(
                            title = "Total COVID-19 Vaccinations", status = "success",
                            plotlyOutput(outputId = "total_vaccinations_plot")
                        ),
                        box(width = 12,
                            selectInput("map_variable", "Variable:", 
                                        choices = colnames(covid_data)[c(5:59)],
                                        selected = choices[1],
                                        multiple = FALSE),
                            sliderInput("slider", "Dates:",
                                           min = min(covid_data$date),
                                           max = max(covid_data$date),
                                           value = max(covid_data$date), 
                                           timeFormat = "%Y-%m-%d"),
                            plotlyOutput(outputId = "covid_map", height = "80vh"),
                            height = "80vh"
                        ),
                        box(
                            
                        )
                    )
            ),
            
            # Tab content
            tabItem(tabName = "team",
                    h2("Our Team")
            ),
            
            # Tab content
            tabItem(tabName = "datasets",
                    h2("Datasets")
            ),
            
            # Tab content
            tabItem(tabName = "cases",
                    h2("COVID")
            ),
            
            # Tab content
            tabItem(tabName = "economic",
                    h2("Economic Impact")
            ),
            
            # Tab content
            tabItem(tabName = "mental_health",
                    h2("Mental Health Impact")
            )
        )
    )
)