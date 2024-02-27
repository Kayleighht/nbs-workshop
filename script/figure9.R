source('script/packages.R')
source('script/data-cleaning.R')

successmarkers <- select(survey1, c("markers.success"))

#separate values from one column into many
successmarkers <- separate_wider_delim(successmarkers, cols = markers.success, delim = ";", 
                                       names = c("marker1", "marker2", "marker3",
                                                 "marker4", "marker5", "marker6",
                                                 "marker7"),
                                       too_few = "align_start", too_many = "debug")

successmarkers

######### each marker  count ##############
#remove columns not needed
marker1<- subset(successmarkers, select = c("marker1"))
colnames(marker1) <- c("marker")

marker2<- subset(successmarkers, select = c("marker2"))
colnames(marker2) <- c("marker")

marker3<- subset(successmarkers, select = c("marker3"))
colnames(marker3) <- c("marker")

marker4<- subset(successmarkers, select = c("marker4"))
colnames(marker4) <- c("marker")

marker5<- subset(successmarkers, select = c("marker5"))
colnames(marker5) <- c("marker")

marker6<- subset(successmarkers, select = c("marker6"))
colnames(marker6) <- c("marker")

marker7<- subset(successmarkers, select = c("marker7"))
colnames(marker7) <- c("marker")

##MERGING
dfmerge12 <- rbind(marker1, marker2)
dfmerge34 <- rbind(dfmerge12, marker3)
dfmerge45 <- rbind(dfmerge34, marker4)
dfmerge56 <- rbind(dfmerge45, marker5)
dfmerge67 <- rbind(dfmerge56, marker6)
dfmergefinal <- rbind(dfmerge67,marker7)

dfmergefinal <- dfmergefinal %>%
  mutate_if(is.character, str_trim)
dfmergefinal <- na.omit(dfmergefinal)
#rename
successmarkers <- dfmergefinal

#replace work topics with proper naming
successmarkers[successmarkers == "Community mobilization and recognition (event participation, increased use, prize)"] <- "Community engagement or recognition (event participation, increased visitation, awards)" 
successmarkers[successmarkers == "Future funding opportunities (grant application)"] <- "Future financing prospects (grant applications)" 
successmarkers[successmarkers == "Media attention and recognition"] <- "Media attention or recognition" 
successmarkers[successmarkers == "Network expansion (growing your professional network)"] <- "Network expansion (broadening your professional network)" 
successmarkers[successmarkers == "Policy influence (reommendations, proof of concept,  policy changes etc.)"] <- "Policy impact (recommendations, proof of concept, policy change, etc.)" 
successmarkers[successmarkers == "Successful implementation (on the ground change or improvement)"] <- "Successful implementation (on the ground change or improvement)" 
successmarkers[successmarkers == "Successful implementation, (changes, improvements on the ground)"] <- "Successful implementation (on the ground change or improvement)" 

#create count value
wtcount<- successmarkers %>%
  dplyr:: count(marker)

wtcount<- wtcount %>% filter(!marker == "")

wtcount$marker <- factor(wtcount$marker, levels = c("Media attention or recognition", "Future financing prospects (grant applications)", 
                                                            "Published output (academic paper, report, etc.)","Policy impact (recommendations, proof of concept, policy change, etc.)",
                                                            "Network expansion (broadening your professional network)",
                                                            "Community engagement or recognition (event participation, increased visitation, awards)",
                                                            "Successful implementation (on the ground change or improvement)"))

#PLOTTING
success <- ggplot(wtcount) +
  aes(x = marker, y = n) + 
  geom_col(fill = "#440154") +
  labs(x= "", y= "") +
  coord_flip() + alltheme +
  ggtitle("What were the markers of success for the project?")
#+ theme_legend4 +
#theme(axis.text = element_text(size = 18, colour = "black")) +
#scale_y_continuous(breaks = c(0, 5, 10, 15), limits = c(0,15))
success

ggsave(filename ="graphics/Figure9.png", width = 600, units="mm", height = 200 , device='tiff', dpi=350)  

