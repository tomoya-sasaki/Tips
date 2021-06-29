library(readr)
library(quanteda)
setwd("/Users/tomoyasasaki/Downloads/test/")

object <- lapply(list.files(), read_csv, col_names = FALSE)
Unzip <- function(...) {
  rbind(data.frame(), ...)
}
dat <- do.call(Unzip, object)
colnames(dat) <- c("date","number","session","name","gender","role","party", "speech")
cop <- corpus(dat, text_field = "speech") #データの読み込み
new =c("dass", "beifall","spd","cdu","csu","90","grünen","f.d.p","herr","bündnis","pds","herren","damen","pds","grünen"))

fam.dfm <- dfm(cop, stem=T, remove_punct= T, remove = stopwords("german")) 
term <- fam.dfm@Dimnames$features # include each term

stopwords("german") %in% term 

# solution?
fam.dfm2 <- dfm(cop, stem=T, remove_punct= T) %>% 
  dfm_remove(stopwords("german"))
# the order of the removal matter
# stemming may happen AFTER removed stopwords, 
# which means that stemmed stopwords may remain 
# in the corpus if you use thi
# dfm(cop, stem=T, remove_punct= T, remove = stopwords("german")) 


term2 <- fam.dfm2@Dimnames$features # include each term

stopwords("german") %in% term2

## check for the whole corpus

setwd("./Wahlperiod14SpeechDataCSV")
object <- lapply(list.files(), read_csv, col_names = FALSE)
Unzip <- function(...) {
  rbind(data.frame(), ...)
}
dat <- do.call(Unzip, object)
colnames(dat) <- c("date","number","session","name","gender","role","party", "speech")
cop <- corpus(dat, text_field = "speech") #データの読み込み

fam.dfm <- dfm(cop, stem=T, remove_punct= T, remove = stopwords("german")) 
term <- fam.dfm@Dimnames$features # include each term

stopwords("german") %in% term 

# solution!
fam.dfm2 <- dfm(cop, stem=T, remove_punct= T) %>% 
  dfm_remove(stopwords("german"))

term2 <- fam.dfm2@Dimnames$features # include each term

stopwords("german") %in% term2


# add stopwords
new <- c("dass", "beifall","spd","cdu","csu","90","grünen","f.d.p","herr","bündnis","pds","herren","damen","pds","grünen")
stopwords_new <- c(stopwords("german"), new)

fam.dfm3 <- dfm(cop, stem=T, remove_punct= T) %>% 
  dfm_remove(stopwords_new)

term3 <- fam.dfm3@Dimnames$features # include each term

stopwords_new %in% term3
