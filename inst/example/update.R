library(shiny)
library(rdatalist)
library(ggplot2)
library(dplyr)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      datalistInput(inputId = "list",
                    datalistId = "datalist",
                    label = "Select an option",
                    options = as.vector(unique(iris$Species))),
      verbatimTextOutput("listOutput", placeholder = TRUE),
      hr(),
      checkboxInput('updater', label = "See mpg dataset")
    ),
    mainPanel(
      plotOutput("scatter")
    )
  )
)

server <- function(input, output, session) {
  dataInput <- reactive({
    if (input$updater) {
      manufacturers <- as.vector(unique(mpg$manufacturer))
      updateDatalistInput(session, inputId = "list", options = manufacturers)
      if (!(input$list %in% manufacturers)) {
        data <- mpg
      } else {
        data <- mpg %>% filter(manufacturer %in% input$list)
      }
    } else {
      species <- as.vector(unique(iris$Species))
      updateDatalistInput(session, inputId = "list", options = species)
      if (!(input$list %in% species)) {
        data <- iris
      } else {
        data <- iris %>% filter(Species %in% input$list)
      }
    }
    data
  })
  output$scatter <- renderPlot({
    if (input$updater) {
      ggplot(dataInput(), aes(x=cty, y=cyl, color=manufacturer)) +
        geom_point()
    } else {
      ggplot(dataInput(), aes(x=Sepal.Length, y=Sepal.Width, color=Species)) +
        geom_point()
    }
  })
  output$listOutput <- renderText({
    input$list
  })
}

shinyApp(ui, server)
