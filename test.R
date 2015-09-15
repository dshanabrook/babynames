#test
library(shiny)
library(babynames)
source("~/ShinyApps/babynames/cleanNames.R")
startYear <- 1880
	endYear <- 2013
	theYears <- c(startY,endY)
	sortAlpha <- TRUE
	theLetters <- ""
	theSex <- "F"

theLookup <- "Mary"

	df <- parseNames(theSex, startYear, endYear, theLetters)
	namesSorted <- getSorted(df, sortAlpha)
	
	allTheNames <- namesSorted$name
	theOneFreq <- lookupOneName(theLookup, df)
	

