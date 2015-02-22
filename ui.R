library(shiny)
library(ggplot2)
library(rCharts)


shinyUI(fluidPage(
    tags$head(tags$link(rel="shortcut icon", href="www/favicon.ico")),
    title = "AMF DRC Dashboard",

    navbarPage(
      title=div(img(src="https://www.againstmalaria.com/images/logo_AMF.gif", href="https://www.againstmalaria.com/"), h1("Donnees Kanzala Summary")),
      
      # Capacity Test panel
      tabPanel("Capacity Test",
               fluidRow(
                 column(3),
                 column(1 #offset=1,tableOutput('capacity.gain')
                        ),
                 column(1 #offset=1,tableOutput('coverage.gain')
                        )
               ),#fluidRow
               
               fluidRow(
                 column(10,
                        tabsetPanel( #TT to have a consistent view with Field Test panel
                          tabPanel("Device",
                                   fluidRow(
                                     column(2),#column
                                     column(10)
                                   )#fluidRow
                          )#tabPanel
                        )#tabsetPanel
                 )#column
               ),#fluidRow
               
               fluidRow(
                 column(10,
                        tabsetPanel(
                          tabPanel("Details" #dataTableOutput('summary.details')
                                   ),
                          tabPanel("Data" #dataTableOutput("summary.stats")
                                   ),
                          tabPanel("Summary" #dataTableOutput("summary.table")
                                   )
                        )#tabsetPanel
                 )#column
               )#fluidRow
      ),#tabPanel
      # End of Capacity Test panel
      
      # Field test panel
      tabPanel("Field Test",
           fluidRow(
             column(2)#column
           ),#fluidRow
           
           fluidRow(
             column(10, #TT to control the overall width of the dropdown options and the chart
                tabsetPanel(
                  tabPanel("Device",
                     fluidRow(),#tabPanel
                      tabPanel("Time",
                               fluidRow()#fluidRow
                      )#tabPanel
                    )#tabsetPanel
             )#column
           ),#fluidRow,
           
           fluidRow(
             column(10,
                    tabsetPanel()#tabsetPanel
             )#column
           )#fluidRow
      )#tabpanel
      # End of Field Test panel
    )#navbarPage
  ))
)#fluidpage #shinyUI

