#test
library(shiny)
library(babynames)
#source("~/ShinyApps/babynames/cleanNames.R")


startYear <- 1900
endYear <- 2013
theYears <- c(startYear, endYear)
sortAlpha <- F
theLetters <- "L"
theSex <- "F"
theName <- "mary"


theNames <- parseNames(theSex, startY, endY, theLetters)
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
names <-parseNames(theSex, startYear, endYear, theLetters)
freq <- parseFreq (theSex, startYear, endYear, tolower(theName))
namesSorted <- getSorted(names, T)
boy <- getSex(freq,"M")
girl <- getSex(freq,"F")
namesSorted$name
plot(girl, col="pink")
lines(boy,col="blue")
theplot <- 