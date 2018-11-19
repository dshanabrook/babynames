#babynames
server <- shinyServer(function(input, output, session){	
  
  theBabynames <- reactive({
    if (input$theNationality == "france") prenoms
      else if (input$theNationality == "uk") ukbabynames
      else if (input$theNationality == "usa") babynames
      else if (input$theNationality == "scotland") scottishnames
      else print(error)
      })

  yearRange <- reactive(getYearRange(input$theNationality))
  nameMatch <-eventReactive(input$goNames, {parseNames(theBabynames(), input$theSex1, input$yearRange[1], input$yearRange[2], 
                                                       input$theLetters)})
	freq <- eventReactive(input$goName,  {parseFreq (theBabynames(),input$theSex1, input$yearRange[1], input$yearRange[2],
	                                                 input$theName)})
	compare <- eventReactive(input$goCompare, {parseTwoNames(theBabynames(),input$theSex3, 
	                                                         input$compareNameOne,input$compareNameTwo,
	                                                         input$yearRange[1], input$yearRange[2])})
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
	                                      min=yearRange()[[1]], max=yearRange()[[2]],value=c(yearRange()[[1]],yearRange()[[2]]))       
	)
})