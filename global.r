#global for babynames
library(shiny)
library(babynames)
library(ggplot2)
library(magrittr)
#devtools::install_github( "ThinkR-open/prenoms" )
#install.packages("ukbabynames")
library("prenoms")
#install.packages("shinycssloaders")
library(shinycssloaders)
doDebug <<- F

#load("data/babynames1974_2015.RData")
# dat: scottish babynames, needs reformatting.

data(prenoms)
#[1] "year" "sex"  "name" "n"    "dpt"  "prop"
data(ukbabynames)
#[1] "year" "sex"  "name" "n"    "rank"
data(babynames)
#[1] "year" "sex"  "name" "n"    "prop"

getSorted <- function(df, sortAlpha){
	if (doDebug) print(cat("getSorted, rows: ", nrow(df)))
	if (sortAlpha) 
	  {#unique <- unique(df$name)
	  #more efficient than unique
		data <- as.data.frame(sort(df[!duplicated(df$name),]$name))
		colnames(data) <- " "
		}
	else {
		df <- aggregate(df[c("prop")],  by=df[c("name")], FUN="mean")
		data <- df[order(df$prop,df$name,decreasing=T),]$name
		data <- as.data.frame(data)
		colnames(data) <- " "
		#ddpl was slower
	  #df2 <- ddply(df, .(name), summarise, qmean = mean(prop))
		#data <- df2[order(df2$qmean,df2$name,decreasing=T),]$name
		}
	return(data)	
	}

parseNames <-
  function(theBabynames,
           theSex,
           startYear,
           endYear,
           theLetters) {
 #   if (!is.character(theLetters)) {theLetters <- ""}
    if (doDebug) print(cat("parsenames name: ",theLetters))
    #sex
    df <- theBabynames[theBabynames$sex == theSex, ]
    #years
    df2 <- df[(df$year >= startYear) & (df$year <= endYear), ]
    #string
    df3 <- df2[substr(df2$name,1,nchar(theLetters)) == theLetters, ]
    print(nrow(df3))
    #aggregate by year (exact match)
    return(df3)
  }

parseTwoNames <- function(theBabynames, theSex, nameOne,nameTwo,startYear,endYear){
  if (doDebug) print(cat("parseTwonames nameOne: ",nameOne))
  df <- theBabynames[theBabynames$sex == theSex, ]
  #nameOne <- tolower(nameOne)
  #nameTwo <- tolower(nameTwo)
  #years
  df2 <- df[(df$year >= startYear) & (df$year <= endYear), ]
  #df3 <- df2[(tolower(df2$name) == nameOne) | (tolower(df2$name) == nameTwo), ]
  df3 <- df2[(df2$name == nameOne) | (df2$name == nameTwo), ]
  return(df3)
}

parseFreq <- 
  function(theBabynames,
           theSex,
           startYear,
           endYear,
           theName) {
    if (doDebug) print("parseFreq ")
    #sex
   df <- theBabynames
    #years
    df2 <- df[(df$year >= startYear) & (df$year <= endYear), ]
    #print(nrow(df2))
    #aggregate by year (exact match!)
    df5 <- df2[df2$name == theName, ]
    df6 <- aggregate(df5["prop"], by = df5[c("year","sex")], FUN = "mean")
    return(df6)
  }


lookupOneName <-function(theLookup, df){
	if (doDebug) print("lookupOneName ")
		df$rank <- perc.rank(df$prop)
		theName <- df[df$name==theLookup,]
		theProp <- theName$prop*100
		print(theProp)
		return(theProp)
}

getYearRange <- function(theNationality){
  if (theNationality == "france")
    {theMin <- min(prenoms$year)
    theMax <- max(prenoms$year)}
  else if (theNationality == "uk")
    {theMin <- min(ukbabynames$year)
    theMax <- max(ukbabynames$year)}
  else if (theNationality == "usa")
    {theMin <- min(babynames$year)
    theMax <- max(babynames$year)}
  else if (theNationality == "scotland")
  {theMin <- min(babynames$year)
    theMax <- max(babynames$year)}
  return(list(theMin,theMax))
}

#http://stats.stackexchange.com/questions/11924/computing-percentile-rank-in-r
#perc.rank <- function(x) trunc(rank(x))/length(x)
