library(shiny)
library(rdatalist)
library(ggplot2)
library(dplyr)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      datalist(inputId = "iris",
               datalistId = "species",
               label = "Select a specie",
               options = as.vector(unique(iris$Species))),
      verbatimTextOutput("irisOutput", placeholder = TRUE)
    ),
    mainPanel(
      plotOutput("scatter")
    )
  )
)

server <- function(input, output) {
  dataInput <- reactive({
    species <- as.vector(unique(iris$Species))
    if (!(input$iris %in% species)) {
      data <- iris
    } else {
      data <- iris %>% filter(Species %in% input$iris)
    }
    data
  })
  output$scatter <- renderPlot({
    ggplot(dataInput(), aes(x=Sepal.Length, y=Sepal.Width, color=Species)) +
      geom_point()
  })
  output$irisOutput <- renderText({
    input$iris
  })
}

shinyApp(ui, server)
