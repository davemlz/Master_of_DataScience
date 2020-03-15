require(C50)
require(caret)
require(rpart)

# DATASET
tennis = read.csv("C:/Users/Dave Mont/Desktop/Data Mining/tennis.txt")

# FORMULA
f = play ~ .

# TRAIN CONTROL
ctrl = trainControl(method = "LOOCV")

# MODEL
modC50 = train(f,data = tennis,method = "C5.0",trControl = ctrl)
modrpart = train(f,data = tennis,method = "rpart",trControl = ctrl,maxdepth = 2)

cars$Price = as.factor(ifelse(cars$Price >= 22000,"E","C"))

predict()


