# Set working directory
setwd("/Users/Shusei/Dropbox/Study/Study_Session/BDA")

# Load library
library(tidyverse)

####################
# Create fake data #
####################
num_data <- 500

age <- rnorm(num_data, mean=30, sd=15)
income <- rpois(num_data, lambda=400)
data <- data.frame(age, income)
covariates <- as.matrix(data[,c("age", "income")])


## Muliple Regression
betaX <- c(2.8, -1.2)
data$Y <- covariates %*% betaX + rnorm(num_data)

## Simple Regression
data_s <- data.frame(age)
tau_true <- 1
data_s$Y <- -1.2 + 2.8 * age + rnorm(num_data, sd=1/sqrt(tau_true))

## Data in original
x <- runif(num_data, 0, 4)
beta_0_true <- -1
beta_1_true <- 2
tau_true <- 1
y <- rnorm(num_data, beta_0_true + beta_1_true*x, 1/sqrt(tau_true))

###################################
# Linear Regression Using Package #
###################################
## Saimple
res_s_lm <- lm(Y ~ age, data_s)
summary(res_s_lm)

# Original data
res_original <- lm(y ~ x)
summary(res_original)

##################################################
# Bayesian Linear Regression (Simple Regression) #
##################################################
N <- num_data
iter_num <- 5000

sample_beta_0 <- function(y, x, beta_1, tau, mu_0, tau_0){
	precision <- tau_0 + tau * N
	mean0 <- tau_0 * mu_0 + tau * sum(y - (beta_1 * x))
	mean0 <- mean0 / precision
	value <- rnorm(1, mean=mean0, sd=1/sqrt(precision))
	return(value)
}

sample_beta_1 <- function(y, x, beta_0, tau, mu_1, tau_1){
	precision <- tau_1 + tau * sum(x*x)
	mean <- tau_1 * mu_1 + tau * sum((y - beta_0) * x)
	mean <- mean / precision
	value <- rnorm(1, mean=mean, sd=1/sqrt(precision))
	return(value)
}

sample_tau <- function(y, x, beta_0, beta_1, alpha, beta){
	alpha_new <- alpha + N/2
	resid <- y - beta_0 - (beta_1 * x)
	beta_new <- beta + sum(resid*resid) / 2
	value <- rgamma(1, shape=alpha_new, rate=beta_new)
		# alpha = shape, beta = 1/rate
}

# Prepare storages
beta_0 <- rep(NA, iter_num)
beta_1 <- rep(NA, iter_num)
tau <- rep(NA, iter_num)

# Initialization
beta_0[1] <- 1
beta_1[1] <- 1
tau[1] <- 2

# Run
for(i in 1:(iter_num-1)){
	beta_0[i+1] <- sample_beta_0(y=data_s$Y, x=data_s$age, beta_1=beta_1[i], tau=tau[i], mu_0=0, tau_0=1)
	beta_1[i+1] <- sample_beta_1(y=data_s$Y, x=data_s$age, beta_0=beta_0[i+1], tau=tau[i], mu_1=0, tau_1=1)
	tau[i+1] <- sample_tau(y=data_s$Y, x=data_s$age, beta_0=beta_0[i+1], beta_1=beta_1[i+1], alpha=2, beta=1)
}

make_figure <- function(params, true_values, params_names, burn_in=2000, slice=5){
	num_params <- length(params)

	tidy_params <- list()
	for(i in 1:num_params){
		temp <- data.frame(value=params[[i]])
		temp$parameter <- params_names[i]
		temp$iter <- 1:nrow(temp)

		temp <- temp[burn_in:nrow(temp) ,]
		slice_index <- seq(1, nrow(temp), slice)# slice data
		temp <- temp[slice_index, ]
		tidy_params[[i]] <- temp
	}
	tidy_params <- do.call(rbind.data.frame, tidy_params)

	true <- data.frame(
		parameter = params_names,
		value = true_values
		)

	param <- ggplot(data=tidy_params, aes(x=iter, y=value, group=parameter, color=parameter)) + 
			geom_line() + 
			geom_point(size=0.3) +
			facet_wrap(~parameter, ncol=2, scales = "free") +
			geom_hline(data = true, aes(yintercept = value), size=0.7) +
			theme_bw() +
			theme(legend.position="none")

	param_density <- ggplot(data=tidy_params, aes(x=value, color=parameter, fill=parameter)) +
		geom_density(stat = "density", position = "identity",alpha=0.6) + 
		facet_wrap(~parameter, ncol=2, scales = "free") +
		geom_vline(data = true, aes(xintercept = value), size=0.7) +
		theme_bw()

	return(list(param, param_density))

}

params <- list(beta_0, beta_1, tau)
true_values <- c(-1.2, 2.8, 1.0)
params_names <- c("beta_0", "beta_1", "tau")
gs_res1 <- make_figure(params, true_values, params_names, burn_in=2000, slice=5)
gs_res1[[1]]
gs_res1[[2]]

## Run with original data
# Prepare storages
beta_0 <- rep(NA, iter_num)
beta_1 <- rep(NA, iter_num)
tau <- rep(NA, iter_num)

# Initialization
beta_0[1] <- 0
beta_1[1] <- 1
tau[1] <- 2
# Run
for(i in 1:(iter_num-1)){
	beta_0[i+1] <- sample_beta_0(y=y, x=x, beta_1=beta_1[i], tau=tau[i], mu_0=0, tau_0=1)
	beta_1[i+1] <- sample_beta_1(y=y, x=x, beta_0=beta_0[i+1], tau=tau[i], mu_1=0, tau_1=1)
	tau[i+1] <- sample_tau(y=y, x=x, beta_0=beta_0[i+1], beta_1=beta_1[i+1], alpha=2, beta=1)
}

params <- list(beta_0, beta_1, tau)
true_values <- c(-1.0, 2.0, 1.0)
params_names <- c("beta_0", "beta_1", "tau")
gs_res2 <- make_figure(params, true_values, params_names, burn_in=2000, slice=5)
gs_res2[[1]]
gs_res2[[2]]

#############################################################################################
#############################################################################################


