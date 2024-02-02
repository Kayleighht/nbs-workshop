source('script/packages.R')
source('script/data-cleaning.R')

stage <- select(survey1, c("stage.barrier"))

#create column for count
stage <- as.data.frame(stage  %>%
                         count(stage.barrier)) 
#remove NA
stage<- na.omit(stage)

# Compute the position of labels
data <- stage %>% 
  arrange(desc(stage.barrier)) %>%
  mutate(prop = n/sum(stage$n) *100) %>%
  mutate(ypos = cumsum(prop)- 0.5*prop )
data$label <- c("Middle \n (27%)", "End \n (14%)", "Start \n (59%)")

#PLOT
# Basic piechart
stage.plot <- ggplot(data, aes(x="", y=prop, fill= stage.barrier)) +
  geom_bar(stat="identity", width=2 , color="black") +
  coord_polar("y", start=0) +
  theme_void() + 
  theme(legend.position="none") +
  geom_text(aes(y = ypos, label = label), color = "black", size=5, family= "serif") +
  scale_fill_viridis_d(end = 1, begin = 0.6)

stage.plot
