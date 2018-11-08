#babynames
server <- shinyServer(function(input, output, session){	

	names <- eventReactive(input$go, {parseNames(input$theSex, input$startYear, input$endYear, isolate(input$theLetters))})
	namesSorted <- reactive(getSorted(names(), input$sortAlpha))
	
	output$allTheNames <- renderText(namesSorted()$name)
	output$theOneFreq <- renderText(lookupOneName(input$theLookup, names()))
	output$thePlot <- renderPlot(hist(rnorm(input$startYear)))
})


#shiny::runApp('~/ShinyApps/babynames/')