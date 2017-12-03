# http://people.stat.sc.edu/Hitchcock/Rexamples511chap4.txt


###### R code for calculating probabilities 

### Normal probabilities

## Example 1:  Z ~ N(0,1)

# What is P(Z > 1.83)?

pnorm(1.83, mean=0, sd = 1, lower=F)

# What is P(Z < -0.42)?

pnorm(-0.42, mean=0, sd = 1, lower=T)

# What is P(Z <= 1.19)?

pnorm(1.19, mean=0, sd = 1, lower=T)

# What is P(-1.26 < Z <= 0.35)?

pnorm(0.35, mean=0, sd = 1, lower=T) - pnorm(-1.26, mean=0, sd = 1, lower=T)

## Example 2:  Y ~ N(2.70, 0.16)

# So sigma = sqrt(0.16) = 0.4.

# What is P(Y > 2.50)?

pnorm(2.50, mean=2.70, sd=0.4, lower=F)

# What is P(3.00 < Y < 3.50)?

pnorm(3.50, mean=2.70, sd=0.4, lower=T) - pnorm(3.00, mean=2.70, sd=0.4, lower=T)

# Exactly .05 probability is above what value in this distribution?

qnorm(0.05, mean=2.70, sd=0.4, lower=F)

## Plot of this normal pdf:

# Y ~ N(2.70, 0.16):

plot(seq(1,4,by=0.01), dnorm(seq(1,4,by=0.01), mean=2.70, sd=0.4), type='l', lwd=2, xlab='y', ylab='f(y)')

#########################################################################

### Gamma probabilities

## Example 1: Y ~ Gamma(5,3):

# What is P(1.584 < Y < 28.416)?

pgamma(28.416, shape=5, scale=3) - pgamma(1.584, shape=5, scale=3)

## Plot of this gamma pdf:

# Y ~ Gamma(5,3):

plot(seq(0,50,by=0.01), dgamma(seq(0,50,by=0.01), shape=5, scale=3), type='l', lwd=2, xlab='y', ylab='f(y)')


## Example 3: W ~ Gamma(4,1/12):

# What is P(W > 1/6)?

1 - pgamma(1/6, shape = 4, scale = 1/12)


#########################################################################

### Beta probabilities

## Plots of beta pdf's:

# Setting up 3 by 2 plotting window

par(mfrow=c(3,2))

# Beta(2,2) pdf:

plot(seq(0,1,by=0.01), dbeta(seq(0,1,by=0.01), shape1=2, shape2=2), type='l', lwd=2, xlab='y', ylab='f(y)', main='Beta(2,2) pdf')

# Beta(0.5, 0.5) pdf:

plot(seq(0,1,by=0.01), dbeta(seq(0,1,by=0.01), shape1=0.5, shape2=0.5), type='l', lwd=2, xlab='y', ylab='f(y)', main='Beta(0.5,0.5) pdf')

# Beta(2,3) pdf:

plot(seq(0,1,by=0.01), dbeta(seq(0,1,by=0.01), shape1=2, shape2=3), type='l', lwd=2, xlab='y', ylab='f(y)', main='Beta(2,3) pdf')

# Beta(3,2) pdf:

plot(seq(0,1,by=0.01), dbeta(seq(0,1,by=0.01), shape1=3, shape2=2), type='l', lwd=2, xlab='y', ylab='f(y)', main='Beta(3,2) pdf')

# Beta(2,1) pdf:

plot(seq(0,1,by=0.01), dbeta(seq(0,1,by=0.01), shape1=2, shape2=1), type='l', lwd=2, xlab='y', ylab='f(y)', main='Beta(2,1) pdf')

# Beta(1,1) pdf:

plot(seq(0,1,by=0.01), dbeta(seq(0,1,by=0.01), shape1=1, shape2=1), type='l', lwd=2, xlab='y', ylab='f(y)', main='Beta(1,1) pdf')

# Back to 1 by 1 plotting window

par(mfrow=c(1,1))


## Example 1:  Y ~ Beta(3, 18):

# What is P(Y < .05)?

pbeta(.05, shape1 = 3, shape2 = 18)

# What is P(Y > 20)?

1 - pbeta(.20, shape1 = 3, shape2 = 18)

## We can also find beta probabilities with non-integer parameter values using R:

# If Y ~ Beta(3.6, 5.7), then what is P(.15 < Y < .65)?

pbeta(.65, shape1 = 3.6, shape2 = 5.7) - pbeta(.15, shape1 = 3.6, shape2 = 5.7)


