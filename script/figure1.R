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

#create count value
# journal name count by country of first author
wtcount <- worktopics %>%
  group_by(topic ,importance) %>%
  dplyr::mutate(importance.count= n())

#remove duplicates
wtcount<- as.data.frame(wtcount[!duplicated(wtcount), ])

wtcount$importance <- factor(wtcount$importance, levels = c("Not applicable", "Tertiary importance", "Secondary importance","Primary importance"))

#PLOTTING
topics <- wtcount %>%
  filter(!is.na(importance)) %>%
  ggplot() +
  aes(x = reorder(topic, importance.count), y = importance.count, fill = importance) + 
  geom_col() +
  scale_fill_viridis_d(direction=-1, end = 1, begin = 0.1, name="Level of Importance") +
  labs(x= "", y= "") +
  coord_flip() + alltheme #+ theme_legend4 +
  #theme(axis.text = element_text(size = 18, colour = "black")) +
  #scale_y_continuous(breaks = c(0, 5, 10, 15), limits = c(0,15))
topics

