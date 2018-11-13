#babynames
server <- shinyServer(function(input, output, session){	
  
  nameMatch <-eventReactive(input$goNames, {parseNames(input$theSex, input$startYear, input$endYear, 
                                                       isolate(input$theLetters))
	 })
	freq <- eventReactive(input$goName,  {parseFreq (input$theSex, input$startYear, input$endYear, 
	                                                 input$theName)})
	#put this in function??
	sortedUniqueNames <- reactive(getSorted(nameMatch(), isolate(input$sortAlpha)))

	output$allTheNames <- renderText(sortedUniqueNames())
	output$nameOverTime <- renderPlot(ggplot(freq(), aes(x=year, y=prop*100,group=sex))
	                                  +geom_line(aes(colour=sex))
	                                 # +geom_point()
	                                  )
})