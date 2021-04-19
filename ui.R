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
      # Here choices include all the location in the covid_data; and we will set
      # Australia as default country
      selectInput("countries", "Countries/Regions:", 
                  choices = unique(covid_data$location),
                  selected = "Australia")
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Title of the plot ----
      h4("New cases"),

      # Output: plot of new cases ----
      plotOutput(outputId = "new_cases_plot")
      
    )
  )
)
