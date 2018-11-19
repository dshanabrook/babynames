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
  
  tabsetPanel(
    tabPanel("Find a name",
      sidebarPanel(
        textInput("theLetters", "Name Start:", value = "Mar"),
        selectInput("theSex1", "Sex", list("Girl" = "F", "Boy" = "M")),
        selectInput("sortAlpha","Sort:",list("Popularity" = FALSE, "Alphabetically" = TRUE)),
#        textInput("startYear1", "Starting year:", value = "1880"),
#        textInput("endYear1", "Ending year:", value = "2013"),
        sliderInput("yearRange1", label = h3("Year Range"), sep="", min = 1880,  max = 2012, value = c(1880, 2013)),
        actionButton("goNames", "Get Names")
      ),
      
      mainPanel(column(8, h5(withSpinner(uiOutput(outputId = "allTheNames"),color="#0dc5c1"))))
                ),
      tabPanel("Lookup a Name",
            sidebarPanel(
              textInput("theName", "Lookup a name:", value = "Mary"),
#               textInput("startYear2", "Starting year:", value = "1880"),
#               textInput("endYear2", "Ending year:", value = "2013"),
                sliderInput("yearRange2", label = h3("Year Range"), sep="", min = 1880,  max = 2012, value = c(1880, 2013)),

               actionButton("goName", "Plot Name Over Time")),
              
            mainPanel(
              column(10, 
                     h5(withSpinner(plotOutput("nameOverTime"),color="#0dc5c1"))
                     ))
               ),
      tabPanel("Compare Names",
               sidebarPanel(
                 textInput("compareNameOne", "First Name:", value = "Mary"),
                 textInput("compareNameTwo", "Second Name:", value= "Margaret"),
                 selectInput("theSex3", "Sex", list("Girl" = "F", "Boy" = "M"),selected="Girl"),
#                 textInput("startYear3", "Starting year:", value = "1880"),
#                 textInput("endYear3", "Ending year:", value = "2013"),
                  sliderInput("yearRange3", label = h3("Year Range"), sep="", min = 1880,  max = 2012, value = c(1880, 2013)),

                 actionButton("goCompare", "Do Compare")),
                mainPanel(column(10, h5(withSpinner(plotOutput("plotCompare"),color="#0dc5c1"))))
               )
          ))
  

      #		googleAnalytics()
      