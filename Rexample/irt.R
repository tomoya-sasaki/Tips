library(dplyr)
library(ggplot2)

# before the model, let's check qnorm and dnorm
p <- runif(50, 0, 1)

qnorm(p, 0, 1)
# returns vectors of quantile corresponds to the probability p, 
# given the normal distribution N(0,1)

a <- runif(50, -1, 1)
dnorm(a, 0 , 1)
# returns vectors of probability corresponds to the quantile a, 
# given the normal distribution N(0,1)
pnorm(a, 0, 1)
# returns vectors of cumulative probability corresponds to the quantile a, 
# given the normal distribution N(0,1)

## dirichlet distribution
# from MCMCpack
rdirichlet <- function (n, alpha) 
{
    l <- length(alpha)
    x <- matrix(rgamma(l * n, alpha), ncol = l, byrow = TRUE)
    sm <- x %*% rep(1, l)
    return(x/as.vector(sm))
}


n <- 50
# beta as 
beta <- runif(n, -5, 5)
alpha <- runif(n, 0, 10)
x <- rep(NA, n)

