
#returns year range subset
doYearSubset <- function(df, startYear, endYear){
	if (doDebug) print("doYearSubset ")
	df <- df[(df$year>= startYear) & (df$year<= endYear),]	
	return(df)
}

#returns sex subset
doSexSubset <- function(df, theSex){
	if (doDebug) print("doSexSubset ")
	df <- df[df$sex==theSex,]
#	df <- subset(df, select=-c(sex))
	return(df)
}

#returns letters subset
doStartsWithSubset <- function(df, letters="bb"){
	if (doDebug) print("doStartsWithSubset ")
	substr(letters,1,1) <- toupper(substr(letters,1,1))
	substr(letters,2,nchar(letters)) <- tolower(substr(letters,2,nchar(letters)))
	df <- df[substr(df$name,1,nchar(letters))==letters,]
	return(df)
}

getAggregatedYears <- function(df){
	if (doDebug) print("getAggregatedYears ")
	df <- aggregate(df[c("prop")],  by=df[c("name")], FUN="mean")	
	return(df)
}
getSorted <- function(df, sortAlpha){
	if (doDebug) print("getSorted ")
	if (sortAlpha) 
		data <- unique(sort(df$name))
	else {
		df <- aggregate(df[c("prop")],  by=df[c("name")], FUN="mean")
		df <- df[order(df$prop,df$name,decreasing=T),]
		}
	return(df)	
	}

parseNames <- function(theSex,startYear, endYear,theLetters,sortAlpha){
	if (doDebug) print("parsenames ")
		df <- doSexSubset(babynames, theSex)
		df  <- doYearSubset(df,startYear, endYear)
		df<- doStartsWithSubset(df,theLetters)
		df <- getAggregatedYears(df)
		return(df)
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
perc.rank <- function(x) trunc(rank(x))/length(x)
