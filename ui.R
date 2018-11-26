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
  headerPanel(fluidRow(column(12,h2(style = "height:25px;background-color: light_blue;", "More baby names then you could imagine.")),
              column(12,h6(style = "height:15px;background-color: light_blue;","Sources: US Office of National Statistics, North Atlatntic Population Project, data.gouv.fr - le registre de l'état civil")))),
  
  tabsetPanel(
    tabPanel("Settings",
             sidebarPanel(
               selectInput("theNationality", "Nationality:", 
                           list("France"="france", 
                                "United Kingdom"="uk",  
                                "U.S.A." ="usa", 
                                "Iceland 19th C"="iceland",
                                "Norway 19th C"="norway",
                                "Sweden 19th C"="sweden",
                                "Canada 19th C"="canada"
                                )),#"Scotland"="scotland",
               uiOutput(outputId="slider")
    )),
             
     tabPanel("Find a name",
      sidebarPanel(
        textInput("theLetters", "Find a name that starts with:", value = "Mar"),
        selectInput("theSex", "Sex", list("Girl" = "F", "Boy" = "M")),
        selectInput("sortAlpha","Sort:",list("Popularity" = FALSE, "Alphabetically" = TRUE)),
        actionButton("goNames", "Get Names")
      ),
      
      mainPanel(column(8, h5(withSpinner(uiOutput(outputId = "allTheNames"),color="#0dc5c1"))))
                ),
      tabPanel("Lookup this Name",
            sidebarPanel(
              textInput("theName", "Popularity over time:", value = "Mary"),
               actionButton("goName", "Plot Name Over Time")),
              
            mainPanel(
              column(10, 
                     h5(withSpinner(plotOutput("nameOverTime"),color="#0dc5c1")),
                     column(10, h6(uiOutput(outputId = "summaryText")))
                     ))
               ),
      tabPanel("Compare Two Names",
               sidebarPanel(
                 textInput("compareNameOne", "First Name:", value = "Mary"),
                 textInput("compareNameTwo", "Second Name:", value= "Margaret"),
                 selectInput("theSex3", "Sex", list("Girl" = "F", "Boy" = "M"),selected="Girl"),
                 actionButton("goCompare", "Do Compare")),
                mainPanel(column(10, h5(withSpinner(plotOutput("plotCompare"),color="#0dc5c1"))))
               )
          ))
  

      #		googleAnalytics()
      