require(ggplot2)
require(viridis)
require(tidyr)
require(ggthemes)
require(ggpubr)
require(ggnewscale)
require(agricolae)
library(car)

path = "C:/Users/Dave Mont/Desktop/Master_of_DataScience/TFM/Bat_data/IDW"

wmp_a = read.csv(paste0(path,"/Alto_Lindoso_3.5_wmp.csv"),sep = " ")[,c(1,3,4)]
wmp_b = read.csv(paste0(path,"/Bubal_3.5_wmp.csv"),sep = " ")[,c(1,3,4)]
wmp_c = read.csv(paste0(path,"/Canelles_3.5_wmp2.csv"),sep = " ")[,c(1,3,4)]
wmp_g = read.csv(paste0(path,"/Grado_3.5_wmp2.csv"),sep = " ")[,c(1,3,4)]

wmp_a$Reservoir = "Alto-Lindoso"
wmp_b$Reservoir = "Bubal"
wmp_c$Reservoir = "Canelles"
wmp_g$Reservoir = "Grado"

wmp = rbind(wmp_a,wmp_b,wmp_c,wmp_g)

names(wmp)[1] = c("Depth")

jpeg("C:/Users/Dave Mont/Desktop/Master_of_DataScience/TFM/Bat_data/IDW/Boxplot_IDW.jpg",
     width = 3500,height = 1500,res = 600)
ggplot(wmp,aes(x = Reservoir,y = Depth,color = Reservoir)) + geom_boxplot(outlier.size = 1) +
  theme_bw() + ylab("Depth (m)") +
  scale_color_tableau() + coord_flip() +
  theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),legend.position = "none")
dev.off()

jpeg("C:/Users/Dave Mont/Desktop/Master_of_DataScience/TFM/Bat_data/IDW/Violin_IDW.jpg",
     width = 3500,height = 1500,res = 600)
ggplot(wmp,aes(x = Reservoir,y = Depth,color = Reservoir,fill = Reservoir)) + geom_violin(draw_quantiles = .5,alpha = .5) +
  theme_bw() + ylab("Depth (m)") +
  scale_color_tableau() + scale_fill_tableau() + coord_flip() +
  theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),legend.position = "none")
dev.off()

jpeg("C:/Users/Dave Mont/Desktop/Master_of_DataScience/TFM/Bat_data/IDW/Histogram_IDW.jpg",
     width = 4000,height = 1500,res = 600)
ggplot(wmp, aes(x = Depth,fill = ..x..)) +
  geom_histogram(bins = 50) + facet_wrap(~Reservoir,nrow = 1) +
  theme_bw() + xlab("Depth (m)") + ylab("Frequency") +
  theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),legend.position = "none")+
  scale_fill_viridis()
dev.off()

