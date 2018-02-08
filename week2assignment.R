library(RMySQL)
library(tidyverse)
library(likert)
library(ggplot2)

mydb <- dbConnect(MySQL(), user='root', password='', dbname='week2assignment', host='localhost')
rb <- dbSendQuery(mydb, 'SELECT * FROM ratings')
data <- fetch(rb, n=-1) %>%
  subset(select=c(2:7))
colnames(data) <- lapply(names(data), FUN=function(x){gsub('_', ' ', x) %>% toupper()})

str(data)

#From Likert Demo
for(i in seq_along(data)) {
  data[,i] <- factor(data[,i], levels=1:5)
}
str(data)
plot(likert(data), type='heat',low.color='white', high.color='red',text.color='black')


moded <- data.frame(t(rbind(apply(data, 2, FUN=function(x){table(factor(x, levels=1:5), useNA = 'always')}))))
rownames(moded) <- lapply(names(data), FUN=function(x){gsub('_', ' ', x) %>% toupper()})
colnames(moded) <- c(1:5, 'Not Seen')

setNames(data.frame(rownames(moded), apply(moded, 1, FUN=function(x){ sum(x[1:5])/sum(x) })), c('Movie', 'Proportion')) %>%
  ggplot(aes(x=Movie, y=Proportion, fill=Movie)) + geom_bar(stat='identity') + theme(legend.position='none') + labs(title='Proportion of Students Who Saw Movie') + coord_flip()
