#babynames
server <- shinyServer(function(input, output, session){	
  
  theBabynames <- reactive(as.data.frame(thebabynames[[input$theNationality]]))
  
  yearRange <- reactive(getYearRange(input$theNationality))
  minYear <- reactive(min(theBabynames()$year))
  maxYear <- reactive(max(theBabynames()$year))
  nameMatch <-eventReactive(input$goNames, {parseNames(theBabynames(), input$theSex1, minYear(), maxYear(), 
                                                       input$theLetters)})
	freq <- eventReactive(input$goName,  {parseFreq (theBabynames(),input$theSex1, minYear(), maxYear(),
	                                                 input$theName)})
	compare <- eventReactive(input$goCompare, {parseTwoNames(theBabynames(),input$theSex3, 
	                                                         input$compareNameOne,input$compareNameTwo,
	                                                         minYear(), maxYear())})
	#put this in function??
	sortedUniqueNames <- reactive(getSorted(nameMatch(), isolate(input$sortAlpha)))

	output$allTheNames <- renderTable(sortedUniqueNames())
	output$nameOverTime <- renderPlot(ggplot(freq(), aes(x=year, y=prop*100,group=sex))
	                                  +geom_line(aes(colour=sex))
	                                  )
	output$plotCompare <- renderPlot(ggplot(compare(), aes(x=year, y=prop*100,group=sex))
	                                + geom_point(aes(colour=name))
	)
	output$slider <- renderUI(sliderInput("yearRange", label="Year Range", sep="",
	                                      min=minYear(), max=maxYear(),value=c(minYear(),maxYear()))       
	)
})
  