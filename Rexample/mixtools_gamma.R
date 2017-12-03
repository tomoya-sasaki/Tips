# http://kusanagi.hatenablog.jp/entry/2017/01/26/152922

# sample http://stats.stackexchange.com/questions/226834/sampling-from-a-mixture-of-two-gamma-distributions

# fit data to the mixture gamma distribution model 

library(mixtools)
set.seed(0)
dat <- c(rgamma(100, 4, 1), rgamma(300, 10, .2))
hist(dat, breaks =20, main = "", col = "lightblue")

model <- gammamixEM(dat)

dmixgamma <- function(x, lambda, a1, a2, b1, b2){
	y <- lambda * dgamma(x, a1, b1) + (1 - lambda) * dgamma(x, a2, b2)
	y
}

hist(dat, breaks =20, main = "", col = "lightblue", freq = F, ylim = c(0, .06), xlim = c(0, 100))
x <- seq(0, 100, .01)
# where does these parameters come from?
lines(x, dmixgamma(x, 0.25, 3.05, 11.54, 1/1.23, 1/4.37), lwd = 2, col = 2)
