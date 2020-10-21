library(tidyverse)
library(readr)
library(shiny)
library(ggplot2)
library(plotly)
library(dplyr)
library(lubridate)
library(leaflet)
library(shinythemes)
library(cov20)


#World data

#data2 <- read.csv("data/WHO-COVID-19-global-data.csv")
#data2$Date_reported <- as.Date(data2$Date_reported)

#data3 <- data2 %>% group_by(Country) %>% filter(Date_reported == "2020-10-06") %>% 
            #select(Country, Cumulative_cases, Cumulative_deaths) %>% 
                #rename(`Cumulative cases` = Cumulative_cases,
                       #`Cumulative deaths` = Cumulative_deaths)

#Australia data

#data4 <- read_csv("data/time_series_covid19_recovered_global_iso3_regions.csv")

#data5 <- data4 %>% filter(`Province/State` %in% c("Australian Capital Territory", "New South Wales", "Northern Territory", "Queensland", "South Australia", "Tasmania", "Victoria", "Western Australia")) %>% 
  #select(-c(`Country/Region`, `ISO 3166-1 Alpha 3-Codes`, `Region Code`, `Region Name`, `Sub-region Code`, `Sub-region Name`, `Intermediate Region Code`, `Intermediate Region Name`)) %>% 
  #rename(State = `Province/State`) %>% 
  #pivot_longer(cols = c("1/22/20":"10/7/20"), 
               #names_to = "Date", 
               #values_to = "Cumulative Cases") %>% mutate(Date = mdy(Date))

#data5$Date <- as.Date(data5$Date)
#data5$Lat <- as.numeric(data5$Lat)
#data5$Long <- as.numeric(data5$Long)

  

ui <- navbarPage(theme = shinytheme("superhero"),
  title = "COVID-19 rattles the World",
  tabPanel(h5("About"), 
           tagList(
             fluidRow(p("Creator : Justin Thomas")),
             tags$br(),
             fluidRow(p("Purpose of app : This app has been created to help users visualize the impact of COVID-19 around the world with a focus on Australia. There is user interactivity within the app, so you can select different choices and/or dates to give you a more interesting and hands-on experience!"))) 
  ),
  tabPanel(h5("Cases in Australia"),
             tagList(
             fluidRow(p("In this section, you can explore the distribution of cases among the Australian states. You can click on the blue circles on the map to see which state it is. When you select a state from the drop down list below, a plot will be generated below the map to show what the trend has been like for the total cases from February to October for the state you have chosen.")),
             tags$br()),
          selectui01("state"),
          leafletOutput("mymap"),
          plotlyOutput("casetrend"),
          verbatimTextOutput("hover"),
          "As you hover over the red line on the plot, you will see a block of numbers appear below the plot. Pay close attention to the 'y' variable, this shows the accumulated cases, which is what the plot displays."),
  tabPanel(h5("Cases around the world"),
           tagList(
             fluidRow(p("In this section, you will be able to visualize how cases have been changing across a time period. When you select a country from the drop down list below, a plot will be generated to show what the trend has been like for the total cases and daily new cases within the date range for the country you have chosen.")),
             tags$br()),
           selectui02("countriesp"),
           dateRangeInput(
             inputId = "date", 
             label = "Please select a date range:", 
             start = min(data2$Date_reported),
             end = max(data2$Date_reported),
             min = min(data2$Date_reported),
             max = max(data2$Date_reported),
             format = "yyyy/mm/dd",
             separator = "to"
           ),
           plotlyOutput("cases"),
           "In this plot, you are visualizing what the trend has been like for total cases (red line) and daily new cases (grey bars) for the country you selected within the date range you chose."),
  tabPanel(h5("COVID-19 statistics around the world"),
           tagList(
             fluidRow(p("In this section, a table for some coronavirus statistics are displayed. You can see a variety of countries' statistics by using the drop-down list below.")),
             tags$br()),
           selectui03("country"),
           tableOutput("summary"),
           textOutput("sumtext")),
  tabPanel(h5("Sources"),
           tagList(
             fluidRow(p("The data used in this app was taken from a number of sources. Without these organizations' hardwork in gathering data, making it open-source and freely available; none of the work I've done would be possible.")), 
             tags$br(),
             fluidRow(p("World Health Organization. (2020, October 8). WHO Coronavirus Disease (COVID-19 Dashboard). Retrieved October 7, 2020 from https://covid19.who.int/")),
             tags$br(),
             fluidRow(p("HDX. (2020, October 9). Novel Coronavirus (COVID-19) Cases Data. Retrieved October 8, 2020, from https://data.humdata.org/dataset/novel-coronavirus-2019-ncov-cases#"))))
    )


server <- function(input, output, session) {
  
  #covid_cases <- reactive(fetch_covid_cases(input$state))
  
  #observeEvent(event_data("plotly_click"), {
    #click <- event_data("plotly_click")
    #this_state <- filter(data5, Long==click$x, Lat==click$y) %>%
      #pull(State)
    #updateSelectInput(session, "state", selected = this_state)
  #})
  
  output$mymap<- renderLeaflet({
    
    leaflet(data5) %>% addTiles() %>% 
      addCircleMarkers(~Long, ~Lat, popup = ~State, color = "blue", opacity = 0.7)
    
  })
  
  output$casetrend <- renderPlotly({
    
    states <- filter(data5, State == input$state)
    
    p3 <- ggplot(data = states, aes(x = Date, y = `Cumulative Cases`)) +
      geom_line(color = "red") +
      scale_x_date(date_breaks = "1 month", date_labels = c("October", "February", "March", "April", "May", "June", "July", "August", "September")) +
      ylab("No. of cases") +
      xlab("Month") +
      ggtitle(paste0("Cumulative cases for ", input$state)) +
      theme(plot.title = element_text(hjust = 0.5, color = "black"))
    
    p3 <- p3 + theme(axis.title.x = element_text(color = "black"),
                     axis.title.y = element_text(color = "black"),
                     panel.background = element_rect(fill = "black", color = "red", size = 3),
                     panel.border = element_rect(color = "black", fill = "transparent", size = 3),
                     plot.background = element_rect(fill = "white", color = "black", size = 1.5))
    
    ggplotly(p3)
  })
  
  output$hover <- renderPrint({
    event_data("plotly_hover")
  })
    
  output$cases <- renderPlotly({
    
    dates <- filter(data2, Country == input$countriesp & Date_reported >= input$date[1] & Date_reported <= input$date[2])
    
    p1 <- ggplot(data = dates, aes(x = Date_reported)) +
    geom_line(aes(y = Cumulative_cases), color = "red") +
    geom_col(aes(y = New_cases), color = "grey", alpha = 0.8) +
    ylab("No. of cases") +
    xlab("Month") +
    ggtitle(paste0("Total and daily confirmed cases in ", input$countriesp, " from ", input$date[1], " to ", input$date[2])) +
    theme(plot.title = element_text(hjust = 0.5, color = "black"))
  
  p1 <- p1 + theme(axis.title.x = element_text(color = "black"),
                   axis.title.y = element_text(color = "black"),
                   panel.background = element_rect(fill = "black", color = "red", size = 3),
                   panel.border = element_rect(color = "black", fill = "transparent", size = 3),
                   plot.background = element_rect(fill = "white", color = "black", size = 1.5))
  
  ggplotly(p1)
  })
  
  output$summary <- renderTable({
    
    countries <- filter(data3, Country == input$country)
    countries
  }, bordered = TRUE, width = "100%", align = "lrr")
  
  output$sumtext <- renderText(paste0("The summary statistics shown for ", input$country, " is related to their total confirmed cases and deaths as of 6th October 2020."))
  }

shinyApp(ui, server)