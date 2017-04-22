library(shiny)
library(shinydashboard)


# Header elements for the visualization
header <- dashboardHeader(title = "Eesti Meedia", disable = FALSE)

# Sidebar elements for the search visualizations
sidebar <- dashboardSidebar(
   
  sidebarMenu(
    selectInput("sonaliik", "Vali sõnaliik:",
                c("Nimisõna" = "S",
                  "Tegusõna" = "V", 
                  "Asesõna" = "P",
                  "Hüüdsõna" = "I",
                  "Järgarvsõna" = "O",
                  "Käändamatu omadussõna" = "G",
                  "Kaassõna" = "K",
                  "Lausemärk" = "Z",
                  "Lühend" = "Y",
                  "Määrsõna" = "D",
                  "Omadussõna algvõrre" = "A",
                  "Omadussõna keskvõrre" = "C",
                  "Omadussõna ülivõrre" = "U",
                  "Pärisnimi" = "H", 
                  "Põhiarvsõna" = "N",
                  "Sidesõna" = "J",
                  "Verbi juurde kuuluv sõna" = "X"
                  ))

    # this is where other menuItems & menuSubItems would go
  ) # /sidebarMenu
) # /dashboardSidebar

#Body elements for the search visualizations.
body <- dashboardBody(
  tags$head(
    #tags$link(rel = "stylesheet", type = "text/css", href = "custom.css"),
    tags$script(src = "custom.js"),
    tags$style(HTML('/* main sidebar */
                    .skin-purple .main-sidebar {
                    background-color:  grey;
                    }
                    '))
  ),
  
  tabItems(
    tabItem(tabName = "kpis_summary",
            fluidRow(valueBoxOutput("kpi_summary_box_1", width = 4),
                     valueBoxOutput("kpi_summary_box_2", width = 4),
                     valueBoxOutput("kpi_summary_box_3", width = 4)),
            p('Include documentation via includeMarkdown("./assets/kpis_summary.md") ')
    ),
    tabItem(tabName = "kpi_1",
            # e.g. plotOutput(), textOutput(), dygraphOutput(), etc.
            p('includeMarkdown("./assets/kpi_1.md") is kinda like a README for this module'))
  ) # /tabItems
) # /dashboardBody


dashboardPage(header, sidebar, body, skin = "purple")
