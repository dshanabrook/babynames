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
  headerPanel(fluidRow(offset = 4, "More baby names then you could imagine")),
  sidebarPanel(
    selectInput("theSex", "", list("Girl" = "F", "Boy" = "M")),
    selectInput(
      "sortAlpha",
      "Sort:",
      list("Popularity" = FALSE, "Alphabetically" = TRUE)
    ),
    textInput("startYear", "Starting year:", value = "1880"),
    textInput("endYear", "Ending year:", value = "2013"),
    #sliderInput("yearRange", label = h3("Year Range"), format = "####", min = 1880,  max = 2012, value = c(1880, 2013)),
    textInput("theLetters", "Name Start:", value = "L"),
    textInput("theLookup", "Lookup a name:", value = "Mary"),
    actionButton("go", "Get Names"),
    h4(textOutput(outputId = "theOneFreq"))
  ),
  #		   column(width=2,helpText("Gives all US baby names from 1880-2013.")),
  
  mainPanel(column(6, h4(
    plotOutput(outputId = "thePlot")
  )),
  column(4, h5(
    textOutput(outputId = "allTheNames")
  )))
)
#		googleAnalytics()
