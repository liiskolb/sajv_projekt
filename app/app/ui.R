library(shiny)
library(shinydashboard)


# Header elements for the visualization
header <- dashboardHeader(title = "Eesti Meedia", disable = FALSE)

# Sidebar elements for the search visualizations
sidebar <- dashboardSidebar(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "custom.css"),
    tags$script(src = "custom.js")
  ),
  
  sidebarMenu(
    selectInput("variable", "Variable:",
                c("Cylinders" = "cyl",
                  "Transmission" = "am",
                  "Gears" = "gear")),
    menuItem(text = "Vali sõnaliik",
             selectInput("variable", "Variable:",
                         c("Cylinders" = "cyl",
                           "Transmission" = "am",
                           "Gears" = "gear"))
    ) # /menuItem
    # this is where other menuItems & menuSubItems would go
  ) # /sidebarMenu
) # /dashboardSidebar

#Body elements for the search visualizations.
body <- dashboardBody(
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
