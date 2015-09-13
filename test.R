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
names <- getAggregatedYears(getYearsNames(getSexNames(babynames,theSex), theYears))
names[names$name==theLookup,]$prop*100
	x <-								getSorted(
										getAggregatedYears(
											startsWith(
												getYearsNames(
														getSexNames(babynames,theSex),
														theYears),
												theLetters)
											),
									sortAlpha)

lookupOneName(theSex,theLookup, theYears)
