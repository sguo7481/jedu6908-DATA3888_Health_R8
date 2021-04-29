server <- function(input, output) {
    
    fectch_data <- reactive({
        countries <- input$countries
        subset <- covid_data %>% 
            dplyr::filter(location %in% countries,
                          date <= input$daterange[2],
                          date >= input$daterange[1])
    return(subset)
    })
    
    # NEW CASES INTERACTIVE PLOT
    output$new_cases_plot <- renderPlotly({
            data <- fectch_data()
            if (input$smooth) {
                g <- ggplot(data, 
                            aes(x = date, y = new_cases_smoothed, 
                                group = location, color = location)) +
                    geom_line(lwd = 1) +
                    theme_bw() +
                    ylab("Number of new cases") +
                    scale_y_continuous(labels = scales::comma) +
                    scale_x_date(date_breaks = "1 month") +
                    scale_color_viridis_d() +
                    theme(axis.text.x = element_text(angle = 90)) +
                    labs(color = "Country/Region") +
                    xlab("")
            } else {
                g <- ggplot(data, 
                            aes(x = date, y = new_cases, 
                                group = location, color = location)) +
                    geom_line(lwd = 1) +
                    theme_bw() +
                    ylab("Number of new cases") +
                    scale_y_continuous(labels = scales::comma) +
                    scale_x_date(date_breaks = "1 month") +
                    scale_color_viridis_d() +
                    theme(axis.text.x = element_text(angle = 90)) +
                    labs(color = "Country/Region") +
                    xlab("")
            }
            g <- plotly::ggplotly(g)
            g
        })
        
    # TOTAL CASES INTERACTIVE PLOT
        output$total_cases_plot <- renderPlotly({
            data <- fectch_data()
            g <- ggplot(data, 
                        aes(x = date, y = total_cases, 
                            group = location, color = location)) +
                geom_line(lwd = 1) +
                theme_bw() +
                ylab("Number of total cases") +
                scale_y_continuous(labels = scales::comma) +
                scale_x_date(date_breaks = "1 month") +
                theme(axis.text.x = element_text(angle = 90)) +
                scale_color_viridis_d() +
                labs(color = "Country/Region") +
                xlab("")
            
            g <-plotly::ggplotly(g)
            g
        })
}