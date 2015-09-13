
getYearsNames <- function(df, yearRange){
	df <- df[(df$year>=yearRange[1]) & (df$year<=yearRange[2]),]	
	df <- subset(df, select=-c(year))
	return(df)
}
getSexNames <- function(df, theSex){
	df <- df[df$sex==theSex,]
	df <- subset(df, select=-c(sex))
	return(df)
}
getUniqueNames <- function(data){
	data <- unique(data)
	return(data)
}
startsWith <- function(df, letters="bb"){
	substr(letters,1,1) <- toupper(substr(letters,1,1))
	substr(letters,2,nchar(letters)) <- tolower(substr(letters,2,nchar(letters)))
	df <- df[substr(df$name,1,nchar(letters))==letters,]
	return(df)
}

getAggregatedYears <- function(df){
	df <- aggregate(df[c("prop")],  by=df[c("name")], FUN="mean")	
	return(df)
}
getSorted <- function(df, sortAlpha){
	#df <- subset(df, select=-c(n))
	if (sortAlpha) 
		data <- unique(sort(df$name))
	else {
		df <- aggregate(df[c("prop")],  by=df[c("name")], FUN="mean")
		df <- df[order(df$prop,df$name,decreasing=T),]
		data <- df$name	
		}
	return(data)	
	}

parseNames <- function(theSex,theYears,theLetters,sortAlpha){
		namesOneSex <- getSexNames(babynames, theSex)
		namesYears  <- getYearsNames(namesOneSex,theYears)
		namesLetters<- startsWith(namesYears,theLetters)
		namesAggregated <- getAggregatedYears(namesLetters)
		namesSorted <- getSorted(namesLetters,sortAlpha)
		return(namesSorted)
}

lookupOneName <-function(theSex, theLookup, theYears){
		namesOneSex <- getSexNames(babynames, theSex)
		namesYears  <- getYearsNames(namesOneSex,theYears)
		theAgg <- getAggregatedYears(namesYears)
		theAgg$rank <- perc.rank(theAgg$prop)
		theName <- theAgg[theAgg$name==theLookup,]
		
		return(theName$prop*100)
	
}
#http://stats.stackexchange.com/questions/11924/computing-percentile-rank-in-r
perc.rank <- function(x) trunc(rank(x))/length(x)
