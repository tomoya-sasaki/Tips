# distributions

## log-normal distributions 
* Transforming moments into parameters of log-normal distribution
* `m` as the mean and `s` as the standard error of the log-normal distribution
* Note that location and shape parameters do not directly correspond to moments of the distribution

```
m <- 7
s <- 75
location <- log(m^2 / sqrt(s^2 + m^2))
shape <- sqrt(log(1 + (s^2 / m^2)))
draws <- rlnorm(n=1000000, location, shape)
```