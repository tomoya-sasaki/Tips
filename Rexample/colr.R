# https://www.karada-good.net/analyticsr/r-551
library(colr)
n <- 10

td <- data.frame("group" = sample(paste0("Group", 1:5), n , replace = T), 
	"d1" = sample(1:50, n, replace = T),
	"d2" = sample(1:30, n , replace = T))

rownames(td) <- paste0(c("man", "woman"), 1:n)

#指定した内容で行または列を抽出:cgrepコマンド
#データを指定:xオプション
#抽出内容を設定:patternオプション;正規表現の使用可能
#検索方向を指定:dimオプション:c;列方向,r;行方向
# dim = "c" で実行しても抽出されない
cgrep(x = td, pattern = "woman", dim = "r")
#          group d1 d2
#woman2  Group3  5 26
#woman4  Group1 26  7
#woman6  Group1 12 29
#woman8  Group3 31 16
#woman10 Group4  9 22

#行または列名を置換:csubコマンド
#データを指定:xオプション
#対象内容を設定:patternオプション;正規表現の使用可能
#置換内容を設定:replacementオプション;正規表現の使用可能
#検索方向を指定:dimオプション:c;列方向,r;行方向

csub(x =td, pattern = "woman", replacement = "lady", dim = "r")
# dim = "c" で実行しても置換されない

#[]で囲まれた文字のどれかと一致
 cgrep(x = td, pattern = "[3w]", dim = "r")
#          group d1 d2
# woman2  Group3  5 26
# man3    Group2 17  6
# woman4  Group1 26  7
# woman6  Group1 12 29
# woman8  Group3 31 16
# woman10 Group4  9 22
# row names which includes "w" or "3" appears

#^で否定,Data数字を非選択
#[:digit:]数字を意味する
cgrep(x = td, pattern = "[^man[:digit:]]", dim = "r")
#          group d1 d2
# woman2  Group3  5 26
# woman4  Group1 26  7
# woman6  Group1 12 29
# woman8  Group3 31 16
# woman10 Group4  9 22
# row names which includes "man + [int]" disapper

cgrep(x = td, pattern = "[^woman[:digit:]]", dim = "r")
# [1] group d1    d2   
# <0 rows> (or 0-length row.names)
# row names which indlues "woman + [int]" disappear

cgrep(x = td, pattern = "woman(2|6)", dim = "r")
#         group d1 d2
# woman2 Group3  5 26
# woman6 Group1 12 29