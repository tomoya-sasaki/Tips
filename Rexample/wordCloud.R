library(wordcloud2)
library(Nippon)

data(month.name.jp)
Testdata <- data.frame(word = month.name.jp, freq = sample(1:5, 12, replace = T))

# LETTERS[] and letters[] give us alphabets with capitals and lower case
# LETTERS[1:4] will give you >a,b,c,d
Testdata2 <- data.frame(word = c(LETTERS[1:24], letters[1:24], 1:500), freq = sample(1:50, 548, replace = T))

#インタラクティブなワードクラウドを作成:wordcloud2コマンド
#文字種類を指定:fontFamilyオプション,日本語に対応するためYuGothicを指定
#背景色を指定:backgroundColorオプション
#color option
#プロットスタイルを指定:shapeオプション;circle,cardioid,diamond,
#triangle-forward,triangle,pentagon,starが指定可能

Cloud <- wordcloud2(Testdata, fontFamily = "YuGothic", shape = "circle", color = "random-light", backgroundColor = "grey")

# 結果をディレクトリに保存
library("htmlwidgets")
saveWidget(Cloud, "Test.html", selfcontained = F)

#指定文字に合わせたインタラクティブなワードクラウドを作成:letterCloudコマンド
#文字を指定:wordオプション
#その他オプション,結果保存方法はwordcloud2コマンドと同じ
letterCloud(Testdata2, word = "KARADA")