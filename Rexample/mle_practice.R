# http://uncorrelated.hatenablog.com/entry/20120110/1326186868
# http://uncorrelated.hatenablog.com/entry/20120216/1329375924
# http://blog.goo.ne.jp/r-de-r/e/594b351c5eb79713e82770560f199604
# Rと手作業で覚える最尤法

## optimization 1
#################

set.seed(123)
# look for normal distribution which is most likely to generate the integer 11, 13, and 23
# samples
x <- c(11, 13, 23)
# calculate the probability that generates the samples from a normal distribution with mean = 15, sd = 40
p <- dnorm(x, mean = 15, sd = sqrt(40))

# take product of p and obtain likelihood
# prod: product(a,b)、a*b
print(paste("尤度:", prod(p)))

## optimization 2
#################
# generate samples
x <- rnorm(300, mean = 15, sd = 10)
n <- length(x)

# set the equations
f1 <- expression(-sum(x-mu)/s2)
f2 <- expression(-n/(2*s2) + sum((x-mu)^2)/(2*(s2^2)))

# first order partial differential equations
# of mu for f1 
g11 <- expression(n/s2)
# of s2 for f1
g12 <- expression(sum(x-mu)/(s2^2))
# of mu for f2
g21 <- expression(sum(mu-x)/(s2^2))
# of se for f2
g22 <- expression(n/(2*(s2^2)) - sum((x-mu)^2) / (s2^3))

# set the initial value
# you can change
mu <- 10
s2 <- 10

for (i in 1:100){
	# set (mu, s2) as 2*1 matrix
	m <- matrix(c(mu, s2), 2,1)
	# set value of f1 and f2 to 2*1 matrix
	f <- matrix(c(eval(f1), eval(f2)),2,1)
	# create jacobian matrix with mu and s2
	j <- matrix(c(eval(g11), eval(g21), eval(g12), eval(g22)), 2, 2)
	# subtract product of inverse(j) and f from m
	mm <- m - solve(j) %*% f
	# m to (x,y)
	mu <- mm[1]; s2 <- mm[2]
	print(sprintf("[%d](mu,s2)=(%f,%f)", i, mu , s2))
}

# show the result
print(sprintf("normal distribution with average:%.3f、sd:%.3f（sd:%.3f)", mu, s2, sqrt(s2)))