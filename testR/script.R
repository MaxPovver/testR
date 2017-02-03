library(dplyr)

#грузим свечки
eurusd <- read.csv("C:\\Users\\maxpo\\Desktop\\EURUSDb5.csv")

#пихаем в дирекшн направление свечи
eurusd$Direction <- ifelse(eurusd$Close > eurusd$Open, 1, ifelse(eurusd$Close < eurusd$Open, 0, 0.5)) # Zero when Open = Close

#пихаем в Next направление следующей свечи
eurusd <- mutate(eurusd, Next = lead(Direction))



# вытаскиваем максимумы и минимумы для номрализации 
#maxs <- apply(eurusd[,2:6], 2, max)
#mins <- apply(eurusd[,2:6], 2, min)

# нормализуем значения Open High Low CLose
#eurusd[,2:6] <- as.data.frame(scale(eurusd[,2:6], center = mins, scale = maxs - mins))
#Тк пара EURUSD исторически держится в диапозоне 0-2, можем просто поделить на 2 все кроме Volume 
eurusd$Open <- eurusd$Open / 2
eurusd$High <- eurusd$High / 2
eurusd$Low <- eurusd$Low / 2
eurusd$Close <- eurusd$Close / 2
eurusd$Volume <- eurusd$Volume / 1000 # это вообще наугад, максимум по имеющимся данным - 712

# Вывод для проверки
View(eurusd, "Нормализованные данные(0...1)")

# итак, исходные данные в нужном формате, теперь надо сформировать их для обучения(на каждом шаге сеть смотрит на предлыдущие 5 свечей)
row <- function(data, offset) {
    return <- c(data[offset, 2:7], data[offset + 1, 2:7], data[offset + 2, 2:7], data[offset + 3, 2:7], data[offset + 4, 2:7]);
}
expected <- function(data, offset) {
    return <- data[offset, 8]
}

total <- nrow(eurusd) - 1

data <- data.frame(Open = numeric(total), High = numeric(total), Low(total) = numeric(total), Close(total) = numeric(total), Volume(total) = numeric(total), stringsAsFactors = FALSE)
for (i in 1:total)
    data[i]$Open = eurusd[i]$Open
    data[i]$High = eurusd[i]$High
    data[i]$Low = eurusd[i]$Low
    data[i]$Close = eurusd[i]$Close
    data[i]$Volume = eurusd[i]$Volume



install.packages('neuralnet')
library("neuralnet")