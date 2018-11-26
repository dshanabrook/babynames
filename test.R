
source("~/ShinyApps/babynames/global.r")

library(profvis)
#profvis(runApp)

# theNames <- parseNames(theSex, startYear, endYear, theLetters)
# theNames$rank <- perc.rank(theNames$prop)
# theNames$rank <- rank(theNames$prop)

###########server dup###########

sortAlpha <- F
theLetters <- "la"
theSex <- "M"
theName <- "John"
compareNameOne <- "Tom"
compareNameTwo <- "Dick"

theNationality <- "usa"

thebabynames <- as.data.frame(allbabynames[[theNationality]])
minYear <- min(thebabynames$year)
maxYear <- max(thebabynames$year)
nameMatch <-{parseNames(thebabynames, theSex, minYear, maxYear,theLetters)}
freqofaName <- {parseFreq (thebabynames,theSex, minYear, maxYear,theName)}
compare <- parseTwoNames(thebabynames,theSex, compareNameOne,compareNameTwo,minYear, maxYear)
sortedUniqueNames <- getSorted(nameMatch, sortAlpha)
theMedianRankofaName <- ({mean(freqofaName$rank)})
ggplot(compare, aes(x=year, y=prop*100,group=name)) + geom_line(aes(colour=name))


#output$slider <- renderUI(sliderInput("yearRange", label="Year Range", sep="",
#                                      min=minYear(), max=maxYear(),value=c(minYear(),maxYear()))
summaryText <- paste(compareNameOne, 
                "is a", "howCommon", "name.  It is ranked", median(freqofaName$rank), "out of", "howRankedTotal", "names during this period.",
                 sep=" ")
                