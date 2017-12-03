# force not to use exponential 
options(scipen = 5)

##想定クリック数1000回、クリック率1%の時の二項分布。
d <- as.data.frame(dbinom(x = 0:30, size = 1000, prob = 0.01))
d$x <- 0:30
colnames(d) <- c("y","x")
ggplot(data = d, aes(x = factor(x), y = y))+ geom_bar(stat = "identity")

##平均λ=1.43のポアソン分布。7時間で10cvの場合。
d2 <- as.data.frame(dpois(x = 0:10, lambda = 1.428))
d2$x <- 0:10
colnames(d2) <- c("y","x")
ggplot(data = d2, aes(x = factor(x), y = y))+ geom_bar(stat = "identity")