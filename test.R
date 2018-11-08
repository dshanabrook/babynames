#test
library(shiny)
library(babynames)
source("~/ShinyApps/babynames/cleanNames.R")
startY <- 2010
	endY <- 2017
	theYears <- c(startY,endY)
	sortAlpha <- F
	theLetters <- ""
	theSex <- ""

theLookup <- "Mary"

	theNames <- parseNames(theSex, startY, endY, theLetters)
	theNames$rank <- perc.rank(theNames$prop)	
	theNames$rank <- rank(theNames$prop)
	
	namesSorted <- getSorted(theNames, sortAlpha)
	summary(theNames)
	allTheNames <- namesSorted$name
	theOneFreq <- lookupOneName(theLookup, namesSorted)
subset(theNames, rank<1000)
sort(theNames$rank)
