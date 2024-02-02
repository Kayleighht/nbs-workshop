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

# Compute the position of labels
data <- years %>% 
  arrange(desc(new_bin)) %>%
  mutate(prop = n/sum(years$n) *100) %>%
  mutate(ypos = cumsum(prop)- 0.5*prop )
data$label <- c("20-50 years \n (28%)", "10-20 years \n (33%)", "5-10 years \n (17%)", "0-5 years \n (22%)")

#PLOT
# Basic piechart
experience.plot <- ggplot(data, aes(x="", y=prop, fill=new_bin)) +
                   geom_bar(stat="identity", width=2 , color="black") +
                   coord_polar("y", start=0) +
                   theme_void() + 
                   theme(legend.position="none") +
                   geom_text(aes(y = ypos, label = label), color = "black", size=6, family= "serif") +
                   scale_fill_viridis_d(end = 1, begin = 0.6)
experience.plot
