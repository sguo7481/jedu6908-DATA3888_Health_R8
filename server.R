server <- function(input, output) {
    
    fetch_data <- reactive({
        countries <- input$countries
        subset <- covid_data %>% 
            dplyr::filter(location %in% countries,
                          date <= input$daterange[2],
                          date >= input$daterange[1])
    return(subset)
    })
    
    
    fetch_map <- reactive({
        world_map <- map_data("world")
        world_map <- world_map %>%
            mutate(region = replace(region, region == "UK", "United Kingdom")) %>%
            mutate(region = replace(region, region == "USA", "United States"))
        
        specific_date = input$slider
        covid_selected <- subset(covid_data, date == specific_date)
        world_map_with_data <- merge(world_map, covid_selected, 
                                     by.x = "region", by.y = "location",
                                     all.x = TRUE)
        world_map_with_data <- world_map_with_data[order(world_map_with_data$order), ]
        
        g <- ggplot(world_map_with_data,  
                    aes(x = long, y = lat, group = group, 
                        fill = get(input$map_variable), text=region)) +
            geom_polygon() +
            theme_void() +
            theme(legend.position = "bottom")
        return (g)
    })
    
    # NEW CASES INTERACTIVE PLOT
    output$new_cases_plot <- renderPlotly({
            data <- fetch_data()
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
            data <- fetch_data()
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
    
    # MAP
        output$covid_map <- renderPlotly({
            options(scipen=999) ## Force R not to use exponential notation. 
            g <-plotly::ggplotly(fetch_map())
            g
        })
}