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
  fluidRow(
    box(title="Sõnaliigi jaotus", plotOutput("jaotus"), background = "maroon"),
    box(title="Sõnapilv", plotOutput("sonapilv"), background = "maroon")
  ),
  fluidRow(
    tabBox(
      title = "10 populaarseimat sõna",
      # The id lets us use input$tabset1 on the server to find the current tab
      id = "tabset1",
      tabPanel("Delfi", plotOutput("top_delfi")),
      tabPanel("ERR", plotOutput("top_err")),
      tabPanel("Õhtuleht", plotOutput("top_ohtuleht")),
      tabPanel("Postimees", plotOutput("top_postimees"))
    ),
    tabBox(
      title = "Unikaalsed sõnad",
      # The id lets us use input$tabset1 on the server to find the current tab
      id = "tabset2",
      tabPanel("Delfi", plotOutput("uni_delfi")),
      tabPanel("ERR", plotOutput("uni_err")),
      tabPanel("Õhtuleht", plotOutput("uni_ohtuleht")),
      tabPanel("Postimees", plotOutput("uni_postimees"))
    )
  )
) # /dashboardBody


dashboardPage(header, sidebar, body, skin = "purple")
