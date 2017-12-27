path <- 'C:/data/'

# パスを指定してディレクトリ・ファイルパスを取得。
list.files(path)

# カレントディレクトリを移動してディレクトリ・ファイルパスを取得。
setwd(path)
list.files()

# パターンを指定して取得（「txt」が含まれるものを取得）。
list.files(path, pattern="txt")

# サブディレクトリを含めてファイルパスを取得。
list.files(path, recursive=T)

# サブディレクトリを含めてファイルパスを取得（ディレクトリを含める）。
list.files(path,recursive=T, include.dirs=T)

# 隠しファイルも取得（.が先頭についているもの。winの隠しファイルとは違う）
list.files(path, all.files=T)

# フルパスで取得。
list.files(path, full.names=T)

