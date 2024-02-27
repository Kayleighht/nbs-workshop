source('script/packages.R')
source('script/data-cleaning.R')

enablemarkers <- select(survey1, c("Existing.personal.connection", "Direct.engagement", "Funding.opportunity", 
                        "Student.research", "Place.based.engagement"))

#make column names rows for plotting
enablemarkers <- enablemarkers %>%
  pivot_longer(cols = Existing.personal.connection:Place.based.engagement, names_to = "marker", values_to = "importance")

#replace work topics with proper naming
enablemarkers[enablemarkers == "Existing.personal.connection"] <- "Existing Personal Connection" 
enablemarkers[enablemarkers == "Direct.engagement"] <- "Direct Engagement" 
enablemarkers[enablemarkers == "Funding.opportunity"] <- "Funding Opportunity" 
enablemarkers[enablemarkers == "Student.research"] <- "Student Research" 
enablemarkers[enablemarkers == "Place.based.engagement"] <- "Place-Based Engagement" 

#create count value
# journal name count by country of first author
wtcount <- enablemarkers %>%
  group_by(marker ,importance) %>%
  dplyr::mutate(importance.count= n())

#remove duplicates
wtcount<- as.data.frame(wtcount[!duplicated(wtcount), ])

#add additional work topics with proper naming
wtcount[wtcount == "Existing Personal Connection"] <- "Existing Personal Connection (e.g, previous classmate, acquaintance)" 
wtcount[wtcount == "Direct Engagement"] <- "Direct Engagement (e.g., contacted for an existing project)" 
wtcount[wtcount == "Funding Opportunity"] <- "Funding Opportunity (e.g., response to a grant call or other opportunity)" 
wtcount[wtcount == "Student Research"] <- "Student Research (e.g., graduate student project, intern)" 
wtcount[wtcount == "Place-Based Engagement"] <- "Place-Based Engagement (e.g., local projects in your surrounding area)"


wtcount$importance <- factor(wtcount$importance, levels = c("Not applicable", "Not important", 
                                                            "Somewhat important","Important", "Very important"))

wtcount$marker <- factor(wtcount$marker, levels = c("Direct Engagement (e.g., contacted for an existing project)", 
                                                    "Funding Opportunity (e.g., response to a grant call or other opportunity)",
                                                    "Existing Personal Connection (e.g, previous classmate, acquaintance)",
                                                    "Place-Based Engagement (e.g., local projects in your surrounding area)",
                                                    "Student Research (e.g., graduate student project, intern)")) 
                                                            
#PLOTTING
success <- wtcount %>%
  filter(!is.na(importance)) %>%
  ggplot() +
  aes(x = marker, y = importance.count, fill = importance) + 
  geom_col() +
  scale_fill_viridis_d(direction=-1, end = 1, begin = 0.1, name="Level of Importance") +
  labs(x= "", y= "") +
  coord_flip() + alltheme +
  theme_legend +
  ggtitle("What factors enabled this \n collaboration to be successful?")
  #+ theme_legend4 +
#theme(axis.text = element_text(size = 18, colour = "black")) +
#scale_y_continuous(breaks = c(0, 5, 10, 15), limits = c(0,15))
success

ggsave(filename ="graphics/Figure8.png", width = 380, units="mm", height = 160 , device='tiff', dpi=350)  

