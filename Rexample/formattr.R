# stringformattr 
# manipulate string
# https://www.karada-good.net/analyticsr/r-552
library("stringformattr")
n <- 5
n <- 10
td <- data.frame("L" = sample(LETTERS[1:24], size = n, replace = T), "l" = sample(letters[1:24], size = n, replace = T))
# join string with each row without space
td[,1] %p% td[,2]
# [1] "NnAtKmTfCi"

# join string with each row with space
td[,1] %s% td[,2]
# [1] "ObTvQrWnDcIjHbCpUsAa"

tc <- "aaa, {t1}, bbb, {t2}"
tc %f% c(t1 = "ccc", t2 = "ddd")
# [1] "aaa, ccc, bbb, ddd"

