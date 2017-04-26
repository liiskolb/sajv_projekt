library(shiny)
library(shinydashboard)


# Header elements for the visualization
header <- dashboardHeader(title = "Eesti Meedia", disable = FALSE)

# Sidebar elements for the search visualizations
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Sõnade ülevaade", tabName = "dashboard", icon = icon("bar-chart")),
    menuItem("Lause analüüs", icon = icon("area-chart"), tabName = "widgets"),
    menuItem("Meist", tabName = "info", icon = icon("info"))
  )
)

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
    tabItem(tabName = "info",
            h3("Tähelepanu!"),
            br(),
            div(p("Tegemist on Tartu Ülikooli aine \"Statistiline andmeteadus ja visualiseerimine\" raames loodud rakendusega.")),
            br(),
            p("Alates 12.aprillist 2017 on kord päevas kogutud artiklite pealkirju neljast Eesti uudiseportaalist:"),
            HTML("<ul><li>Delfi</li><li>ERR</li><li>Õhtuleht</li><li>Postimees</li></ul>"),
            p("Kogutud lausetest on esitatud mitmesugused ülevaatlikud visualisatsioonid."),
            br(),br(),
            p(HTML("<b>Kaebuste tekkimise korral pidage nõu Liis Kolbergi või Mari-Liis Allikiviga.</b>"))
    ),
    tabItem(tabName = "dashboard",
            h2("Pealkirjades esinevate sõnade ülevaade"),
            br(),
            fluidRow(
              box(
                selectInput("sonaliik", "Vali sõnaliik mida kuvada:",
                            c("Kõik sõnad" = "koik",
                              "Nimisõna" = "S",
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
                            )
                )
              )
            ),
            fluidRow(
              box(title="Sõnaliigi jaotus", plotOutput("jaotus"), background = "purple"),
              box(title="Sõnapilv", plotOutput("sonapilv"), background = "purple")
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
            
    ),
    
    tabItem(tabName = "widgets",
              h2("Pealkirjade analüüs"),
            br(),
              box(title=NULL, width = NULL, height=NULL, plotlyOutput("pca"), background = "purple")
    )
  )
  
) # /dashboardBody


dashboardPage(header, sidebar, body, skin = "purple")
