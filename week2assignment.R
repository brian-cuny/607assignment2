library(RMySQL)
library(tidyverse)
library(likert)

mydb <- dbConnect(MySQL(), user='root', password='cosmic joke', dbname='week2assignment', host='localhost')

rb <- dbSendQuery(mydb, 'SELECT * FROM ratings')

data <- fetch(rb, n=-1) %>%
  subset(select=c(2:7))

#From Likert Demo
for(i in seq_along(data)) {
  data[,i] <- factor(data[,i], levels=1:5)
}

ldata <- likert(data)
plot(ldata)


moded <- data.frame(t(rbind(apply(data, 2, FUN=function(x){table(factor(x, levels=1:5))})))) %>%
  mutate_all(as.factor)
rownames(moded) <- lapply(names(data), FUN=function(x){gsub('_', ' ', x) %>% toupper()})
colnames(moded) <- 1:5

#do something with table
#make interesting likert plot
#maybe another query?