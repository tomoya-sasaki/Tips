library(gtools)
set.seed(123)
N <- 50
k <- 3
alpha <- rep(1, k)

Df <- data.frame(matrix(nrow = N, ncol = 2 + k))
Df[, 2] <- rpois(N, 5) # x
Df[, 3:5] <- rdirichlet(N, c(1, 1, 1))
Df[, 1] <- 5 + 2 * Df[,2] + 3 * Df[,3] + (-2) + Df[,4] + (-1) * Df[,5] + rnorm(N, 0, 2)
colnames(Df) <- c("Y", "X", "Z1", "Z2", "Z3")

model1 <- lm(Y ~ Z + Z1 + Z2 + Z3, Df)