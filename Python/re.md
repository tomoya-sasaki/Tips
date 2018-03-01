# Basic
Read [here][A]

# Some rules
## `%` to insert 
```
'%s, hoge, %s, %s" % ("a", "b", "c")'
>>> 'a, hoge, b, c'

# or equivalently
txt = '%s, hoge, %s, %s" % ("a", "b", "c")'
txt % ('a', 'b', 'c')
```


## 最短一致 ([参考][B])

URLを解析して、特定パターンに合致する文字列を取り出したかったのです。

「 http://hoge.com/hoge/fuga/goods/ 」から、スラッシュで囲まれた最初のブロックの文字列…今回の場合は「hoge」だけ取り出したい。

```
# 誤.rb
url.match(/^http:\/\/hoge.com\/(.*)\//)
```
これだと、引っかかるのは「hoge/fuga/goods」になる。
条件として指定している「/」は、一番最後のを使っている形になってますね。違うんです、一番最初に出てきた「/」を区切りとして使いたいんです！

てなわけで、最短マッチのメタ文字を追加。

```
#正.rb
url.match(/^http:\/\/hoge.com\/(.*?)\//)
```
任意の1文字の繰り返しを最短で切り上げるため、(.*)に「?」を入れます。
すると、期待通りに「hoge」だけ取れるようになりました。

## Extract only alphabet

```
st = "1234567890sdfghjkl"
word1 = "".join(re.findall("[a-zA-Z]+", st))

word1
sdfghjkl
```


[A]:http://www.geocities.jp/m_hiroi/light/python04.html
[B]:http://qiita.com/ha_g1/items/d41febac011df4601544