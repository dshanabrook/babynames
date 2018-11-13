#babynames
server <- shinyServer(function(input, output, session){	
  
  nameMatch <-eventReactive(input$goNames, {parseNames(input$theSex, input$startYear, input$endYear, 
                                                       isolate(input$theLetters))
	 })
	freq <- eventReactive(input$goName,  {parseFreq (input$theSex, input$startYear, input$endYear, 
	                                                 input$theName)})
	sortedUniqueNames <- reactive(getSorted(nameMatch(), isolate(input$sortAlpha)))
	print(sort)
	output$allTheNames <- renderText(sortedUniqueNames())
	output$nameOverTime <- renderPlot(plot(freq()))
})