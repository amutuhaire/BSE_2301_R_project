# Reading and manipulation of csvs
# library(tidyr)
# library(tidyverse)
library(ggplot2)
library(wordcloud2)
library(shinydashboard)
library(treemap)
library(shiny)
library(latticeExtra)

demo = read.csv("csv/clean_demographics.csv")
avg = readr::read_csv("csv/average_locations.csv")
avg2 = avg[,c(1,ncol(avg))]
returned = read.csv("csv/returned.csv")

# Application
# The header
header <- dashboardHeader(
  #Linking some css
  title = "RDSS"
)

# The sidebar
sidebar <- dashboardSidebar(
  sidebarMenu(
    # Id to make active menu item accessible to the server
    id = "tabs",
    # Home Menu Item
    menuItem("Home",tabName = "home", icon = icon("home")),
    # Datasets Menu Item
    menuItem("Datasets", tabName = "datasets", icon = icon("table")),
    # Visuals Menu Item
    menuItem("Visuals", tabName = "visuals", icon = icon("bar-chart-o")),
    # Conclusions Menu Item
    menuItem("Conclusions", tabName = "conclusions", icon = icon("edit"))
  )
)

# Different displays for the tab items
# Home Tab
home <- tabItem("home",
                rowAbout <- fluidRow(
                  box(width = 12, title = "About RDSS", id = "about", solidHeader = TRUE,
                      p("The Refugee Decision Support System is an application designed to use refugee
                        data to make visual insights that aid in making decisions towards overcoming the problem
                        managing the overwhelming refugee populations in Uganda.")
                  )
                ),
                rowDetails <- fluidRow(
                  box(width = 12, title = "Help", id = "about", solidHeader = TRUE,
                      p("The flow of the application is divided into four sections:"),
                      tags$ol(
                        tags$li("Home - Description and tour of the application."),
                        tags$li("Datasets - Description of the datasets used through the operation of the application."),
                        tags$li("Visuals - Graphical Impressions of the data realized in the datasets."),
                        tags$li("Conclusion - What can be made of the visual impressions produced.")
                      )
                  )
                )
)
# Datasets Tab
datasets <- tabItem("datasets",
                    # Demographics Dataset
                    fluidRow(
                      p(id="preview","A brief preview of the data contained in the various data sets")
                    ),
                    rowDemo <- fluidRow(
                      column(
                        width = 4, 
                        div(class = "data-desc-header", "Demographics for UNHCR's Populations",style="background-color:#1a4c8a;")
                      ),
                      column(
                        width = 8, class = "data-table",
                        tableOutput("demoTable")  
                      )
                    ),
                    # Averaged Dataset
                    rowAvg <- fluidRow(
                      column(
                        width = 4,
                        div(class = "data-desc-header", "Averaged Data",style="background-color:#8a301a;")
                      ),
                      column(
                        width = 8, class = "data-table",
                        tableOutput("avgTable")  
                      )
                    ),
                    # Returned Refugees Dataset
                    rowAvg <- fluidRow(
                      column(
                        width = 4, 
                        div(class = "data-desc-header", "Refugees Received and Returned",style="background-color: #008a8a;")
                      ),
                      column(
                        width = 8, class = "data-table",
                        tableOutput("recevdTable")  
                      )
                    )
)

# Contents of the tabs under the main Visuals Tab
# Line Graph
lineContent <- fluidRow(
  column(width = 12, class = "variables-col",
         div(class="col-name", "Variables"),
         radioButtons(inputId = "linePlot", "Selected Plot:",
                      c(
                        "Refugees Received and Returned per Year" = "receiveVSreturn"
                      )
         )
  ),
  # Plot Row
  fluidRow(
    column( width = 12, class = "graph-area",
            p("Graph"),
            plotOutput("lineOutput")
    )
  )
)

# Bar graphs
barContent <- fluidRow(
  column(width = 12, class = "variables-col",
         div(class="col-name", "Variables"),
         fluidRow(
           radioButtons(inputId = "barPlots", "Age Distribution at each Camp:",
                        c(
                          "From 0 to 4 years" = "f_0_to_4",
                          "From 5 to 17 years" = "f_5_to_17",
                           "From 18 to 59 years" = "f_18_to_59",
                           "60 and above" = "f_60"
                         )
              )
           )
         ),
         # Plot Row
         fluidRow(
           column( width = 12, class = "graph-area",
                   p("Graph"),
                   plotOutput("barOutput")
           )
         )
         
  )
  
  # Lollipop
  lolContent <- fluidRow( 
    column(width = 12, class = "variables-col",
           div(class="col-name", "Variables"),
           radioButtons(inputId = "lolPlot", "Selected Plot:",
                        c(
                          "Average Population over time per Location" = "avgVSLocation"
                        )
           )
    ),
    # Plot Row
    fluidRow(
      column( width = 12, class = "graph-area",
              p("Graph"),
              plotOutput("loliOutput")
      )
    )
  )
  
# Others
wordcloud <- fluidRow(
  column(width = 12, class = "graph-area",
       wordcloud2Output("wordcloudOutput")
   )
)
treemap <- fluidRow(
  column(width = 12, class = "graph-area",
         plotOutput("treeOutput")
  )
)
othersContent <-fluidRow( 
    column(width = 12, class = "variables-col",
           tags$li("The graphical representations used are just a few from the many graphing options available"),
           tags$li("For instance, the graphics below could be used to represent the information on", tags$b("Average Population
                   per Location.")),
           br(),
           navlistPanel(
             tabPanel("WordCloud", wordcloud),
             tabPanel("Treemap", treemap)
           )
  )
  
)

# Visuals tab combined
visuals <- tabItem("visuals",
                   navbarPage(
                     title = "Graphs",id = "graph-nav",fluid = TRUE,collapsible = TRUE,
                     tabPanel(title = "Line", lineContent , value= "line"),
                     tabPanel(title = "Lollipop", lolContent , value= "lollipop"),
                     tabPanel(title = "Bar", barContent , value= "bar"),
                     tabPanel(title = "Others", othersContent , value= "others")
                   )
)

# Conclusions Tab
conclusions <- tabItem("conclusions",
                 fluidRow(
                   box(width = 12, title = "Insights From the Visualizations", id = "conclusions", solidHeader = TRUE,
                       tags$ol(
                         tags$li(""),
                         tags$li(""),
                         tags$li(""),
                         tags$li("")
                       )
                  ) 
                 )
)


# The body
body <- dashboardBody(
  
  #Linking some css
  tags$head(tags$link(rel = "stylesheet",
                      type = "text/css", href = "app.css")),
  # Addition of the various tab data items  
  tabItems(home,datasets,visuals,conclusions)
)



# UI Compilation
ui <- dashboardPage(
  header, sidebar, body
)



# Server
server <- function(input, output) {
  # Plotting the line graph
  output$lineOutput <- renderPlot({
    Total <- xyplot(Total_Refugees ~ Year, returned, type = "l" , lwd=2,ylab=" ")
    Returned <- xyplot(Returned_Refugees ~ Year, returned, type = "l", lwd=2,ylab=" ")
    doubleYScale(Total, Returned,text = c("Total Received", "Returned"))
  })
  
  # Plotting the bar graphs
  output$barOutput <- renderPlot({
    par(mar = c(6.4,5.5,2,0),mgp = c(4, 0.6, 0))
    plotType <- switch(input$barPlots,
                       f_0_to_4 = barplot(t(avg[,2]), names.arg = avg$Location.Name,las=2, beside = T, col = "blue", axis.lty = "solid",
                                          ylab = "Averages", main = "Age 0 - 4", border=NA, cex.names = 0.8),
                       f_5_to_17 = barplot(t(avg[,3]), names.arg = avg$Location.Name,las=2, beside = T, col = "#36A3F0", axis.lty = "solid", 
                                           ylab = "Averages",main = "Age 5 - 17", border=NA, cex.names = 0.8),
                       f_18_to_59 = barplot(t(avg[,4]), names.arg = avg$Location.Name,las=2, beside = T, col = "#74A2C9", axis.lty = "solid",
                                            ylab = "Averages",main = "Age 18 - 59", border=NA, cex.names = 0.8),
                       f_60 = barplot(t(avg[,5]), names.arg = avg$Location.Name,las=2, beside = T, col = "#A8D1ED", axis.lty = "solid",
                                      ylab = "Averages",main = "Age 60 Above", border=NA, cex.names = 0.8)
    )

    plotType
  })
  
  # Plotting the lollipop
  output$loliOutput <-renderPlot({
    ggplot(avg, aes(x=Location.Name, y=AvgTotal)) +
      geom_segment( aes(x=Location.Name, xend=Location.Name, y=0, yend=AvgTotal), color="skyblue") +
      geom_point( color="blue", size=4, alpha=0.6) +
      theme_light() +
      coord_flip() +
      theme(
        panel.grid.major.y = element_blank(),
        panel.border = element_blank(),
        axis.ticks.y = element_blank()
      )
  })
  
  #Others
  # WordCloud
  output$wordcloudOutput <- renderWordcloud2(wordcloud2(avg2,size = 0.4))
  
  # Treemap
  output$treeOutput <- renderPlot({
    treemap(avg,
            index="Location.Name",
            vSize="AvgTotal",
            type="index"
    )
  })
  
  # Rendering the tables
  output$demoTable  <- renderTable(head(demo,10))
  output$avgTable  <- renderTable(head(avg,10))
  output$recevdTable  <- renderTable(head(returned,10))
    
}

shinyApp(ui, server)