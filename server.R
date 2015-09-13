library(shiny)
library(babynames)
source("cleanNames.R")
doDebug <<- T
shinyServer(function(input, output, session){
	
	names <- reactive(parseNames(input$theSex, input$startYear, input$endYear, input$theLetters))
	namesSorted <- reactive(getSorted(names(), input$sortAlpha))
	
	output$allTheNames <- renderText(namesSorted())
#	theOneFreq <- reactive({lookupOneName(input$theLookup,theYears())})
})

