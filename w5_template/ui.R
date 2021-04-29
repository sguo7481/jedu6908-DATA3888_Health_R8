library(shiny)

# Define UI for app that draws a histogram ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("COVID-19 visualisation"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Select the country ----
      # selectInput indciates a box with choices to select from
      # Here choices include all the location in the covid_data; and we will set
      # Australia as default country
      
      selectInput("countries", "Countries/Regions:", 
                  choices = unique(covid_data$location),
                  selected = "Australia",
                  multiple = TRUE),
      checkboxInput("smooth", "Smoothed", value = FALSE),
      dateRangeInput("daterange", "Date range:",
                     start  = min(covid_data$date),
                     end    = max(covid_data$date),
                     min    = min(covid_data$date),
                     max    = max(covid_data$date),
                     format = "mm/dd/yy",
                     separator = " - "),
      
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Title of the plot ----
      h4("New cases"),
      # Output: plot of new cases ----
      plotlyOutput(outputId = "new_cases_plot"),
      
      
      h4("Total cases"),
      # Output: plot of total cases ----
      plotlyOutput(outputId = "total_cases_plot")
      
    )
  )
)
