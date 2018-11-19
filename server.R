#babynames
server <- shinyServer(function(input, output, session){	
  
  nameMatch <-eventReactive(input$goNames, {parseNames(input$theSex1, input$yearRange1[1], input$yearRange1[2], 
                                                       input$theLetters)
	 })
	freq <- eventReactive(input$goName,  {parseFreq (input$theSex1, input$yearRange2[1], input$yearRange2[2],
	                                                 input$theName)})
	compare <- eventReactive(input$goCompare, {parseTwoNames(input$theSex3, input$compareNameOne,input$compareNameTwo,input$yearRange3[1], input$yearRange3[2])})
	#put this in function??
	sortedUniqueNames <- reactive(getSorted(nameMatch(), isolate(input$sortAlpha)))

	output$allTheNames <- renderTable(sortedUniqueNames())
	output$nameOverTime <- renderPlot(ggplot(freq(), aes(x=year, y=prop*100,group=sex))
	                                  +geom_line(aes(colour=sex))
	                                  )
	output$plotCompare <- renderPlot(ggplot(compare(), aes(x=year, y=prop*100,group=sex))
	                                + geom_point(aes(colour=name))
	)
})