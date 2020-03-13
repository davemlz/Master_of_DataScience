## Defining the states of the variables:
variables.Names <- c("Outlook","Temperature","Humidity","Windy","Play Golf")
sample.Number <- c(1:14)
estados.O <- c("Rainy", "Overcast", "Sunny")
estados.T <- c("Hot", "Mild", "Cool")
estados.H <- c("Normal", "High")
estados.W <- c("True", "False")
estados.G <- c("Yes", "No")
Nclass <- c(3, 3, 2, 2, 2)

## Defining the table:
variables.Names <- c("Outlook","Temperature","Humidity","Windy","Play Golf")
sample.Number <- c(1:14)
data.table <- array(c("Rainy", "Rainy", "Overcast", "Sunny", "Sunny", "Sunny", "Overcast", "Rainy", "Rainy",
                      "Sunny", "Rainy", "Overcast", "Overcast", "Sunny",
                      "Hot", "Hot", "Hot", "Mild", "Cool", "Cool", "Cool", "Mild", "Cool", "Mild", "Mild", "Mild", "Hot", "Mild",
                      "High", "High", "High", "High", "Normal", "Normal", "Normal", "High", "Normal", "Normal", "Normal", "High",
                      "Normal", "High",
                      "False", "True", "False", "False", "False", "True", "True", "False", "False", "False", "True", "True", "False", "True",
                      "No", "No", "Yes", "Yes", "Yes", "No", "Yes", "No", "Yes", "Yes", "Yes", "Yes", "Yes", "No"), dim = c(14,5),
                    dimnames = list(event = sample.Number, variable = variables.Names))


## Defining the Graph:
dag <- empty.graph(nodes = c("O","T","H","W","G"))
dag <- set.arc(dag, from = "G", to = "O")
dag <- set.arc(dag, from = "G", to = "T")
dag <- set.arc(dag, from = "G", to = "H")
dag <- set.arc(dag, from = "G", to = "W")
modelstring(dag)

plot(dag)

## Defining the probabilities:
G.prob <- array(c(length(which(data.table[,"Play Golf"] == "Yes")), length(which(data.table[,"Play Golf"] ==
                                                                                   "No")))/length(data.table[,"Play Golf"]), dim = 2, dimnames = list(G = estados.G))
O.prob <- array(data = 0, dim = c(Nclass[1],Nclass[5]), dimnames = list(O = estados.O, G = estados.G))
T.prob <- array(data = 0, dim = c(Nclass[2],Nclass[5]), dimnames = list(T = estados.T, G = estados.G))
H.prob <- array(data = 0, dim = c(Nclass[3],Nclass[5]), dimnames = list(H = estados.H, G = estados.G))
W.prob <- array(data = 0, dim = c(Nclass[4],Nclass[5]), dimnames = list(W = estados.W, G = estados.G))
for (g in 1:Nclass[5]){
  for (o in 1:Nclass[1]){
    O.prob[o,g] <- length(which(data.table[,"Play Golf"] == estados.G[g] & data.table[,"Outlook"] ==
                                  estados.O[o]))/length(which(data.table[,"Play Golf"] == estados.G[g]))
  }
}

for (g in 1:Nclass[5]){
  for (o in 1:Nclass[2]){
    T.prob[o,g] <- length(which(data.table[,"Play Golf"] == estados.G[g] & data.table[,"Temperature"] ==
                                  estados.O[o]))/length(which(data.table[,"Play Golf"] == estados.G[g]))
  }
}

for (g in 1:Nclass[5]){
  for (o in 1:Nclass[3]){
    H.prob[o,g] <- length(which(data.table[,"Play Golf"] == estados.G[g] & data.table[,"Humidity"] ==
                                  estados.O[o]))/length(which(data.table[,"Play Golf"] == estados.G[g]))
  }
}

for (g in 1:Nclass[5]){
  for (o in 1:Nclass[4]){
    W.prob[o,g] <- length(which(data.table[,"Play Golf"] == estados.G[g] & data.table[,"Windy"] ==
                                  estados.O[o]))/length(which(data.table[,"Play Golf"] == estados.G[g]))
  }
}

## Defining the Bayesian Network:
cpt <- list(G = G.prob, O = O.prob, T = T.prob, H = H.prob, W = W.prob)
bn <- custom.fit(dag, cpt)
str(bn)

junction <- compile(as.grain(bn))

## Exact inference:
jsex <- setEvidence(junction, nodes = c("O","T","H","W"), states = c("Overcast","Cool","Normal","True"))
querygrain(jsex, nodes = "G")$G

set.seed(1)
cpquery(bn,event=(G=="Yes"),
        evidence=((O=="Overcast") & (T=="Cool") & (H=="Normal") & (W=="True")))

require(e1071)

the_data = as.data.frame(data.table)

naiveBayes(PlayGolf ~ .)