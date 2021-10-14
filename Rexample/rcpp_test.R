library(Rcpp)
library(RcppEigen)
library(tictoc)

# sourceCpp("Rcpp/rcpp_test.cpp")
# obs
N <- 5
K <- 2

# data
set.seed(123)
z <- rbinom(N, 1, 0.5)
d <- rbinom(N, 1, 0.5)
x <- matrix(rnorm(n = N * K), ncol = K)
y <- rnorm(N)
par <- rep(1, K)
alpha <- 1

# cpp
sourceCpp("Rcpp/rcpp_vec.cpp")
mat_vec(x, par)

tic("cpp")
res <- dnorm_cpp(z, d, x, y, par)
toc()

tic("cpp eigen")
res <- dnorm_cpp_eigen(z, d, x, y, par, 1.0)
toc()


tic("R")
tmp <- 0.0
for (j in 1:20000) {
  cp <- z == 1 & d == 1
  nv <- z == 1 & d == 0
  other <- z == 0

  tmp2 <- x %*% par
  tmp <- sum(dnorm(y[cp], x[cp, ] %*% par, 1, log = TRUE)) + sum() tmp
  tmp <- sum(dnorm(y[nv], x[nv, ] %*% par, 1, log = TRUE)) + tmp
  tmp <- sum(dnorm(y[other], x[other, ] %*% par, 1, log = TRUE)) + tmp
}
toc()


tic("Rcpp")
a <- ret_rnorm_eigen(100000)
toc()

tic("Rcpp")
a <- ret_rnorm(100000)
toc()