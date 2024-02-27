source('script/packages.R')
source('script/data-cleaning.R')

stage <- select(survey1, c("stage.barrier"))

#create column for count
stage <- as.data.frame(stage  %>%
                         count(stage.barrier)) 
#remove NA
stage<- na.omit(stage)

# Compute the position of labels
stage$stagebarrier<- c("Beginning", "End", "Middle")
stage$percent <- (stage$n/56)*100

#PLOT
# Basic piechart
stage.plot <- ggplot(stage, aes(x= reorder(stagebarrier, -percent), y=percent)) +
  geom_bar(stat="identity", width= 0.9 , color="black", fill= "#440154") +
  ggtitle("Stage of project barriers were faced") +
  theme(legend.position="none") +
  alltheme + labs(x= "Stage of Project", y= "Percent") 

stage.plot

ggsave(filename ="graphics/Figure6.png", width = 185, units="mm", height = 150 , device='tiff', dpi=250)  
