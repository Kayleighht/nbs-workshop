source('script/packages.R')
source('script/data-cleaning.R')

barriers <- select(survey1, c("Lack.time.resources", "Mandate.recognition","Mandate.funding",
                              "Networking", "Access.and.Knowledge", "Past.negative.experiences", 
                              "Scale.mismatch","Lack.of.interest.not.relevant"))

#make column names rows for plotting
barriers <- barriers %>%
  pivot_longer(cols = Lack.time.resources:Lack.of.interest.not.relevant, 
               names_to = "barrier", values_to = "importance")

#replace work topics with proper naming
barriers[barriers == "Lack.time.resources"] <- "Lack time and/or resources" 
barriers[barriers == "Mandate.recognition"] <- "Not recognized in job mandate" 
barriers[barriers == "Mandate.funding"] <- "Lack funding opportunities" 
barriers[barriers == "Access.and.Knowledge"] <- "Lack knowledge and/or access" 
barriers[barriers == "Past.negative.experiences"] <- "Past negative experiences or failed attempts"
barriers[barriers == "Scale.mismatch"] <- "Scale mismatch to other sectors"
barriers[barriers == "Lack.of.interest.not.relevant"] <- "Lack interest or not relevant to my work" 

#create count value
# journal name count by country of first author
barriercount <- barriers %>%
  group_by(barrier ,importance) %>%
  dplyr::mutate(importance.count= n())

#remove duplicates
barriercount<- as.data.frame(barriercount[!duplicated(barriercount), ])

barriercount$importance <- factor(barriercount$importance, levels = c("Not applicable", 
                                                                      "Not important",
                                                                      "Somewhat important",
                                                                      "Important",
                                                                      "Very important"))

#PLOTTING
barriers <- barriercount %>%
  filter(!is.na(importance)) %>%
  ggplot() +
  aes(x = reorder(barrier, importance.count), y = importance.count, fill = importance) + 
  geom_col() +
  scale_fill_viridis_d(direction=-1, end = 1, begin = 0.1, name="Level of Importance") +
  labs(x= "", y= "") +
  coord_flip() + alltheme #+ theme_legend4 +
#theme(axis.text = element_text(size = 18, colour = "black")) +
#scale_y_continuous(breaks = c(0, 5, 10, 15), limits = c(0,15))
barriers

ggsave(filename ="graphics/Figure7.png", width = 300, units="mm", height = 100 , device='tiff', dpi=100)  

