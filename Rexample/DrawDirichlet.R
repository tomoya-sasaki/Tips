plot.dirichlet <- function(x){
  # x must be Nx3 matrix!!
  X <- x[,2]-x[,1]
  Y <- x[,3]
  par(xaxt="n")
  par(yaxt="n")
  par(bty="n")
  # par(mar=rep(0,4))
  plot(X,Y,xlim=c(-1.2,1.2),ylim=c(-0.2,1.2),xlab="",ylab="",pch=20,cex=0.7)
  lines(c(-1, 1, 0, -1),c(0, 0, 1, 0),col="gray")
  # text(-1,0,"x1");  text(1,0,"x2");  text(0,1,"x3")
  # alpha <- attr(x,"alpha")
  # stralpha <- paste("a1=",alpha[1],"\na2=",alpha[2],"\na3=",alpha[3],sep="")
  # text(-0.8,0.8,stralpha)
  print(alpha)
  # symbols(-1,0,circles=0.08*sqrt(alpha[1]),inches=F,add=T)
  # symbols(1,0,circles=0.08*sqrt(alpha[2]),inches=F,add=T)
  # symbols(0,1,circles=0.08*sqrt(alpha[3]),inches=F,add=T)
}
 
rdirichlet <- function(N,alpha){
  d <- length(alpha)
  res <- matrix(0,N,d)
  for( i in 1:d ){
    res[,i] <- rgamma(N,alpha[i])
  }
  res <- res / rowSums(res)
  class(res) <- "dirichlet"
  attr(res,"alpha") <- alpha
  res
}
 