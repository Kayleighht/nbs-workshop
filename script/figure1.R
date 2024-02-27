source('script/packages.R')
source('script/data-cleaning.R')

worktopics <- select(survey1, c("Biodiversity.and.conservation", "Natural.resources.and.ecosystem.services", "Human.health.and.wellbeing", 
                                "Nature.education.and.recreation", "Equity.diversity.and.inclusion.and.access.to.nature", "Policy", "Other"))

#make column names rows for plotting
worktopics <- worktopics %>%
  pivot_longer(cols = Biodiversity.and.conservation:Other, names_to = "topic", values_to = "importance")

#replace work topics with proper naming
worktopics[worktopics == "Biodiversity.and.conservation"] <- "Biodiversity and Conservation" 
worktopics[worktopics == "Natural.resources.and.ecosystem.services"] <- "Natural Resources and Ecosystem Services" 
worktopics[worktopics == "Human.health.and.wellbeing"] <- "Human Health and Wellbeing" 
worktopics[worktopics == "Equity.diversity.and.inclusion.and.access.to.nature"] <- "Access to Nature and EDI" 
worktopics[worktopics == "Nature.education.and.recreation"] <- "Nature Education and Recreation" 

unique(worktopics$topic)
#create count value
# journal name count by country of first author
wtcount <- worktopics %>%
  group_by(topic ,importance) %>%
  dplyr::mutate(importance.count= n())

#remove duplicates
wtcount<- as.data.frame(wtcount[!duplicated(wtcount), ])

wtcount$importance <- factor(wtcount$importance, levels = c("Not applicable", "Tertiary importance", "Secondary importance","Primary importance"))

wtcount$topic <- factor(wtcount$topic, levels = c("Biodiversity and Conservation", "Natural Resources and Ecosystem Services", 
                                                  "Human Health and Wellbeing","Policy", "Access to Nature and EDI", 
                                                  "Nature Education and Recreation",
                                                  "Other"))

#wtcount$topic <- factor(wtcount$topic, levels = c("Natural Resources and Ecosystem Services", "Biodiversity and Conservation",
#                                                 "Human Health and Wellbeing", "Access to Nature and EDI", "Nature Education and Recreation",
#                                                 "Policy", "Other"))
                                              

#PLOTTING
topics <- wtcount %>%
  filter(!is.na(importance)) %>%
  ggplot() +
  ggtitle("Workplace Topics") +
  aes(x = topic, y = importance.count, fill = importance) + 
  geom_col() +
  scale_fill_viridis_d(direction=-1, end = 1, begin = 0.1, name="Level of Importance") +
  labs(x= "", y= "") +
  coord_flip() + alltheme +
  theme_legend#+ theme_legend4 +
  #theme(axis.text = element_text(size = 18, colour = "black")) +
  #scale_y_continuous(breaks = c(0, 5, 10, 15), limits = c(0,15))
topics

ggsave(filename ="graphics/Figure1_v1.png", width = 300, units="mm", height = 100 , device='tiff', dpi=250)  
