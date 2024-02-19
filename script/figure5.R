source('script/packages.R')
source('script/data-cleaning.R')

scale <- select(survey1, c("scale.engagement"))

#create column for count
scale <- as.data.frame(scale  %>%
                          count(scale.engagement)) 

# Compute the position of labels
data <- scale %>% 
  arrange(desc(scale.engagement)) %>%
  mutate(prop = n/sum(scale$n) *100) %>%
  mutate(ypos = cumsum(prop)- 0.5*prop )
data$label <- c("Provincial \n Policy \n (3%)", "Municipal Policy \n (31%)", "Federal Policy \n (78%)")

#PLOT
# Basic piechart
scale.plot <- ggplot(data, aes(x="", y=prop, fill= scale.engagement)) +
  geom_bar(stat="identity", width=2 , color="black") +
  coord_polar("y", start=0) +
  theme_void() + 
  theme(legend.position="none") +
  geom_text(aes(y = ypos, label = label), color = "black", size=5, family= "serif") +
  scale_fill_viridis_d(end = 1, begin = 0.6)

scale.plot

ggsave(filename ="graphics/Figure5.png", width = 150, units="mm", height = 150 , device='tiff', dpi=100)  
