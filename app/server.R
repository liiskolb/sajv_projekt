source("helpers.R")

cleandata <- read.csv("../data/meediadata_cleaned2.csv")
vectors <- read.csv("../data/vecs_final2.csv")
cleandata$postag_descriptions <-factor(cleandata$postag_descriptions, levels=c("nimisõna", "tegusõna", "pärisnimi", "lausemärk", "määrsõna", "omadussõna algvõrre", "asesõna", "sidesõna", "kaassõna", "põhiarvsõna", "lühend", "omadussõna keskvõrre", "järgarvsõna", "omadussõna ülivõrre", "käändumatu omadussõna", "verbi juurde kuuluv sõna", "hüüdsõna", ""))
# eemalda tühjad postagid
cleandata <- cleandata %>% subset(postag_descriptions!="")

colors <- c("#ffc820", "#0054a6", "#cf0007", "#00adee") # delfi, err, ohtuleht, postimees
allikad <- c("delfi", "err", "ohtuleht", "postimees")
names(colors) <- allikad
ilus_allikad <- c("Delfi", "ERR", "Õhtuleht", "Postimees")


shinyServer(function(input, output, session) {
  output$jaotus <- renderPlot({
    sonade_jaotus(cleandata, sonaliik=input$sonaliik, colors, allikad, ilus_allikad)
  })
  output$sonapilv <- renderPlot({
    plot_wordcloud(cleandata, sonaliik=input$sonaliik)
  })
  output$top_delfi <- renderPlot({top_sonad(cleandata, sonaliik = input$sonaliik, source="delfi", colors)})
  output$top_err <- renderPlot({top_sonad(cleandata, sonaliik = input$sonaliik, source="err", colors)})
  output$top_ohtuleht <- renderPlot({top_sonad(cleandata, sonaliik = input$sonaliik, source="ohtuleht", colors)})
  output$top_postimees <- renderPlot({top_sonad(cleandata, sonaliik = input$sonaliik, source="postimees", colors)})
  
  output$uni_delfi <- renderPlot({unikaalsed_sonad(cleandata, sonaliik=input$sonaliik, colors, source="delfi")})
  output$uni_err <- renderPlot({unikaalsed_sonad(cleandata, sonaliik=input$sonaliik, colors, source="err")})
  output$uni_ohtuleht <- renderPlot({unikaalsed_sonad(cleandata, sonaliik=input$sonaliik, colors, source="ohtuleht")})
  output$uni_postimees <- renderPlot({unikaalsed_sonad(cleandata, sonaliik=input$sonaliik, colors, source="postimees")})
  
  output$pca <- renderPlotly({plot_pca(vectors, colors, allikad, ilus_allikad)})
  
  })