
doStartsWithSubset <- function(df, letters = "bb") {
	if (doDebug) print("doStartsWithSubset ")
	print(letters)
	if (letters != "") {
		substr(letters, 1, 1) <- toupper(substr(letters, 1, 1))
		substr(letters, 2, nchar(letters)) <- tolower(substr(letters, 2, nchar(letters)))
		df <- df[substr(df$name, 1, nchar(letters)) == letters, ]
	}
	return(df)
}

getSorted <- function(df, sortAlpha) {
	if (doDebug) 
		print("getSorted ")
	if (sortAlpha) 
		data <- unique(sort(df$name))
	else {
		df <- aggregate(df[c("prop")], by = df[c("name")], FUN = "mean")
		df <- df[order(df$prop, df$name, decreasing = T), ]
	}
	return(df)
}

parseNames <- function(theSex, startYear, endYear, theLetters, sortAlpha) {
	if (doDebug) 
		print("parsenames ")
	df <- babynames
	df <- df[df$sex == theSex, ]
	df <- df[(df$year >= startYear) & (df$year <= endYear), ]
	df <- doStartsWithSubset(df, theLetters)
	if (doDebug) 
		print("aggregating")
	df <- aggregate(df[c("prop")], by = df[c("name")], FUN = "mean")
	return(df)
}

lookupOneName <- function(theLookup, df) {
	if (doDebug) 
		print("lookupOneName ")
	df$rank <- perc.rank(df$prop)
	theName <- df[df$name == theLookup, ]
	theProp <- theName$prop * 100
	return(theProp)

}
#http://stats.stackexchange.com/questions/11924/computing-percentile-rank-in-r
perc.rank <- function(x) trunc(rank(x))/length(x)
