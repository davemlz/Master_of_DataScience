require(ggplot2)
require(viridis)
require(tidyr)
require(ggthemes)
require(ggpubr)
require(ggnewscale)
require(agricolae)
library(car)

###############################################
##### CARGAR DATOS Y ORGANIZAR DATOS

palette = c("#00AFBB", "#E7B800", "#FC4E07")

cm_a = read.csv("C:/Users/Dave Mont/Desktop/Master_of_DataScience/TFM/Results/water_mask/cm_alto_lindoso_n.csv")
cm_b = read.csv("C:/Users/Dave Mont/Desktop/Master_of_DataScience/TFM/Results/water_mask/cm_bubal_n.csv")
cm_c = read.csv("C:/Users/Dave Mont/Desktop/Master_of_DataScience/TFM/Results/water_mask/cm_canelles_n.csv")
cm_g = read.csv("C:/Users/Dave Mont/Desktop/Master_of_DataScience/TFM/Results/water_mask/cm_grado_n.csv")

cm_a$Reservoir = rep("Alto-Lindoso",nrow(cm_a))
cm_b$Reservoir = rep("Bubal",nrow(cm_b))
cm_c$Reservoir = rep("Canelles",nrow(cm_c))
cm_g$Reservoir = rep("Grado",nrow(cm_g))

cm = rbind(cm_a,cm_b,cm_c,cm_g)

cm$Figure = NA
cm$Figure[cm$GridType == "hex" & cm$Reservoir == "Alto-Lindoso"] = "a)"
cm$Figure[cm$GridType == "hex" & cm$Reservoir == "Bubal"] = "b)"
cm$Figure[cm$GridType == "hex" & cm$Reservoir == "Canelles"] = "c)"
cm$Figure[cm$GridType == "hex" & cm$Reservoir == "Grado"] = "d)"
cm$Figure[cm$GridType == "square" & cm$Reservoir == "Alto-Lindoso"] = "e)"
cm$Figure[cm$GridType == "square" & cm$Reservoir == "Bubal"] = "f)"
cm$Figure[cm$GridType == "square" & cm$Reservoir == "Canelles"] = "g)"
cm$Figure[cm$GridType == "square" & cm$Reservoir == "Grado"] = "h)"

cm$GridType = as.vector(cm$GridType)
cm$GridType[cm$GridType == "hex"] = "G = Hexagonal"
cm$GridType[cm$GridType == "square"] = "G = Squared"
# cm$GridType[cm$GridType == "hex"] = "Hexagonal"
# cm$GridType[cm$GridType == "square"] = "Squared"

cm$k = as.factor(cm$k)
cm$GridType = as.factor(cm$GridType)
#cm$SeedSpacing = as.factor(cm$SeedSpacing)

cm$TP = as.double(cm$TP)
cm$FP = as.double(cm$FP)
cm$FN = as.double(cm$FN)
cm$TN = as.double(cm$TN)

cm$MCC = ((cm$TP*cm$TN)-(cm$FP*cm$FN))/sqrt((cm$TP+cm$FP)*(cm$TP+cm$FN)*(cm$TN+cm$FP)*(cm$TN+cm$FN))
cm$F1 = 2*(cm$Precision*cm$Sensitivity)/(cm$Precision + cm$Sensitivity)

# cm = cm %>% gather("Metric","Value",MCC,F1,Sensitivity,Precision)
# cm$Value = cm$Value*100

###############################################
##### FUNCIONES

ggmcc = function(data){
  
  ggplot(data,aes(x = SeedSpacing,y = MCC,color = k,fill = k)) + 
    #geom_line() + geom_point(colour = "gray30",size = 2) + geom_point(size = 1) +
    #facet_grid(GridType ~ Reservoir) +
    facet_wrap(GridType ~ Reservoir,ncol = 2) +
    geom_text(aes(x = -Inf,y = -Inf,label = Figure),vjust = -1.5,hjust = -1,color = "black",size = 4) +
    scale_color_tableau() + scale_fill_tableau() +
    theme_bw() + xlab("Seed Spacing (px)") + ylab("MCC") +
    theme(panel.spacing = unit(1, "lines")) +
    stat_summary(fun.data = mean_se, geom = "ribbon", alpha = 0.1,size = 0) +
    stat_summary(fun.y = mean, geom = "line") +
    stat_summary(fun.y = mean, geom = "point",colour = "gray30",size = 2) +
    stat_summary(fun.y = mean, geom = "point",size = 1) +
    theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),legend.position = "top")
  
}

ggf1 = function(data){
  
  ggplot(data,aes(x = SeedSpacing,y = F1,color = k,fill = k)) + 
    #geom_line() + geom_point(colour = "gray30",size = 2) + geom_point(size = 1) +
    #facet_grid(GridType ~ Reservoir) +
    facet_wrap(GridType ~ Reservoir,ncol = 2) +
    geom_text(aes(x = -Inf,y = -Inf,label = Figure),vjust = -1.5,hjust = -1,color = "black",size = 4) +
    scale_color_tableau() + scale_fill_tableau() +
    theme_bw() + xlab("Seed Spacing (px)") + ylab("F1") +
    theme(panel.spacing = unit(1, "lines")) +
    stat_summary(fun.data = mean_se, geom = "ribbon", alpha = 0.1,size = 0) +
    stat_summary(fun.y = mean, geom = "line") +
    stat_summary(fun.y = mean, geom = "point",colour = "gray30",size = 2) +
    stat_summary(fun.y = mean, geom = "point",size = 1) +
    theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),legend.position = "top")
  
}

ggsensitivity = function(data){
  
  ggplot(data,aes(x = SeedSpacing,y = Sensitivity,color = k,fill = k)) + 
    #geom_line() + geom_point(colour = "gray30",size = 2) + geom_point(size = 1) +
    #facet_grid(GridType ~ Reservoir) +
    facet_wrap(GridType ~ Reservoir,ncol = 2) +
    geom_text(aes(x = -Inf,y = -Inf,label = Figure),vjust = -1.5,hjust = -1,color = "black",size = 4) +
    scale_color_tableau() + scale_fill_tableau() +
    theme_bw() + xlab("Seed Spacing (px)") + ylab("Sensitivity") +
    theme(panel.spacing = unit(1, "lines")) +
    stat_summary(fun.data = mean_se, geom = "ribbon", alpha = 0.1,size = 0) +
    stat_summary(fun.y = mean, geom = "line") +
    stat_summary(fun.y = mean, geom = "point",colour = "gray30",size = 2) +
    stat_summary(fun.y = mean, geom = "point",size = 1) +
    theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),legend.position = "top")
  
}

ggprecision = function(data){
  
  ggplot(data,aes(x = SeedSpacing,y = Precision,color = k,fill = k)) + 
    #geom_line() + geom_point(colour = "gray30",size = 2) + geom_point(size = 1) +
    #facet_grid(GridType ~ Reservoir) +
    facet_wrap(GridType ~ Reservoir,ncol = 2) +
    geom_text(aes(x = -Inf,y = -Inf,label = Figure),vjust = -1.5,hjust = -1,color = "black",size = 4) +
    scale_color_tableau() + scale_fill_tableau() +
    theme_bw() + xlab("Seed Spacing (px)") + ylab("Precision") +
    theme(panel.spacing = unit(1, "lines")) +
    stat_summary(fun.data = mean_se, geom = "ribbon", alpha = 0.1,size = 0) +
    stat_summary(fun.y = mean, geom = "line") +
    stat_summary(fun.y = mean, geom = "point",colour = "gray30",size = 2) +
    stat_summary(fun.y = mean, geom = "point",size = 1) +
    theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),legend.position = "top")
  
}

ggtime = function(data){
  
  ggplot(data,aes(x = SeedSpacing,y = Time,color = k,fill = k)) + 
    #geom_line() + geom_point(colour = "gray30",size = 2) + geom_point(size = 1) +
    #facet_grid(GridType ~ Reservoir) +
    facet_wrap(GridType ~ Reservoir,ncol = 2) +
    geom_text(aes(x = -Inf,y = Inf,label = Figure),vjust = 2,hjust = -1,color = "black",size = 4) +
    scale_color_tableau() + scale_fill_tableau() +
    theme_bw() + xlab("Seed Spacing (px)") + ylab("Time (s)") +
    theme(panel.spacing = unit(1, "lines")) +
    stat_summary(fun.data = mean_se, geom = "ribbon", alpha = 0.1,size = 0) +
    stat_summary(fun.y = mean, geom = "line") +
    stat_summary(fun.y = mean, geom = "point",colour = "gray30",size = 2) +
    stat_summary(fun.y = mean, geom = "point",size = 1) +
    theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),legend.position = "top")
  
}

###############################################
##### IMAGENES DE VALIDACION

jpeg("C:/Users/Dave Mont/Desktop/Master_of_DataScience/TFM/Results/water_mask/SCORE_MCC.jpg",
     width = 4000,height = 5500,res = 600)
ggmcc(cm)
dev.off()

jpeg("C:/Users/Dave Mont/Desktop/Master_of_DataScience/TFM/Results/water_mask/SCORE_F1.jpg",
     width = 4000,height = 5500,res = 600)
ggf1(cm)
dev.off()

jpeg("C:/Users/Dave Mont/Desktop/Master_of_DataScience/TFM/Results/water_mask/SCORE_Sensitivity.jpg",
     width = 4000,height = 5500,res = 600)
ggsensitivity(cm)
dev.off()

jpeg("C:/Users/Dave Mont/Desktop/Master_of_DataScience/TFM/Results/water_mask/SCORE_Precision.jpg",
     width = 4000,height = 5500,res = 600)
ggprecision(cm)
dev.off()

jpeg("C:/Users/Dave Mont/Desktop/Master_of_DataScience/TFM/Results/water_mask/SCORE_Time.jpg",
     width = 4000,height = 5500,res = 600)
ggtime(cm)
dev.off()

###############################################
##### ANALISIS DE VARIANZA

cm$GridType = as.factor(cm$GridType)
cm$k = as.factor(cm$k)
cm$SeedSpacing = as.factor(cm$SeedSpacing)
cm$TrainingPrSuperpixels = as.factor(cm$TrainingPrSuperpixels)
cm$Reservoir = as.factor(cm$Reservoir)

###############################################
##### ANALISIS DE VARIANZA Y LSD PARA MCC

fit = aov(MCC ~ GridType*k*SeedSpacing*TrainingPrSuperpixels,cm)
summary(fit)

leveneTest(MCC ~ GridType*k*SeedSpacing*TrainingPrSuperpixels,cm)

LSD_G = LSD.test(fit,c("GridType"))
LSD_K = LSD.test(fit,c("k"))
LSD_S = LSD.test(fit,c("SeedSpacing"))

plot(LSD_G,variation = "SE")
plot(LSD_K,variation = "SE")
plot(LSD_S,variation = "SE")

LSD_Groups_G = cbind(LSD_G$means[,c("MCC","std","r")],LSD_G$groups[match(row.names(LSD_G$groups),row.names(LSD_G$means)),"groups"])
LSD_Groups_K = cbind(LSD_K$means[,c("MCC","std","r")],LSD_K$groups[match(row.names(LSD_K$groups),row.names(LSD_K$means)),"groups"])
LSD_Groups_S = cbind(LSD_S$means[,c("MCC","std","r")],LSD_S$groups[match(row.names(LSD_S$groups),row.names(LSD_S$means)),"groups"])

LSD_Groups_G = cbind(LSD_Groups_G,row.names(LSD_Groups_G),rep("Grid Type",2))
LSD_Groups_K = cbind(LSD_Groups_K,row.names(LSD_Groups_K),rep("k",3))
LSD_Groups_S = cbind(LSD_Groups_S,row.names(LSD_Groups_S),rep("Seed Spacing",4))

LSD_Groups_G = LSD_Groups_G[order(LSD_Groups_G$MCC,decreasing = TRUE),]
LSD_Groups_K = LSD_Groups_K[order(LSD_Groups_K$MCC,decreasing = TRUE),]
LSD_Groups_S = LSD_Groups_S[order(LSD_Groups_S$MCC,decreasing = TRUE),]

names(LSD_Groups_G)[4:6] = c("Group","Level","Factor")
names(LSD_Groups_K)[4:6] = c("Group","Level","Factor")
names(LSD_Groups_S)[4:6] = c("Group","Level","Factor")

LSD_Groups = rbind(LSD_Groups_G,LSD_Groups_K,LSD_Groups_S)

LSD_Groups$Figure = NA

LSD_Groups$Figure[LSD_Groups$Factor == "Grid Type"] = "a)"
LSD_Groups$Figure[LSD_Groups$Factor == "k"] = "b)"
LSD_Groups$Figure[LSD_Groups$Factor == "Seed Spacing"] = "c)"

jpeg("C:/Users/Dave Mont/Desktop/Master_of_DataScience/TFM/Results/water_mask/MCC_LSD.jpg",
     width = 4000,height = 3000,res = 600)
ggplot(LSD_Groups,aes(x = reorder(Level,MCC),y = MCC,color = Group)) + geom_point() +
  facet_grid(row = vars(Factor),scales = "free_y") +
  geom_text(aes(x = Inf,y = -Inf,label = Figure),vjust = 2,hjust = -1,color = "black",size = 4) +
  geom_text(aes(label = Group,y = MCC + std/sqrt(r) + .0025),color = "black",size = 3) +
  geom_errorbar(aes(ymin = MCC - std/sqrt(r),ymax = MCC + std/sqrt(r)),width = 0.2) +
  scale_color_tableau() +
  coord_flip() + theme_bw() +
  xlab("Level") +
  theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),legend.position = "none")
dev.off()

###############################################
##### ANALISIS DE VARIANZA Y LSD PARA F1

fit = aov(F1 ~ GridType*k*SeedSpacing*TrainingPrSuperpixels,cm)
summary(fit)

leveneTest(F1 ~ GridType*k*SeedSpacing*TrainingPrSuperpixels,cm)

LSD_G = LSD.test(fit,c("GridType"))
LSD_K = LSD.test(fit,c("k"))
LSD_S = LSD.test(fit,c("SeedSpacing"))

plot(LSD_G,variation = "SE")
plot(LSD_K,variation = "SE")
plot(LSD_S,variation = "SE")

LSD_Groups_G = cbind(LSD_G$means[,c("F1","std","r")],LSD_G$groups[match(row.names(LSD_G$groups),row.names(LSD_G$means)),"groups"])
LSD_Groups_K = cbind(LSD_K$means[,c("F1","std","r")],LSD_K$groups[match(row.names(LSD_K$groups),row.names(LSD_K$means)),"groups"])
LSD_Groups_S = cbind(LSD_S$means[,c("F1","std","r")],LSD_S$groups[match(row.names(LSD_S$groups),row.names(LSD_S$means)),"groups"])

LSD_Groups_G = cbind(LSD_Groups_G,row.names(LSD_Groups_G),rep("Grid Type",2))
LSD_Groups_K = cbind(LSD_Groups_K,row.names(LSD_Groups_K),rep("k",3))
LSD_Groups_S = cbind(LSD_Groups_S,row.names(LSD_Groups_S),rep("Seed Spacing",4))

LSD_Groups_G = LSD_Groups_G[order(LSD_Groups_G$F1,decreasing = TRUE),]
LSD_Groups_K = LSD_Groups_K[order(LSD_Groups_K$F1,decreasing = TRUE),]
LSD_Groups_S = LSD_Groups_S[order(LSD_Groups_S$F1,decreasing = TRUE),]

names(LSD_Groups_G)[4:6] = c("Group","Level","Factor")
names(LSD_Groups_K)[4:6] = c("Group","Level","Factor")
names(LSD_Groups_S)[4:6] = c("Group","Level","Factor")

LSD_Groups = rbind(LSD_Groups_G,LSD_Groups_K,LSD_Groups_S)

LSD_Groups$Figure = NA

LSD_Groups$Figure[LSD_Groups$Factor == "Grid Type"] = "a)"
LSD_Groups$Figure[LSD_Groups$Factor == "k"] = "b)"
LSD_Groups$Figure[LSD_Groups$Factor == "Seed Spacing"] = "c)"

jpeg("C:/Users/Dave Mont/Desktop/Master_of_DataScience/TFM/Results/water_mask/F1_LSD.jpg",
     width = 4000,height = 3000,res = 600)
ggplot(LSD_Groups,aes(x = reorder(Level,F1),y = F1,color = Group)) + geom_point() +
  facet_grid(row = vars(Factor),scales = "free_y") +
  geom_text(aes(x = Inf,y = -Inf,label = Figure),vjust = 2,hjust = -1,color = "black",size = 4) +
  geom_text(aes(label = Group,y = F1 + std/sqrt(r) + .0025),color = "black",size = 3) +
  geom_errorbar(aes(ymin = F1 - std/sqrt(r),ymax = F1 + std/sqrt(r)),width = 0.2) +
  scale_color_tableau() +
  coord_flip() + theme_bw() +
  xlab("Level") +
  theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),legend.position = "none")
dev.off()

###############################################
##### ANALISIS DE VARIANZA Y LSD PARA PRECISION

fit = aov(Precision ~ GridType*k*SeedSpacing*TrainingPrSuperpixels,cm)
summary(fit)

leveneTest(Precision ~ GridType*k*SeedSpacing*TrainingPrSuperpixels,cm)

LSD_K = LSD.test(fit,c("k"))
LSD_S = LSD.test(fit,c("SeedSpacing"))

plot(LSD_K,variation = "SE")
plot(LSD_S,variation = "SE")

LSD_Groups_K = cbind(LSD_K$means[,c("Precision","std","r")],LSD_K$groups[match(row.names(LSD_K$means),row.names(LSD_K$groups)),"groups"])
LSD_Groups_S = cbind(LSD_S$means[,c("Precision","std","r")],LSD_S$groups[match(row.names(LSD_S$means),row.names(LSD_S$groups)),"groups"])

LSD_Groups_K = cbind(LSD_Groups_K,row.names(LSD_Groups_K),rep("k",3))
LSD_Groups_S = cbind(LSD_Groups_S,row.names(LSD_Groups_S),rep("Seed Spacing",4))

LSD_Groups_K = LSD_Groups_K[order(LSD_Groups_K$Precision,decreasing = TRUE),]
LSD_Groups_S = LSD_Groups_S[order(LSD_Groups_S$Precision,decreasing = TRUE),]

names(LSD_Groups_K)[4:6] = c("Group","Level","Factor")
names(LSD_Groups_S)[4:6] = c("Group","Level","Factor")

LSD_Groups = rbind(LSD_Groups_K,LSD_Groups_S)

LSD_Groups$Figure = NA

LSD_Groups$Figure[LSD_Groups$Factor == "k"] = "a)"
LSD_Groups$Figure[LSD_Groups$Factor == "Seed Spacing"] = "b)"

jpeg("C:/Users/Dave Mont/Desktop/Master_of_DataScience/TFM/Results/water_mask/Precision_LSD.jpg",
     width = 4000,height = 2000,res = 600)
ggplot(LSD_Groups,aes(x = reorder(Level,Precision),y = Precision,color = Group)) + geom_point() +
  facet_grid(row = vars(Factor),scales = "free_y") +
  geom_text(aes(x = Inf,y = -Inf,label = Figure),vjust = 2,hjust = -1,color = "black",size = 4) +
  geom_text(aes(label = Group,y = Precision + std/sqrt(r) + .0025),color = "black",size = 3) +
  geom_errorbar(aes(ymin = Precision - std/sqrt(r),ymax = Precision + std/sqrt(r)),width = 0.2) +
  scale_color_tableau() +
  coord_flip() + theme_bw() +
  xlab("Level") +
  theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),legend.position = "none")
dev.off()

###############################################
##### ANALISIS DE VARIANZA Y LSD PARA TIME

fit = aov(Time ~ GridType*k*SeedSpacing*TrainingPrSuperpixels,cm)
summary(fit)

leveneTest(Time ~ GridType*k*SeedSpacing*TrainingPrSuperpixels,cm)

LSD_K = LSD.test(fit,c("k"))
LSD_S = LSD.test(fit,c("SeedSpacing"))
LSD_T = LSD.test(fit,c("TrainingPrSuperpixels"))

plot(LSD_K,variation = "SE")
plot(LSD_S,variation = "SE")
plot(LSD_T,variation = "SE")

LSD_Groups_K = cbind(LSD_K$means[,c("Time","std","r")],LSD_K$groups[match(row.names(LSD_K$groups),row.names(LSD_K$means)),"groups"])
LSD_Groups_S = cbind(LSD_S$means[,c("Time","std","r")],LSD_S$groups[match(row.names(LSD_S$means),row.names(LSD_S$groups)),"groups"])
LSD_Groups_T = cbind(LSD_T$means[,c("Time","std","r")],LSD_T$groups[match(row.names(LSD_T$means),row.names(LSD_T$groups)),"groups"])

LSD_Groups_K = cbind(LSD_Groups_K,row.names(LSD_Groups_K),rep("k",3))
LSD_Groups_S = cbind(LSD_Groups_S,row.names(LSD_Groups_S),rep("Seed Spacing",4))
LSD_Groups_T = cbind(LSD_Groups_T,row.names(LSD_Groups_T),rep("Training Size",7))

LSD_Groups_K = LSD_Groups_K[order(LSD_Groups_K$Time,decreasing = TRUE),]
LSD_Groups_S = LSD_Groups_S[order(LSD_Groups_S$Time,decreasing = TRUE),]
LSD_Groups_T = LSD_Groups_T[order(LSD_Groups_T$Time,decreasing = TRUE),]

names(LSD_Groups_K)[4:6] = c("Group","Level","Factor")
names(LSD_Groups_S)[4:6] = c("Group","Level","Factor")
names(LSD_Groups_T)[4:6] = c("Group","Level","Factor")

LSD_Groups_T$Level = c("0.75r","0.5r","0.9r","r","1.5r","0.8r","2r")

LSD_Groups = rbind(LSD_Groups_K,LSD_Groups_S,LSD_Groups_T)

LSD_Groups$Figure = NA

LSD_Groups$Figure[LSD_Groups$Factor == "k"] = "a)"
LSD_Groups$Figure[LSD_Groups$Factor == "Seed Spacing"] = "b)"
LSD_Groups$Figure[LSD_Groups$Factor == "Training Size"] = "c)"

jpeg("C:/Users/Dave Mont/Desktop/Master_of_DataScience/TFM/Results/water_mask/Time_LSD.jpg",
     width = 4000,height = 3000,res = 600)
ggplot(LSD_Groups,aes(x = reorder(Level,Time),y = Time,color = Group)) + geom_point() +
  facet_grid(row = vars(Factor),scales = "free_y") +
  geom_text(aes(x = Inf,y = -Inf,label = Figure),vjust = 2,hjust = -1,color = "black",size = 4) +
  geom_text(aes(label = Group,y = Time + std/sqrt(r) + .5),color = "black",size = 3) +
  geom_errorbar(aes(ymin = Time - std/sqrt(r),ymax = Time + std/sqrt(r)),width = 0.2) +
  scale_color_tableau() +
  coord_flip() + theme_bw() +
  xlab("Level") + ylab("Time (s)") +
  theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),legend.position = "none")
dev.off()

###############################################
##### ORGANIZAR DATOS PARA MATRIZ DE CONFUSION

# data = data %>% mutate(goodbad = ifelse(data$Prediction == data$True,"good", "bad")) %>% 
#   mutate(prop = CM_value/TotalPixels) %>% mutate(proplabel = paste0(round(prop*100,2),"%"))

cm_ = cm

G = cm$GridType == "G = Squared"
S = cm$SeedSpacing == 10
K = cm$k == 4
t = cm$TrainingPrSuperpixels == 2

cm = cm[G & S & K & t,]

cm$Max = apply(cm[,c("TP","FP","FN","TN")], 1, FUN = max)

cm = cm %>% gather("CM","CM_value",TP,FP,FN,TN)

cm$CM[cm$CM == "TP"] = "1 1"
cm$CM[cm$CM == "FP"] = "0 1"
cm$CM[cm$CM == "FN"] = "1 0"
cm$CM[cm$CM == "TN"] = "0 0"

cm = cm %>% separate(CM,c("True","Prediction")," ")

cm$Prediction = as.factor(cm$Prediction)
cm$True = as.factor(cm$True)

cm$MCClabel = paste("MCC =",round(cm$MCC,3))
cm$prop = cm$CM_value/cm$TotalPixels
cm$proplabel = paste0(round(cm$prop*100,2),"%")
cm$propfill = cm$CM_value/cm$Max

jpeg("C:/Users/Dave Mont/Desktop/Master_of_DataScience/TFM/Results/water_mask/CM.jpg",
     width = 3000,height = 3000,res = 600)
ggplot(cm,aes(x = True,y = Prediction)) +
  geom_tile(aes(fill = propfill), colour = "white",alpha = .6) +
  geom_label(aes(x = Inf,y = Inf,label = MCClabel),vjust = 1.6,hjust = 1.6,color = "black") +
  geom_text(aes(label = CM_value),alpha = 1) +
  geom_text(aes(label = proplabel), vjust = 3,alpha = 1,size = 3) + 
  theme_bw() +
  facet_wrap(~ Reservoir,ncol = 2) +
  scale_fill_viridis(option = "cividis",direction = -1) +
  xlim(rev(levels(cm$True))) +
  theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),legend.position = "none") +
  xlab(expression(WM[t])) + ylab(expression(WM[p]))
dev.off()