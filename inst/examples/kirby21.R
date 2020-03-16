library(shiny)
library(papayaWidget)
img = kirby21.t1::get_t1_filenames()[1]

# Define UI for application that draws a histogram
ui <- fluidPage(
    # Show a plot of the generated distribution
    mainPanel(
        papayaOutput("image")
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$image <- renderPapaya({
        papaya(img)
    })
}

# Run the application
shinyApp(ui = ui, server = server)
