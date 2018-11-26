#global for babynames
library(shiny)
library(babynames)
library(ukbabynames)
library(prenoms)
library(ggplot2)
library(magrittr)
library(shinycssloaders)
library(reshape)
#library(dplyr)
# install.packages("genderdata", repos = "http://packages.ropensci.org")

library(genderdata)
data(package = "genderdata") 
doDebug <<- F

#load("data/babynames1974_2015.RData")
# dat: scottish babynames, needs reformatting.

data(prenoms)
#[1] "year" "sex"  "name" "n"    "dpt"  "prop"
#remove dpt
prenomsFr <- prenoms %>% group_by(name, year, sex)
prenomsFr <- prenomsFr  %>% summarise( n = sum(n) ) 
prenomsFr <- prenomsFr  %>% arrange( year )
#[1] "name" "year" "sex"  "n"  

data(ukbabynames)
#[1] "year" "sex"  "name" "n"    "rank"
data(babynames)
#[1] "year" "sex"  "name" "n"    "prop"


modifyNappBabynames <- function(bn){
  bnMod<-melt(bn, id.vars=c("name", "country","year"))
  names(bnMod) <-c("name","country","year","sex","prop")
  bnMod$sex <- as.factor(bnMod$sex)
  levels(bnMod$sex)[levels(bnMod$sex)=="female"] <- "F"
  levels(bnMod$sex)[levels(bnMod$sex)=="male"] <- "M" 
  return(bnMod)
}

napp <- as.data.frame(napp)
norwaybabynames <- modifyNappBabynames(napp[napp$country=="Norway",])
swedenbabynames <- modifyNappBabynames(napp[napp$country=="Sweden",])
canadababynames <- modifyNappBabynames(napp[napp$country=="Canada",])
#ukbabynames <- napp[napp$country=="United Kingdom",]
icelandbabynames <- modifyNappBabynames(napp[napp$country=="Iceland",])
allbabynames <- list(babynamesUSA, ukbabynames, prenomsFr, norwaybabynames, swedenbabynames, canadababynames, icelandbabynames)
names(allbabynames) <- c("usa","uk","france","norway","sweden","canada","iceland")

#what do we want with upper/lower case???
x <- lapply(allbabynames, '[[', 'name')
y <- toupper

getSorted <- function(df, sortAlpha){
	if (doDebug) print(cat("getSorted, rows: ", nrow(df)))
	if (sortAlpha) {
	  #more efficient than unique
		data <- as.data.frame(sort(df[!duplicated(df$name),]$name))
		colnames(data) <- " "
		}
	else {
		df <- aggregate(df[c("prop")],  by=df[c("name")], FUN="mean")
		data <- df[order(df$prop,df$name,decreasing=T),]$name
		data <- as.data.frame(data)
		colnames(data) <- " "
		}
	return(data)	
	}

parseNames <-
  function(theBabynames,
           theSex,
           minYear,
           maxYear,
           theLetters) {
    theLetters <- tolower(theLetters)
    if (doDebug) print(cat("parsenames name: ",theLetters))
    df <- theBabynames[theBabynames$sex == theSex, ]
    df2 <- df[(df$year >= minYear) & (df$year <= maxYear), ]
    df3 <- df2[tolower(substr(df2$name,1,nchar(theLetters))) == theLetters, ]
    return(df3)
  }

parseTwoNames <- function(thebabynames, theSex, compareNameOne,compareNameTwo,minYear,maxYear){
  if (doDebug) print(cat("parseTwonames compareNameOne: ",compareNameOne))
#  compareNameOne <- tolower(compareNameOne)
#  compareNameTwo <- tolower(compareNameTwo)
  df <- thebabynames[thebabynames$sex == theSex, ]
  df2 <- df[(df$year >= minYear) & (df$year <= maxYear), ]
  df3 <- df2[(df2$name == compareNameOne) | (df2$name == compareNameTwo), ]
  return(df3)
}

findHowCommon <- function(freq) {
  freq <- signif(mean(freq)*100,2)
  veryCommon <- 2
  common <- 1
  neither<- 0.5
  rare <-   0.01
  if (freq > veryCommon) commonness <- ("Very common")
  else if (freq > common) commonness <- ("common")
  else if (freq > neither) commonness <- ("neither common nor rare")
  else if (freq > rare) commonness <- ("rare")
  else commonness <- ("Very rare")
  return(list(commonness, freq))
}
parseFreq <- 
  function(thebabynames,
           theSex,
           minYear,
           maxYear,
           theName) {
    if (doDebug) print("parseFreq ")
    #sex
    df <- thebabynames
    df2 <- df[(df$year >= minYear) & (df$year <= maxYear), ]
    #rank is incorrect here.  need the rank for each year seperated!!.  not using rank now, use prop instead
    df2$rank <-row(df2)[,1]
    df3 <- df2[df2$name == theName, ]
    df4 <- aggregate(df3["prop"], by = df3[c("year","sex","rank")], FUN = "mean")
    return(df4)
  }

#http://stats.stackexchange.com/questions/11924/computing-percentile-rank-in-r
#perc.rank <- function(x) trunc(rank(x))/length(x)
