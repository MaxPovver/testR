library(dplyr)

#для отладки грузим eurusd
eurusd <- read.csv("C:\\Users\\maxpo\\Desktop\\EURUSDb5.csv")
#грузим готовые данные
data <- read.csv("C:\\Users\\maxpo\\Desktop\\data.csv")
expected <- read.csv("C:\\Users\\maxpo\\Desktop\\expected.csv")
expected <- expected[, 2]
together <- cbind(data, expected)
View(together)


sub <- sample(nrow(together), floor(nrow(together) * 0.7))
training <- together[sub,]
testing <- together[ - sub,]

install.packages('neuralnet')
library("neuralnet")

nn <- neuralnet(expected ~ Open1 + High1 + Low1 + Close1 + Volume1 
    + Open2 + High2 + Low2 + Close2 + Volume2
    + Open3 + High3 + Low3 + Close3 + Volume3 
    + Open4 + High4 + Low4 + Close4 + Volume4 
    +Open5 + High5 + Low5 + Close5 + Volume5, training, 10
)
ans1 <- compute(nn, testing)
View(ans1)

print("Done")