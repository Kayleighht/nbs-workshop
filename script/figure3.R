source('script/packages.R')
source('script/data-cleaning.R')

# plot SECTOR of work 
sector <- select(survey1, c("sector.of.work"))
sector[sector == "Practictioner"] <- "Practitioner" 

#create column for count
sector <- as.data.frame(sector %>%
  count(sector.of.work)) 

#adding factor to timescales
#years$timescale <- factor(years$timescale, levels = c("0-5 years", "5-10 years", "10-20 years", ">20 years"))

#PLOTTING
sectorwork <- 
  ggplot(sector) +
  aes(x = reorder(sector.of.work, -n), y = n) + 
  geom_col(fill = "#440154") +
  ggtitle("Which sector do you work in?") +
  scale_fill_viridis_d(direction=-1, end = 1, begin = 0.1, name="Level of Frequency") +
  labs(x= "", y= "") +
  coord_flip() + alltheme +
  theme_legend #+ theme_legend4 +
#theme(axis.text = element_text(size = 18, colour = "black")) +
#scale_y_continuous(breaks = c(0, 5, 10, 15), limits = c(0,15))
sectorwork

ggsave(filename ="graphics/Figure3.png", width = 300, units="mm", height = 100 , device='tiff', dpi=250)  

