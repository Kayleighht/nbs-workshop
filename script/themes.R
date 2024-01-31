# Theme Creation ----------------------------------------------------------

alltheme <- theme(
  panel.border = element_blank(), panel.grid.major = element_blank(),
  panel.background = element_rect(fill = "white", color = NA),
  plot.background = element_rect(fill = "white", color = NA),
  panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"),
  text = element_text(family = "serif"),
  axis.title.y = element_text(colour = "black",face = "bold", size = '20', vjust = +1),
  axis.title.x = element_text(colour = "black", face = "bold", size= '20', vjust= 0),
  axis.ticks = element_line(size = 0.7),
  axis.text = element_text(size = 15, colour = "black")
)
