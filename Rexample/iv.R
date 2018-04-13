# http://uncorrelated.hatenablog.com/entry/2018/04/11/142008
# 
# 教科書例の需要と供給のデータを作る
# 真のモデル: 
# S = 2 + 3*p + 4*z + ν
# D = 1 - 1*p + μ
# S = D
# p:価格, S:供給, D:需要, z:気候か何か, νとμ:誤差項
# → 価格について式を整理してみると、D=Sと言う式から、P = (2 - 1)/(-1 - 3) + 4・z/(-1 - 3) + (ν - μ)/(-1 - 3)になって、Pに推定する需要関数の誤差項μが含まれていることになり、OLSの条件を満たしません。
#
set.seed(20180411)
obs <- 300 # 観測数（増やしてバイアスの変化をチェック！）
a0 <- 1
a1 <- -1
b0 <- 2
b1 <- 3
b2 <- 4
z <- runif(obs, min=0, max=3)
mu <- rnorm(obs, mean=0, sd=2)
nu <- rnorm(obs, mean=0, sd=1)
p <- (b0 - a0 + b2*z + nu - mu)/(a1 - b1)
df1 <- data.frame(
  p = p,
  d = a0 + a1*p + mu,
  s = b0 + b1*p + b2*z + nu
)
rm(p)

#
# OLSで推定してみる
# → バイアスが入る
#
r_ols <- lm(d ~ p, data=df1)


#
# クロスセクションチェック
# → バイアスは同じまま
#
r_ols_css1 <- lm(d ~ p, data=df1[seq(1, obs, 2), ])
r_ols_css2 <- lm(d ~ p, data=df1[seq(2, obs, 2), ])

#
# tslsパッケージを使えば済む操作変数法
# → バイアスは入らない
#
attach(df1)
zm <- matrix(c(rep(1, obs), c(z)), obs, 2)
xm <- matrix(c(rep(1, obs), c(p)), obs ,2)
iv_estimated_a <- solve(t(zm) %*% xm) %*% (t(zm) %*% d)
detach(df1)

#
# 推定結果の中身を比較してみる
#
print_dc <- function(label, a){
  sprintf("%s: D = %.04f%s%.04fp", label, a[1], ifelse(a[2]>=0,"+",""), a[2])
}

paste(c(
  print_dc("OLS", coef(r_ols)),
  print_dc("CSS01", coef(r_ols_css1)),
  print_dc("CSS02", coef(r_ols_css2)),
  print_dc("IV", iv_estimated_a)))