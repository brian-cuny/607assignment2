library(RMySQL)
library(tidyverse)
library(likert)
library(ggplot2)
library(reshape)
library(data.table)

<<<<<<< HEAD
#modify for reading into mysql
raw <- read.csv('https://raw.githubusercontent.com/brian-cuny/607assignment2/master/week2assignmentMovies.csv',
                header=TRUE, stringsAsFactors=FALSE)
raw <- cbind(raw, ID=1:nrow(raw))
colnames(raw) <- lapply(names(raw), FUN=function(x){gsub('(\\.)+', ' ', x) %>% toupper()})

users <- subset(raw, select=c(1, 2))
reviews <- melt(subset(raw, select=3:ncol(raw)), id=c('ID'))

write.csv(users, 'C:\\Users\\Brian\\Desktop\\GradClasses\\Spring18\\607\\assignments\\users.csv', eol='\n')
write.csv(reviews, 'C:\\Users\\Brian\\Desktop\\GradClasses\\Spring18\\607\\assignments\\reviews.csv', eol = "\n")

#mysql code to readinto tables


mydb <- dbConnect(MySQL(), user='root', password='cosmic joke', dbname='week2assignment', host='localhost')
rb <- dbSendQuery(mydb, 'SELECT users.email, reviews.movie, reviews.rating FROM users JOIN reviews ON users.user_id = reviews.user_id')
data <- fetch(rb, n=-1) %>%
  dcast(formula=email~movie)

moded <- data.frame(t(rbind(apply(data[,2:ncol(data)], 2, FUN=function(x){table(factor(x, levels=1:5), useNA = 'always')}))))
colnames(moded) <- c(1:5, 'Not Seen')

moded$Movie <- rownames(moded)
moded['Not Seen'] <- NULL
melt(moded) %>%
  ggplot(aes(x=Movie, weight=value, fill=variable)) + geom_bar(position=position_fill(reverse=TRUE)) + labs(title='Proportion of Scores') + coord_flip() + labs(x='Proportion', fill='Score') + scale_fill_manual(values=c("red", "orange", "yellow", 'blue', 'green'))
