#global for babynames
library(shiny)
library(babynames)
library(ggplot2)
doDebug <<- F

getSorted <- function(df, sortAlpha){
	if (doDebug) print("getSorted ")
  print(nrow(df))
  print(names(df))
	if (sortAlpha) 
		data <- unique(sort(df$name))
	else {
		df <- aggregate(df[c("prop")],  by=df[c("name")], FUN="mean")
		data <- df[order(df$prop,df$name,decreasing=T),]$name
		}
	return(data)	
	}

parseNames <-
  function(theSex,
           startYear,
           endYear,
           theLetters) {
    if (doDebug) print("parsenames ")
    #sex
    df <- babynames[babynames$sex == theSex, ]
    #years
    df2 <- df[(df$year >= startYear) & (df$year <= endYear), ]
    #string
    df3 <- df2[tolower(substr(df2$name,1,nchar(theLetters))) == tolower(theLetters), ]
    #aggregate by year (exact match)
    return(df3)
  }

parseFreq <- 
  function(theSex,
           startYear,
           endYear,
           theName) {
    if (doDebug) print("parseFreq ")
    #sex
   df <- babynames#[babynames$sex == theSex, ]
    #years
    df2 <- df[(df$year >= startYear) & (df$year <= endYear), ]
    #print(nrow(df2))
    #aggregate by year (exact match)
    df5 <- df2[tolower(df2$name) == tolower(theName), ]
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
#http://stats.stackexchange.com/questions/11924/computing-percentile-rank-in-r
#perc.rank <- function(x) trunc(rank(x))/length(x)
