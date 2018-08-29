## from http://ryotamugiyama.com/2018/03/08/scatter/

#以下のパッケージを使用する。入っていない場合はインストール。
#install.packages(tidyverse)

library(tidyverse)

#関数の定義
r2norm <- function(n, mu, sigma, rho) {
  tmp <- rnorm(n) 
  x   <- mu+sigma*tmp
  y   <- rho*x + sqrt(1-rho^2)*rnorm(n)
  return(data.frame(x=x,y=y))
}

#-1から1まで0.1ずつ増加するベクトルを生成
time <- seq(-1, 1, length=21)

#サンプルサイズを指定
size <- 5000

#データセットの作成
cordata <- data.frame()

set.seed(1234567)
for (i in time){
  cor <- i
  cordata_mini <- r2norm(size, 0, 1, i)
  cordata_mini$cor <- cor
  cordata <- rbind(cordata, cordata_mini)
}

# 相関係数-0.9から1までの散布図
cordata1 <- subset(cordata, cor > -1)
p1 <- ggplot(cordata1, aes(x = x, y = y)) + 
  geom_point() + 
  facet_wrap(~cor) + 
  xlim(-4,4) + 
  ylim(-4,4)
p1

# 相関係数+-0.9, +-0.7, +-0.5, +-0.3, +-0.1, 0の散布図
cordata$cor <- round(cordata$cor, digits = 1)
cordata2 <- subset(cordata, abs(cor) == 0.9 | abs(cor) == 0.7 | abs(cor) == 0.5 | abs(cor) == 0.3 | abs(cor) == 0)
p2 <- ggplot(cordata2, aes(x = x, y = y)) + 
  geom_point() + 
  facet_wrap(~cor) + 
  xlim(-4,4) + 
  ylim(-4,4)
p2