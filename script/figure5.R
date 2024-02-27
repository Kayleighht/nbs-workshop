source('script/packages.R')
source('script/data-cleaning.R')

scale <- select(survey1, c("scale.engagement"))

#create column for count
scale <- as.data.frame(scale  %>%
                          count(scale.engagement)) 

scale$scaleengagement <- c("Local municipal","Federal", "Provincial")
scale$percent <- (scale$n/68)*100

#PLOT
# Basic piechart
scale.plot <- ggplot(scale, aes(x=scaleengagement, y= percent)) +
  geom_bar(stat = "identity" ,width= 0.9 ,color="black", fill= "#440154") + 
  theme(legend.position="none") +
  alltheme + coord_flip() + 
  labs(x= "Program engagement", y= "Percent respondents") +
  theme_legend

scale.plot

ggsave(filename ="graphics/Figure5.png", width = 300, units="mm", height = 150 , device='tiff', dpi=250)  
