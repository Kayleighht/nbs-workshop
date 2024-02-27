source('script/packages.R')
source('script/data-cleaning.R')

engage <- select(survey1, c("Policy2", "Academia", "Management", 
                                "Practictioner"))
engage[engage == "Practictioner"] <- "Practitioner" 
engage[engage == "Very often (e.g., weekly or monthly)"] <- "Very often (e.g., weekly to monthly)" 

#make column names rows for plotting
engage <- engage %>%
  pivot_longer(cols = Policy2:Practictioner, names_to = "sector", values_to = "frequency")

#replace work topics with proper naming
engage[engage == "Policy2"] <- "Policy" 

#create count value
# journal name count by country of first author
engagecount <- engage %>%
  group_by(sector ,frequency) %>%
  dplyr::mutate(frequency.count= n())

#remove duplicates
engagecount<- as.data.frame(engagecount[!duplicated(engagecount), ])

#engagecount$frequency <- factor(engagecount$frequency, levels = c("Not applicable", "Tertiary importance", "Secondary importance","Primary importance"))
engagecount$sector <- factor(engagecount$sector, levels = c("Management", "Practictioner", "Academia","Policy"))


#PLOTTING
engagement <- engagecount %>%
  filter(!is.na(frequency)) %>%
  ggplot() +
  aes(x = sector, y = frequency.count, fill = frequency) + 
  geom_col() +
  ggtitle("Engagement with other Sectors") +
  scale_fill_viridis_d(direction=-1, end = 1, begin = 0.1, name="Level of Frequency") +
  labs(x= "", y= "") +
  coord_flip() + alltheme +
  theme_legend #+ theme_legend4 +
#theme(axis.text = element_text(size = 18, colour = "black")) +
#scale_y_continuous(breaks = c(0, 5, 10, 15), limits = c(0,15))
engagement

ggsave(filename ="graphics/Figure4.png", width = 300, units="mm", height = 100 , device='tiff', dpi=250)  

