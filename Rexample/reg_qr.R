n <- 50;M <- 500
x <- seq(1, M, len=n)
X <- cbind(1, x, x^2, x^3)
colnames(X) <- c("Intercept", "x", "x2", "x3")
beta <- matrix(c(1, 1, 1, 1), 4, 1)
set.seed(1)
y <- X %*% beta + rnorm(n, sd=1)

# option 0
(betahat <- solve(t(X) %*% X) %*% t(X) %*% y)

# option 1
QR <- qr(X)
Q <- qr.Q(QR)
R <- qr.R(QR)
(betahat <- backsolve(R, crossprod(Q,y)))

# option 2
QR <- qr(X)
(betahat <- solve.qr(QR, y))
