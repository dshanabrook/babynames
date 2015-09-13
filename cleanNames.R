
doYearSubset <- function(df, startYear, endYear){
	if (doDebug) print("doYearSubset ")
	df <- df[(df$year>= startYear) & (df$year<= endYear),]	
	df <- subset(df, select=-c(year))
	return(df)
}
doSexSubset <- function(df, theSex){
	if (doDebug) print("doSexSubset ")
	df <- df[df$sex==theSex,]
	df <- subset(df, select=-c(sex))
	return(df)
}
getUniqueNames <- function(data){
	if (doDebug) print("getUniqueNames ")
	data <- unique(data)
	return(data)
}
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

parseNames <- function(theSex,startYear, endYear,theLetters,sortAlpha){
	if (doDebug) print("parsenames ")
		df <- doSexSubset(babynames, theSex)
		df  <- doYearSubset(df,startYear, endYear)
		df<- doStartsWithSubset(df,theLetters)
		df <- getAggregatedYears(df)
		return(df)
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
