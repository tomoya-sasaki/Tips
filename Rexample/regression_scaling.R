N <- 1000

x1 <- rnorm(N, mean = 10, sd = 5)
x2 <- rnorm(N, mean = 0, sd = 1)


###########################################
# linear regression
###########################################
y <- rnorm(N, mean = 5, sd = 5)

mod1 <- lm(y ~ x1 + x2)
summary(mod1)

# x1 scaled
x1_norm <- (x1 - mean(x1)) / sd(x1)
mod2 <- lm(y ~ x1_norm + x2)
summary(mod2)

# these are equal
coefficients(summary(mod1))[2, 2]
coefficients(summary(mod2))[2, 2] / sd(x1)

coefficients(summary(mod1))[2, 1]
coefficients(summary(mod2))[2, 1] / sd(x1)

# transform outcomes
y_norm <- (y - mean(y)) / sd(y)

mod3 <- lm(y_norm ~ x1 + x2)
summary(mod3)

# these are equal
coefficients(summary(mod1))[2, 2]
coefficients(summary(mod3))[2, 2] * sd(y)

coefficients(summary(mod1))[2, 1]
coefficients(summary(mod3))[2, 1] * sd(y)


# transform both
mod4 <- lm(y_norm ~ x1_norm + x2)
summary(mod4)

# these are equal
coefficients(summary(mod1))[2, 2]
coefficients(summary(mod4))[2, 2] / sd(y) * sd(x1)

coefficients(summary(mod1))[2, 1]
coefficients(summary(mod4))[2, 1] / sd(y) * sd(x1)

###########################################
# logistic regression
###########################################
y2 <- rbinom(N, size = 1, prob = 0.5)

mod1 <- glm(y2 ~ x1 + x2, family = binomial("logit"))
summary(mod1)

# x1 scaled
mod2 <- glm(y2 ~ x1_norm + x2, family = binomial("logit"))
summary(mod2)

# these are equal
coefficients(summary(mod1))[2, 2]
coefficients(summary(mod2))[2, 2] / sd(x1)

coefficients(summary(mod1))[2, 1]
coefficients(summary(mod2))[2, 1] / sd(x1)
