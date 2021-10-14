library(tictoc)
library(lobstr)

N <- 1000000
K <- 3


# cbind and matrix shows similar output
# cbind
e <- cbind(x = numeric(N), y = numeric(N), z = numeric(N))
obj_addr(e)
obj_size(e)
# 24,000,640 B

tic("cbind")
for (i in 1:N) {
  e[i, ] <- rnorm(K)
}
toc()
# cbind: 2.312 sec elapsed
obj_addr(e)
# identical to the object address before inputing
obj_size(e)
# 24,000,640 B


# matrix
d <- matrix(0, ncol = K, nrow = N)
colnames(d) <- c("x", "y", "z")
obj_addr(d)
obj_size(d)
# 24,000,640 B

tic("matrix")
for (i in 1:N) {
  d[i, ] <- rnorm(K)
}
toc()
# matrix: 2.047 sec elapsed
obj_addr(d)
# NOT identical to the object address before inputing
obj_size(d)
# 24,000,640 B


# too slow if you loop over all N
f <- data.frame(x = numeric(N), y = numeric(N))
obj_addr(f)
obj_size(f)
# 16,000,848 B

tic("dataframe")
for (i in 1:1000) {
	f[i, ] <- rnorm(2)
}
toc()
# dataframe: 5.701 sec elapsed
obj_addr(f)
# NOT identical to the object address before inputing
obj_size(f)
# 16,000,848 B


# too slow
g <- list()
obj_addr(g)
# NOT identical to the object address before inputing
obj_size(g)
# 48 B

tic("list")
for (i in 1:N) {
  g[[i]] <- rnorm(2)
}
toc()
# list: 2.882 sec elapsed
obj_addr(g)
# NOT identical to the object address before inputing
obj_size(g)
# 72,000,048 B

g2 <- do.call(rbind, g) # this output is a table
