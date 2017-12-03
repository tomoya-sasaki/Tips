rm(list=ls())
library(sandwich)

# number of units
n <- 50
# generate data
y <- rbinom(n, 5, .6)
t <- rbinom(n, 1, .7)
x0 <- rep(1,n)
x1 <- rnorm(n, -1, .5)
x2 <- rnorm(n, 2, 1)

# generate data 2
t <- rbinom(n, 1, .7)
x0 <- rep(1,n)
x1 <- rnorm(n, -1, .5)
x2 <- rnorm(n, 2, 1)

# "true" value of betas
betat <- 3
beta0 <- 2
beta1 <- 1
beta2 <- -2
betas <- c(beta0, beta1, beta2, betat)
epsilon <- rnorm(n, 0, 1)

y <- beta0 * x0 + beta1 * x1 + beta2 * x2 + betat * t + epsilon

# create dataframe
data <- data.frame(y,x0,x1,x2,t)

# extract covariates
X <- as.matrix(data[,c(2:length(data))])

# calculate beta
beta.hat <- solve(t(X) %*% X) %*% t(X) %*% y # you may compare with betas
sprintf("x0:%d, x1:%d, x2:%d, t:%d", beta0, beta1, beta2, betat)

beta.true <- as.matrix(c(beta0, beta1, beta2, betat), nrow = 4, ncol = 1)
rownames(beta.true) <- c("x0", "x1", "x2", "t")

# compare with the true values
beta.true
beta.hat

# predicted value 
y.hat <- X %*% beta.hat

# residual
epsilon.hat <- y - y.hat

# number of the Xs
k <- length(data) - 1
# usual variance 
variance <- ( sum ((epsilon.hat) **2  / (n - k) ) ) * solve(t(X) %*% X)

# create standard error
se <- sqrt(diag(variance))
upper <- beta.hat + 1.96 * se
lower <- beta.hat - 1.96 * se
ci <- cbind(upper,lower)
colnames(ci) <- c("upper", "lower")


# compare true value and the result from hand
ci.df <- data.frame(ci)
beta.hat.df <- data.frame(beta.hat)
coef <- c("x0", "x1", "x2", "t")
coef.df <- data.frame(coef)
beta.true.df <- data.frame(beta.true)
plot.df <- bind_cols(ci.df, beta.hat.df, coef.df, beta.true.df) 

plot <- ggplot(plot.df, aes(x=coef, y= beta.true)) + geom_point(size=2, color = "red" ) + geom_errorbar(aes(ymax=upper, ymin=lower), width = 0, size = .8 ) + scale_y_continuous(breaks=seq(-3,4, 1))




# robust standard error
bread <- solve(t(X) %*% X)
# create matrix diagonal matrix with epsilon.hat %*% t(epsilon.hat) as each component
inmeat <- diag(diag(epsilon.hat %*% t(epsilon.hat) ) )
meat <- t(X) %*% inmeat %*% X

# variance matrix
variance.robust <- bread %*% meat %*% bread
se <- sqrt(diag(variance))

# robust standard error: "HC0" type in package 'sandwich'
se.robust <- sqrt(diag(variance.robust))
upper.robust <- beta.hat + 1.96 * se.robust
lower.robust <- beta.hat - 1.96 * se.robust
cbind(upper.robust,lower.robust)

# robust standard error: "HC3" type in package 'sandwich'
# you need hat matrix first
hat.matrix <- X %*% solve( t(X) %*% X ) %*% t(X)
diag.hat <- diag(hat.matrix) # vector of n elements

# meat with different
# create a diagonal matrix with epsilon.hat %*% t(epsilon.hat) as each component
inmeat.hc3 <- diag(diag(epsilon.hat %*% t(epsilon.hat) / (1 - diag.hat)**2 ))
meat.hc3 <- t(X) %*% inmeat.hc3 %*% X
variance.robust.hc3 <- bread %*% meat.hc3 %*% bread
se.robust.hc3 <- sqrt(diag(variance.robust.hc3))
upper.robust.hc3 <- beta.hat + 1.96 * se.robust.hc3
lower.robust.hc3 <- beta.hat - 1.96 * se.robust.hc3
cbind(upper.robust.hc3,lower.robust.hc3)


# compare with package
model <- lm(y ~ x1 + x2 + t, data)

# betas
# by hands
beta.hat
# by model
coef(model)

# variance-covariance matrix
# by hands
variance
# by packages
vcov(model)

# compare with the result of package2 robust standard errors
vcovHC(model, "HC0") 
vcovHC(model, "HC3") 



# the other way round
# first decide the beta.true and calculate y