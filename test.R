#test
library(shiny)
library(babynames)
#source("~/ShinyApps/babynames/cleanNames.R")

library(profvis)
#profvis(runApp())

startYear <- 1900
endYear <- 2013
theYears <- c(startYear, endYear)
sortAlpha <- F
theLetters <- "L"
theSex <- "F"
theName <- "mary"
compareNameOne <- "tom"
compareNameTwo <- "dick"

theNames <- parseNames(theSex, startYear, endYear, theLetters)
theNames$rank <- perc.rank(theNames$prop)
theNames$rank <- rank(theNames$prop)

namesSorted <- getSorted(theNames, sortAlpha)
summary(theNames)
allTheNames <- namesSorted$name
theOneFreq <- lookupOneName(theLookup, namesSorted)
subset(theNames, rank < 1000)
sort(theNames$rank)

###########server dup###########

startYear <- 1900
endYear <- 2013
theYears <- c(startYear, endYear)
sortAlpha <- F
theLetters <- "La"
theSex <- "F"
theName <- "robin"
df <- names
names <-parseNames(theSex, startYear, endYear, theLetters)
freq <- parseFreq (theSex, startYear, endYear, tolower(theName))
namesSorted <- getSorted(names, T)

compare <- parseTwoNames(compareNameOne,compareNameTwo,startYear, endYear)
ggplot(compare, aes(x=year, y=prop*100,group=name)) + geom_line(aes(colour=name))

yearRange <- getYearRange("france")
yearRange[1]
