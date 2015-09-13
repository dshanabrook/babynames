library(shiny)
library(babynames)
source("cleanNames.R")

shinyServer(function(input, output, session){
	startY <- reactive({input$startYear})
	endY <- reactive({input$endYear})
	
	#theYears <- reactive({input$yearRange})
	theYears <- reactive({c(startY(),endY())})
	sortAlpha <- reactive({input$sortAlpha})
	theLetters <- reactive({input$theLetters})
	theSex <- reactive({input$theSex})
	theLookup <- reactive({input$theLookup})
	
	theNames <- reactive({getSorted(getAggregatedYears(startsWith(getYearsNames(getSexNames(babynames,theSex()),theYears()),theLetters())),sortAlpha())})
#	theNames <- reactive({parseNames(theSex(),theYears(),theLetters(),sortAlpha())})
	output$allTheNames <- renderText(theNames())
	theOneFreq <- reactive({lookupOneName(theLookup(),theYears())})
})

