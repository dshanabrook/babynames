#test
library(shiny)
library(babynames)
source("~/ShinyApps/babynames/cleanNames.R")
startY <- 1880
	endY <- 2013
	theYears <- c(startY,endY)
	sortAlpha <- TRUE
	theLetters <- "M"
	theSex <- "F"

theLookup <- "Mary"

	names <- parseNames(theSex, startYear, endYear, theLetters)
	namesSorted <- getSorted(names, sortAlpha)
	
	allTheNames <- namesSorted$name
	theOneFreq <- lookupOneName(theLookup, namesSorted)
	

