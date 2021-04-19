# Define server logic required to draw a histogram ----
server <- function(input, output) {
  
  # Plot of the new cases with selected countries ----
  # This expression that generates a plot is wrapped in a call
  # to renderPlot to indicate that:
  #
  # 1. It is "reactive" and therefore should be automatically
  #    re-executed when inputs (input$bins) change
  # 2. Its output type is a plot
  output$new_cases_plot <- renderPlot({
    countries <- input$countries
    
    ggplot(covid_data %>% filter(location == countries), 
           aes(x = date, y = new_cases, 
               group = location, color = location)) +
      geom_line(lwd = 1) +
      theme_bw() +
      ylab("Number of new cases") +
      scale_y_continuous(labels = scales::comma) +
      scale_x_date(date_breaks = "1 month") +
      theme(axis.text.x = element_text(angle = 90)) +
      labs(color = "Country/Region") +
      xlab("")
    
    
  })
  
}