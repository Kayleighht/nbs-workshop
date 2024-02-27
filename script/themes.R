# Theme Creation ----------------------------------------------------------

alltheme <- theme(
  panel.border = element_blank(), panel.grid.major = element_blank(),
  panel.background = element_rect(fill = "white", color = NA),
  plot.background = element_rect(fill = "white", color = NA),
  panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"),
  text = element_text(family = "", size = 20),
  axis.title.y = element_text(colour = "black",face = "bold", size = '30', vjust = +1),
  axis.title.x = element_text(colour = "black", face = "bold", size= '30', vjust= 0),
  axis.ticks = element_line(size = 0.7),
  axis.text = element_text(size = 20, colour = "black")
)

#LEGEND 1 THEME
theme_legend<- theme(
  legend.title = element_text(colour = "black", size = 12, face= "bold"),
  legend.text = element_text(colour = "black", size = 12),
  #legend.position = c(0.85, 0.80),
  legend.box.background =  element_rect(colour = "black"), legend.box.margin = margin(5,5,5,5))
