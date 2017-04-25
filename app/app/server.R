library(dplyr)
library(ggplot2)
library(wordcloud)
library(scales)

cleandata <- read.csv("~/Desktop/DOK/K_2017/Andmete_visualiseerimine/Projekt/sajv_projekt/data/meediadata_cleaned1.csv")

colors <- c("#ffc820", "#0054a6", "#cf0007", "#00adee") # delfi, err, ohtuleht, postimees
allikad <- c("delfi", "err", "ohtuleht", "postimees")
names(colors) <- allikad
ilus_allikad <- c("Delfi", "ERR", "Õhtuleht", "Postimees")


sonade_jaotus = function(cleandata, sonaliik, colors, allikad, ilus_allikad){
  subdata <- cleandata %>% select(postags, allikas) %>%
    group_by(allikas, postags) %>%
    summarise (n = n()) %>%
    mutate(freq = n / sum(n)) %>% subset(postags==sonaliik) 
  p <- ggplot(subdata, aes(x=allikas, y=freq, fill=allikas)) + geom_bar(stat="identity") + scale_y_continuous(labels=percent) +
    theme_bw() + scale_fill_manual(breaks = allikad, values=colors, labels=ilus_allikad) + labs(y="Osakaal") + theme(axis.title.x=element_blank(), axis.text.x=element_blank(),
                                                                                                                               axis.ticks.x=element_blank(), legend.title=element_blank(), legend.position="bottom")
  return(p)                                                                                                               
}

plot_wordcloud <- function(cleandata, sonaliik){
  subdata <- cleandata %>% select(postags, allikas, lemmas) %>% group_by(lemmas) %>% mutate(count = n()) %>% subset(postags==sonaliik) %>% distinct(lemmas, .keep_all = TRUE)
  wc <- wordcloud(subdata$lemmas, subdata$count, max.words = 100, min.freq = 1, random.order=FALSE, colors=brewer.pal(8,"Dark2"), random.color=FALSE)
  return(wc)
}

top_sonad = function(cleandata, sonaliik, source, colors){
  subdata <- cleandata %>% select(postags, allikas, lemmas) %>% subset(allikas==source & postags==sonaliik) %>%
    group_by(lemmas) %>% mutate(count = n()) %>% filter(row_number(lemmas) == 1) %>% ungroup() %>% mutate(lemmas=as.character(lemmas))
  top10 <- top_n(arrange(subdata, desc(count)), 10, count)
  p <- ggplot(top10, aes(x=reorder(as.factor(lemmas), count), y=count)) + geom_bar(stat="identity", fill=colors[[source]]) + theme_bw() + coord_flip() + xlab("Sõna") + ylab("Sagedus")
  return(p)
}

unikaalsed_sonad = function(cleandata, sonaliik, colors, source){
  subdata <- cleandata %>% select(postags, allikas, lemmas, word_texts) %>% subset(postags==sonaliik) %>% group_by(allikas, lemmas) %>%
    distinct(allikas, lemmas, .keep_all = TRUE) %>%  group_by(lemmas) %>% mutate(count = n()) %>% filter(count==1) 
  wc <- wordcloud(subdata[subdata$allikas==source, ]$lemmas, subdata[subdata$allikas==source,]$count, scale=c(1,.2), random.order=TRUE, rot.per=0.1, colors=colors[[source]],random.color=FALSE, max.words=60)
  return(wc)
}


shinyServer(function(input, output) {
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
})