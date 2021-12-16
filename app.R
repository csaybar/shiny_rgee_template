#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(leaflet)
library(shiny)
library(rgee)

source("utils.R")


# 1. Set rgee ----------------------------------------------------------
if (!reticulate::virtualenv_exists("rgee_py")) {
    set_rgee_dependencies()
}


# 2. Run again ee_Initialize, after a long period of inactivity. ----------
tryCatch(
    expr = ee$Image(0),
    error = function(e) {ee_Initialize()}
)




# 3. DEFINE HERE YOUR APP -------------------------------------------------
ui <- fluidPage(
    leafletOutput("mymap"),
    p(),
    actionButton("recalc", "Add SRTM Global Map")
)
server <- function(input, output, session) {
    dem_map <- eventReactive(input$recalc, {
        Map$addLayer(ee$Image('srtm90_v4'), list(min = 0, max = 1000))
    }, ignoreNULL = FALSE)

    output$mymap <- renderLeaflet({
        dem_map()
    })
}
shinyApp(ui = ui, server = server)
# -------------------------------------------------------------------------


