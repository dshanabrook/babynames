#babynames
server <- shinyServer(function(input, output, session){	
  
  thebabynames <- reactive(as.data.frame(allbabynames[[input$theNationality]]))
  
 # yearRange <- reactive(getYearRange(input$theNationality))
  minYear <- reactive(min(thebabynames()$year))
  maxYear <- reactive(max(thebabynames()$year))
  startYear <- reactive(input$yearRange[1])
  endYear <- reactive(input$yearRange[2])
 
  nameMatch <-eventReactive(input$goNames, {parseNames(thebabynames(), input$theSex, startYear(), endYear(), 
                                                       input$theLetters)})
	freqofaName <- eventReactive(input$goName,  {parseFreq (thebabynames(),input$theSex, startYear(), endYear(),
	                                                 input$theName)})
	howCommon <- reactive(findHowCommon(freqofaName()$prop))
	
	compare <- eventReactive(input$goCompare, {parseTwoNames(thebabynames(),input$theSex, 
	                                                         input$compareNameOne,input$compareNameTwo,
	                                                         startYear(), endYear())})
	sortedUniqueNames <- reactive(getSorted(nameMatch(), isolate(input$sortAlpha)))
  
	output$allTheNames <- renderTable(sortedUniqueNames())
	output$nameOverTime <- renderPlot(ggplot(freqofaName(), aes(x=year, y=prop*100,group=sex))
	                                  +geom_line(aes(colour=sex))
	                                  )
	output$plotCompare <- renderPlot(ggplot(compare(), aes(x=year, y=prop*100,group=sex))
	                                + geom_point(aes(colour=name)))
	output$slider <- renderUI(sliderInput("yearRange", label="Year Range", sep="",
	                                      min=minYear(), max=maxYear(),value=c(minYear(),maxYear())))
output$summaryText <- renderText(paste(input$theName, 
                                 "was a", howCommon()[1], "name.  It occured ", howCommon()[2], "% during this period.",
                                  sep=" "))
})
  