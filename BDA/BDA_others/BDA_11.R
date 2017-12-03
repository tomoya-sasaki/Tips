## BDA ch.11
## Hiroto Katsumata
## May 15, 2017

require(MASS)
require(mvtnorm)
require(tidyverse)

## The Gibbs Sampler
## Bibariate normal distribution

bvn_gibbs <- function(y1 = 0, y2 = 0, rho = 0.8, iteration = 500, start = c(2.5, 2.5)) {
	theta1 <- numeric(iteration + 1)
	theta2 <- numeric(iteration + 1)
	theta1[1] <- start[1]
	theta2[1] <- start[2]
	for(t in 2:(iteration + 1)){
		theta1[t] <- rnorm(1, y1 + rho * (theta2[t - 1] - y2), 1 - rho^2)
		theta2[t] <- rnorm(1, y2 + rho * (theta1[t] - y1), 1 - rho^2)
	}
	list(theta1 = theta1, theta2 = theta2, y1 = y1, y2 = y2, rho = rho, iteration = iteration, start = start)
}

result_bvn_gibbs <- bvn_gibbs()

data.frame(theta1 = result_bvn_gibbs$theta1, theta2 = result_bvn_gibbs$theta2) %>%
ggplot(., aes(x = theta1, y = theta2)) +
	geom_point() +
	scale_x_continuous(limits = c(-4, 4)) +
	scale_y_continuous(limits = c(-4, 4))


## The Metropolis algorithm
## Bivariate unit normal density with normal jumping kernel
Metropolis  <- function(theta_t_1, jump = 0.2^2) {
	mut <- theta_t_1
	I2 <- matrix(c(1, 0, 0, 1), nrow = 2, ncol = 2)
	proposed <- mvrnorm(n = 1, mu = mut, Sigma = I2 * jump)
	r <- dmvnorm(x = proposed, mean = c(0, 0), sigma = I2) / dmvnorm(x = mut, mean = c(0, 0), sigma = I2)
	accepted <- (r > runif(1, 0, 1))
	thetat <- ifelse(rep(accepted, 2), proposed, theta_t_1)
	thetat
}

bvn_metro <- function(iteration = 500, start = c(2.5, 2.5), jump = 0.2^2) {
	theta1 <- numeric(iteration + 1)
	theta2 <- numeric(iteration + 1)
	theta1[1] <- start[1]
	theta2[1] <- start[2]
	for(t in 2:(iteration + 1)){
		result <- Metropolis(theta_t_1 = c(theta1[t - 1], theta2[t - 1]), jump = jump)
		theta1[t] <- result[1]
		theta2[t] <- result[2]
	}
	list(theta1 = theta1, theta2 = theta2, iteration = iteration, start = start)
}

result_bvn_metro <- bvn_metro()
data.frame(theta1 = result_bvn_metro$theta1, theta2 = result_bvn_metro$theta2) %>%
ggplot(., aes(x = theta1, y = theta2)) +
	geom_point() +
	scale_x_continuous(limits = c(-4, 4)) +
	scale_y_continuous(limits = c(-4, 4))

result_bvn_metro <- bvn_metro(jump = 0.8^2)
data.frame(theta1 = result_bvn_metro$theta1, theta2 = result_bvn_metro$theta2) %>%
ggplot(., aes(x = theta1, y = theta2)) +
	geom_point() +
	scale_x_continuous(limits = c(-4, 4)) +
	scale_y_continuous(limits = c(-4, 4))

