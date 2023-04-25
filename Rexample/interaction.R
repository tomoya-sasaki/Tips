set.seed(123)

N <- 1000

d <- rnorm(n = N, mean = 2, sd = 5)
w <- rnorm(n = N, mean = -1, sd = 2)
e <- rnorm(n = N)

y <- 2 + 3 * d + 4 * w + d * w + e

m <- lm(y ~ d * w)

coef(m)


z <- scale(w)

m2 <- lm(y ~ d * z)

coef(m2)

coefs <- numeric(4)
names(coefs) <- names(coef(m))

# intercept
coefs[1] <- coef(m2)[1] - coef(m2)[3] * attr(z, "scaled:center") / attr(z, "scaled:scale")

# coefficient involving z
coefs[c(3, 4)] <- coef(m2)[c(3, 4)] / attr(z, "scaled:scale")

# coefficient of w
coefs[2] <- coef(m2)[2] - coef(m2)[4] * attr(z, "scaled:center") / attr(z, "scaled:scale")

coefs

all.equal(coefs, coef(m))
