require(Rcpp)
require(RcppArmadillo)
require(coda)

y <- c(62, 60, 63, 59, 
       63, 67, 71, 64, 65, 66, 
       68, 66, 71, 67, 68, 68, 
       56, 62, 60, 61, 63, 64, 63, 59)
g <- c(rep(1, 4), rep(2, 6), rep(3, 6), rep(4, 8))

sourceCpp("BDA_chapter11.cpp")

result <- list()
date()
for (i in 1:10) {
  result[[i]] <- as.mcmc(HierarchicalNormal(y = y, g = g, burnin = 1000, iter = 1000, thin = 10)$mcmc)
}
date()

mcmc.result <- mcmc.list(result)
gelman.diag(mcmc.result)
summary(mcmc.result)
plot(mcmc.result)