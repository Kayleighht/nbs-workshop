source('script/packages.R')
source('script/data-cleaning.R')

years <- select(survey1, "work.")
#omit NA values
years <- na.omit(years)

years<- years %>%
  mutate(across(everything(), as.numeric))

#perform binning with custom breaks
years <- years %>% mutate(new_bin = cut(work., breaks=c(0, 5, 10, 20, 50)))
#create count column
years <- years %>%
  count(new_bin) 

years$timescale<- c("0-5 years", "5-10 years", "10-20 years", ">20 years")

#adding factor to timescales
#years$timescale <- factor(years$timescale, levels = c("0-5 years", "5-10 years", "10-20 years", ">20 years"))

#PLOTTING
timescale <- 
  ggplot(years) +
  aes(x = reorder(timescale, -n), y = n) + 
  geom_col(fill = "#440154") +
  ggtitle("Years working in the field") +
  scale_fill_viridis_d(direction=-1, end = 1, begin = 0.1, name="Level of Frequency") +
  labs(x= "", y= "") +
  coord_flip() + alltheme +
  theme_legend #+ theme_legend4 +
#theme(axis.text = element_text(size = 18, colour = "black")) +
#scale_y_continuous(breaks = c(0, 5, 10, 15), limits = c(0,15))
timescale

ggsave(filename ="graphics/Figure2.png", width = 300, units="mm", height = 100 , device='tiff', dpi=250)  


