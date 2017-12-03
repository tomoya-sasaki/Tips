require(mnormt)
require(coda)

## DGP of the MNL model
n <- 1000
x <- cbind(1, rnorm(n), rnorm(n), rnorm(n))
true.beta <- cbind(c(0.5, 1, 0.5, -1), c(1, 1, -0.5, -1))
true.prob <- cbind(exp(x %*% true.beta), 1) / rowSums(cbind(exp(x %*% true.beta), 1))
y <- rep(NA, n)
for (i in 1:n) {
  y[i] <- c(1:3) %*% rmultinom(1, 1, true.prob[i, ])
}
table(y)

## function to compute (-1 * log posterior)
MNL.negative.log.posterior <- function(beta, y.dummy, x, prior.mean, prior.vcov) {
  beta.matrix <- matrix(beta, ncol(x), ncol(y.dummy) - 1)
  exp.betax <- cbind(exp(x %*% beta.matrix), 1)
  probability <- exp.betax / rowSums(exp.betax)
  -1 * (sum(log(rowSums(y.dummy * probability))) + dmnorm(beta, prior.mean, prior.vcov, log = TRUE))
}

## function of numerical differentiation of (-1 * log posterior)
derivative <- function(beta, y.dummy, x, prior.mean, prior.vcov, delta = 0.0001) {
  result <- rep(NA, length(beta))
  for (i in 1:length(beta)) {
    new.beta <- beta
    new.beta[i] <- beta[i] - delta
    backward <- MNL.negative.log.posterior(new.beta, y.dummy, x, prior.mean, prior.vcov)
    new.beta[i] <- beta[i] + delta
    forward <- MNL.negative.log.posterior(new.beta, y.dummy, x, prior.mean, prior.vcov)
    result[i] <- (forward - backward) / (2 * delta)
  }
  result
}

## random-walk metropolis algorithm
MNL.Metropolis <- function(y, x, initial.beta, 
                           prior.mean = rep(0, length(initial.beta)), 
                           prior.vcov = 100 * diag(length(initial.beta)), 
                           tune = 0.001, iter = 1000) {
  y.dummy <- diag(max(y))[y, ]
  l <- length(initial.beta)
  beta <- initial.beta
  jumping.vcv <- tune * diag(l)
  sampled.beta <- matrix(NA, iter, l)
  for (i in 1:iter) {
    old.log.posterior <- MNL.negative.log.posterior(beta, y.dummy, x, prior.mean, prior.vcov)
    new.beta <- beta + rmnorm(1, rep(0, l), jumping.vcv)
    new.log.posterior <- MNL.negative.log.posterior(new.beta, y.dummy, x, prior.mean, prior.vcov)
    alpha <- min(1, exp(old.log.posterior - new.log.posterior))
    if (runif(1) < alpha) {
      beta <- new.beta
    }
    sampled.beta[i, ] <- beta
  }
  sampled.beta
}

## HMC algorithm
MNL.HMC <- function(y, x, initial.beta, 
                    prior.mean = rep(0, length(initial.beta)), 
                    prior.vcov = 100 * diag(length(initial.beta)), 
                    epsilon = 0.1, L = 10, iter = 1000) {
  y.dummy <- diag(max(y))[y, ]
  l <- length(initial.beta)
  beta <- initial.beta
  sampled.beta <- matrix(NA, iter, l)
  for (i in 1:iter) {
    p <- rmnorm(1, rep(0, l), diag(l))
    current.theta <- beta
    current.p <- p - (epsilon / 2) * derivative(beta = current.theta, y.dummy, x, prior.mean, prior.vcov)
    for (j in 1:(L - 1)) {
      current.theta <- current.theta + epsilon * current.p
      current.p <- current.p - epsilon * derivative(current.theta, y.dummy, x, prior.mean, prior.vcov)
    }
    current.theta <- current.theta + epsilon * current.p
    current.p <- current.p - (epsilon / 2) * derivative(current.theta, y.dummy, x, prior.mean, prior.vcov)
    H.old <- MNL.negative.log.posterior(beta, y.dummy, x, prior.mean, prior.vcov) + sum(p ^ 2) / 2
    H.new <- MNL.negative.log.posterior(current.theta, y.dummy, x, prior.mean, prior.vcov) + sum(current.p ^ 2) / 2
    alpha <- min(1, exp(H.old - H.new))
    if (runif(1) < alpha) {
      beta <- current.theta
    }
    sampled.beta[i, ] <- beta
  }
  sampled.beta
}

## estimation by the randon-walk metropolis algorithm
system.time(
  Metropolis.result <- MNL.Metropolis(y = y, x = x, initial.beta = rep(0, 8), 
                                      tune = 0.001, iter = 1000)
)
plot(mcmc(Metropolis.result[501:1000, ]))
autocorr.plot(mcmc(Metropolis.result[501:1000, ]))

## estimation by the HMC algorithm
system.time(
  HMC.result <- MNL.HMC(y = y, x = x, initial.beta = rep(0, 8), 
                        epsilon = 0.05, L = 20, iter = 1000)
)
plot(mcmc(HMC.result[501:1000, ]))
autocorr.plot(mcmc(HMC.result[501:1000, ]))

## estimation by the randon-walk metropolis algorithm (150 times longer iterations)
system.time(
  Metropolis.result2 <- MNL.Metropolis(y = y, x = x, initial.beta = rep(0, 8), 
                                       tune = 0.001, iter = 150000)
)
plot(mcmc(Metropolis.result2[seq(75001, 150000, 150), ]))
autocorr.plot(mcmc(Metropolis.result2[seq(75001, 150000, 150), ]))