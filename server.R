#babynames
server <- shinyServer(function(input, output, session){	
  
  theSexInput <- observe(input$theSex)
  nameMatch <-eventReactive(input$goNames, {parseNames(theSexInput(), input$startYear, input$endYear, 
                                                       input$theLetters)
	 })
	freq <- eventReactive(input$goName,  {parseFreq (theSexInput(), input$startYear, input$endYear, 
	                                                 input$theName)})
	compare <- eventReactive(input$goCompare, {parseTwoNames(theSexInput(), input$compareNameOne,input$compareNameTwo,input$startYear, input$endYear)})
	#put this in function??
	sortedUniqueNames <- reactive(getSorted(nameMatch(), isolate(input$sortAlpha)))

	output$allTheNames <- renderText(sortedUniqueNames())
	output$nameOverTime <- renderPlot(ggplot(freq(), aes(x=year, y=prop*100,group=sex))
	                                  +geom_line(aes(colour=sex))
	                                  )
	output$plotCompare <- renderPlot(ggplot(compare(), aes(x=year, y=prop*100,group=sex))
	                                + geom_point(aes(colour=name))
	)
})