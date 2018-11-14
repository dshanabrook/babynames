#global for babynames
library(shiny)
library(babynames)
library(ggplot2)
doDebug <<- F

getSorted <- function(df, sortAlpha){
	if (doDebug) print(cat("getSorted, rows: ", nrow(df)))
	if (sortAlpha) 
	  {#unique <- unique(df$name)
	  #more efficient than unique
		data <- sort(df[!duplicated(df$name),]$name)}
	else {
		df <- aggregate(df[c("prop")],  by=df[c("name")], FUN="mean")
		data <- df[order(df$prop,df$name,decreasing=T),]$name
		#ddpl was slower
	  #df2 <- ddply(df, .(name), summarise, qmean = mean(prop))
		#data <- df2[order(df2$qmean,df2$name,decreasing=T),]$name
		}
	return(data)	
	}

parseNames <-
  function(theSex,
           startYear,
           endYear,
           theLetters) {
 #   if (!is.character(theLetters)) {theLetters <- ""}
    if (doDebug) print(cat("parsenames name: ",theLetters))
    #sex
    df <- babynames[babynames$sex == theSex, ]
    #years
    df2 <- df[(df$year >= startYear) & (df$year <= endYear), ]
    #string
    df3 <- df2[tolower(substr(df2$name,1,nchar(theLetters))) == tolower(theLetters), ]
    print(nrow(df3))
    #aggregate by year (exact match)
    return(df3)
  }

parseTwoNames <- function(theSex, nameOne,nameTwo,startYear,endYear){
  if (doDebug) print(cat("parseTwonames nameOne: ",nameOne))
  df <- babynames[babynames$sex == theSex, ]
  nameOne <- tolower(nameOne)
  nameTwo <- tolower(nameTwo)
  #years
  df2 <- df[(df$year >= startYear) & (df$year <= endYear), ]
  df3 <- df2[(tolower(df2$name) == nameOne) | (tolower(df2$name) == nameTwo), ]
  return(df3)
}

parseFreq <- 
  function(theSex,
           startYear,
           endYear,
           theName) {
    if (doDebug) print("parseFreq ")
    #sex
   df <- babynames
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
