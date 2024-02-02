source('script/packages.R')
source('script/data-cleaning.R')

# plot SECTOR of work 
sector <- select(survey1, c("sector.of.work"))

#create column for count
sector <- as.data.frame(sector %>%
  count(sector.of.work)) 

# Compute the position of labels
data <- sector %>% 
  arrange(desc(sector.of.work)) %>%
  mutate(prop = n/sum(sector$n) *100) %>%
  mutate(ypos = cumsum(prop)- 0.5*prop )
data$label <- c("Research \n (40%)", "Practitioner \n (13%)", "Policy \n (25%)", "Management \n (22%)")

#PLOT
# Basic piechart
sector.plot <- ggplot(data, aes(x="", y=prop, fill= sector.of.work)) +
  geom_bar(stat="identity", width=2 , color="black") +
  coord_polar("y", start=0) +
  theme_void() + 
  theme(legend.position="none") +
  geom_text(aes(y = ypos, label = label), color = "black", size=5, family= "serif") +
  scale_fill_viridis_d(end = 1, begin = 0.6)

sector.plot


