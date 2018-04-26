# from http://abrahamcow.hatenablog.com/entry/2015/10/25/020144?utm_medium=twitter&utm_source=twitterfeed
# 図をかくための R のコード
set.seed(1234)
x =rnorm(5,5,2)
dat <- data.frame(x=x,y0=rep(0,5),y1=dnorm(x,0,1),y2=dnorm(x,5,2))

library(ggplot2)
ggplot(dat)+
  geom_segment(aes(x=x,y=y1,xend=x,yend=0),colour="tomato",size=1.5) +
  geom_segment(aes(x=x,y=y2,xend=x,yend=0),colour="royalblue",size=1.5) +
  stat_function(fun = dnorm,colour="tomato",size=2) +
  stat_function(fun = dnorm, args = list(mean = 5, sd = 2),colour="royalblue",size=2) +
  geom_point(aes(x,y0),size=3) +
  xlim(-5,15) +
  labs(x="",y="") +
  NULL