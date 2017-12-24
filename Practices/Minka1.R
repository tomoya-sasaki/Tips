library(MCMCpack)

## create data for each
D <- 30
K <- 5
alpha <- rep(.1, K)
d <- rdirichlet(D, alpha)
mat <- matrix(0, nrow = D, ncol = K)
for (i in 1:D){
	mat[i,] <- rmultinom(1, K, d[i,])
}
write.table(mat, "test5.csv", sep = ",", row.names = F)

## create multiple parameters and datas
param <- c(.1, .5, 1, 5)
D <- 100 # number of document
K <- 10 # number of topic
N <- 100 # length of document
d_list <- list()
set.seed(123)
for (i in 1:length(param)){
	alpha2 <- rep(param[i], K)
	d <- rdirichlet(D, alpha2)
	mat <- matrix(0, nrow = D, ncol = K)
	for (j in 1:D){
		mat[j,] <- rmultinom(1, N, d[j,])
	}
	d_list[[i]] <- d
	save_name <- paste0("1025_", i, ".csv")
	write.table(mat, save_name, sep = ",", row.names = F)
}


################################################
##                         Fixed point iteration
################################################

## Fixed point iteration for dirichlet parameter
## D: observerd data, categorical possibilities
## tol: check the converge
## maxiter: max number of iteration
.fixpoint2 <- function(D, tol = 1e-7, maxiter = 1000, init = 1){
	## The dimension of the parameter
	K <- ncol(D)
	## set the initial value
	# a0 <- .initA(D)
	a0 <- rep(init, K)
	print(a0)
	## calculate the \bar{p_k}
	logp <- apply(log(D), MARGIN = 2, mean)

	## run the iteration
	for (i in 1:maxiter){
		# a_new <- numeric(K)
		# for (k in 1:K){
		# 	## calculate inside the inverse digamma
		# 	tmp <- digamma(sum(a0)) + logp[k]
		# 	## take inverse digamma, which is the new alpha
		# 	a_new[k] <- .iPsi(tmp)
		# }
		## calculate inside the inverse digamma
		tmp <- digamma(sum(a0)) + logp
		## take inverse digamma, which is the new alpha
		a_new <- .iPsi(tmp)
		
		## calculate the loglikelihood
		old_loglik <- .loglik(D, a0)
		new_loglik <- .loglik(D, a_new)
		test <- new_loglik - old_loglik
		## print the results
		print(a_new)
		print( sprintf("old loglikelihood %10f", old_loglik))
		print( sprintf("new loglikelihood %10f", new_loglik))

		## finish if converged
		if ( abs(test)  < tol){
			print( sprintf("finish iteration at %d", i) )
			return (a_new)
		}
		## break if new loglikelihood is smaller
		if (test < 0){
			print( "new loglikelihood is smaller than the older one")
			break
		}
		## if not converged, update alpha and run again
		a0 <- a_new
	}
	print("failed to converge")
}

## Fixed point iteration for dirichlet parameter
## D: observerd data, categorical possibilities
## tol: check the converge
## maxiter: max number of iteration
## no warnings for decreasing loglikelihood
.fixpoint <- function(D, tol = 1e-7, maxiter = 1000, init = 1){
	## The dimension of the parameter
	K <- ncol(D)
	## set the initial value
	# a0 <- .initA(D)
	a0 <- rep(init, K)
	print(a0)
	## calculate the \bar{p_k}
	logp <- apply(log(D), MARGIN = 2, mean)

	## run the iteration
	for (i in 1:maxiter){
		# a_new <- numeric(K)
		# for (k in 1:K){
		# 	## calculate inside the inverse digamma
		# 	tmp <- digamma(sum(a0)) + logp[k]
		# 	## take inverse digamma, which is the new alpha
		# 	a_new[k] <- .iPsi(tmp)
		# }
		## calculate inside the inverse digamma
		tmp <- digamma(sum(a0)) + logp
		print(tmp)
		## take inverse digamma, which is the new alpha
		a_new <- .iPsi(tmp)
		
		## calculate the loglikelihood
		old_loglik <- .loglik(D, a0)
		new_loglik <- .loglik(D, a_new)
		test <- new_loglik - old_loglik
		## print the results
		print(a_new)
		print( sprintf("old loglikelihood %10f", old_loglik))
		print( sprintf("new loglikelihood %10f", new_loglik))

		## finish if converged
		if ( abs(test)  < tol){
			print( sprintf("finish iteration at %d", i) )
			return (a_new)
		}

		## if not converged, update alpha and run again
		a0 <- a_new
	}
	print("failed to converge")
}


## Calculate the inverse of digamma function
## See appendix C of Minka techinical report
.iPsi <- function(x){
	# print("initial input in inverse digamma")
	# print(x)
	M <- x >= -2.22
	y <- M * (exp(x) + 0.5) + (1-M) * (- 1/(x - digamma(1)))
	for (i in 1:10){
		# print("updating inverse digamma")
		# print(y)
		y_new <- y - (digamma(y) - x)/trigamma(y)
		y <- y_new
	}
	return (y)
}

## Set the initial value
## See https://github.com/ericsuh/dirichlet/blob/master/dirichlet/dirichlet.py
# .initA <- function(a){
# 	amean <- apply(a, MARGIN = 2, mean) # take the mean for each column
# 	amean2 <- apply(a*2, MARGIN = 2, mean)
# 	res <- amean * ( (amean - amean2)  / (amean2 - amean **2 ) )
# 	return (res)
# }

## Calculate the loglikelihood
.loglik <- function(D, a){
	N <- nrow(D)
	logp <- apply(log(D), MARGIN = 2, mean)
	res <- N * ( lgamma(sum(a)) - sum(lgamma(a)) + sum((a-1) * logp) )
	return(res)
}


## digammma function from wallach code
.digamma <- function(x){
	x <-  x + 6
	p <-  1.0 / (x * x)

	p <- (((0.004166666666667 * p - 0.003968253986254) * p + 0.008333333333333) * p - 0.083333333333333) * p
	p <- p + log(x) - 0.5 / x - 1 / (x-1) - 1 / (x-2) - 1 / (x-3) - 1 / (x-4) - 1 / (x-5) - 1 / (x-6)

	return (p)

}
