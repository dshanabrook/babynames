# googleAnalytics <- function(account="UA-27455672-6"){
#   HTML(paste("<script type=\"text/javascript\">
# 
#              var _gaq = _gaq || [];
#              _gaq.push(['_setAccount', '",account,"']);
#              _gaq.push(['_setDomainName', 'bravo.shinyapps.io']);
#              _gaq.push(['_trackPageview']);
#              
#              (function() {
#              var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
#              ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
#              var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
#              })();
# 
# 
#   </script>", sep=""))
# }

ui <- fluidPage(
	

		fluidRow("More baby names then you could imagine"),
    fluidRow(
				column(width=3,selectInput("theSex","",list("Girl"="F","Boy"="M"))),
				column(width=3,selectInput("sortAlpha","Sort:", list("Popularity"=FALSE,"Alphabetically"=TRUE))),
				column(width=3,textInput("startYear", "Starting year:", value="1880")),
				column(width=3,textInput("endYear", "Ending year:", value="2013"))),
		fluidRow(
				#sliderInput("yearRange", label = h3("Year Range"), format = "####", min = 1880,  max = 2013, value = c(1880, 2013)),
		   column(width=3,textInput("theLetters", "Use zero or more letters:", value="L")),
		   column(width=3,textInput("theLookup", "Lookup a name:", value="Mary")),
		   column(width=3,helpText("Gives all US baby names from 1880-2013.")),
		   column(width=3,actionButton("go", "Get Names"))
				),
	    fluidRow(column(width=6,outputId="theOneFreq"),
		             column(width=6,plotOutput(outputId="thePlot"))),
		    fluidRow(column(width=4,h4(plotOutput(outputId="thePlot")))),
		    fluidRow(column(width=2,h5(textOutput(outputId="allTheNames"))))
	#	colh4(textOutput(outputId="theOneFreq")),
	#	h4(plotOutput(outputId="thePlot")),
	#	h5(textOutput(outputId="allTheNames")),
		
#		googleAnalytics()
)))

