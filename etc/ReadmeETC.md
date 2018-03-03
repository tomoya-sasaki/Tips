# Terminal
## Check Core
Reference [here][0]

* `nproc --all`: Command `nproc` prints the number of processing units available to the current process, which may be less than the number of online processors.

## Count the length of row
```
$ wc -l <filename>
```

## Count the number of files
```
$ ls | wc -l
```

## Obtain current path in terminal
```
$ pwd
```

## Directory with space
When you use directory with space, you have to add `\` before the space.
(e.g. `/Users/tomoyasasaki/Google\ ドライブ/TMY/`)

## Set Global PATH

1. open and edit `.bash_profile` 
e.g. `sudo emacs .bash_profile` or `sudo vi .bash_profile`
2. add the PATH
e.g. `export PATH=$PATH:[PATH you want to add]`
If you add as follows, you can read anything in `./local/bin`

```
# User specific environment and startup programs
PATH=$PATH:$HOME/.local/bin:$HOME/bin
PATH=$PATH:~/.local/bin
```

3. when you use emacs, use `command + x` and `command + c` to finish editing and save
4. then don't forget to put `source ~/.bash_profile` 
5. check PATH with `printenv PATH`

#### Reference
* http://qiita.com/nbkn/items/01a11392921119fa0153
* http://qiita.com/soarflat/items/d5015bec37f8a8254380
* http://cns-guide.sfc.keio.ac.jp/2000/4/1/2.html

## Set PATH for Tex packages
1. put style file here with new directory:
`/usr/local/texlive/2014/texmf-dist/tex/latex/misc/`
The new directory will be like this: `/usr/local/texlive/2014/texmf-dist/tex/latex/misc/NEWSTY/`
2. don't forget to set after finishing the operation below: `$ sudo mktexlsr`

* `kpsewhich --expand-path='$TEXMFLOCAL'`

	> `/usr/local/texlive/texmf-local`
* `kpsewhich --progname=platex jarticle.cls`

	> `/usr/local/texlive/2014/texmf-dist/tex/platex/base/jarticle.cls`

### maybe ok
create directory and set sty file (e.g. STYLE.sty)

1. move to the directory where the style file is placed

2. `$ sudo mkdir -p -v /usr/local/texlive/2014/texmf-dist/tex/latex/misc/STYLE`

3. `$ sudo mv STYLE.sty /usr/local/texlive/2014/texmf-dist/tex/latex/misc/STYLE`

#### Reference
* http://emath.a.la9.jp/ydir/Wiki/index.php?emath.sty%A4%CE%C3%D6%A4%AD%BE%EC%BD%EA
* https://texwiki.texjp.org/?TeX%20%E3%81%AE%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%E6%A7%8B%E6%88%90
* https://texwiki.texjp.org/?LaTeX%E5%85%A5%E9%96%80%2F%E5%90%84%E7%A8%AE%E3%83%91%E3%83%83%E3%82%B1%E3%83%BC%E3%82%B8%E3%81%AE%E5%88%A9%E7%94%A8
* http://demmys.hatenablog.com/entry/2012/06/06/234808

## Handling file through terminal
* create files: `touch [filename]`
* remove files: `rm -Rf [filename]` or `rm -R [filename]`
* move files: at the directory where the file exists`mv [filename] [destination]`
* (In `zsh`) move first 100 files: `$ mv -- *([1,100]) /other/location/`
* You can also change name of file by `mv`: `$ mv "old location" "new location"`
* double dots to move up the directory: `$ cd ..`
* double dots to move directory part 2
 
```
- home
	- sub1 - sub1_1
	- sub2 - sub2_1
```
To move from `sub2` to `sub1_1`

```
~/sub1_1 $ cd ../sub1/sub1_1
```

To move from `sub2_1` to `sub1_1`

```
~/sub2_1 $ cd ../../sub1/sub1_1
```

## ssh connections
* How to connect
```
$ usrname@ipaddress
or 
$ usrname@hostname
```

* How to download and upload files
__Be sure that you have to be at your local environment__

```
# local to remote
scp /local/file/path usrname@host:/save/path
scp /local/test.txt user@remoteHost:/home/user/tmp/

# remote to local
scp usrname@host:/moving/file/path /local/path 
scp user@remoteHost:/home/user/test.txt /local/path

# moving whole directory
scp -r user@remoteHost:/remote/dir /local/dir
```

## Install pip in remote computer locally
* Reference [here][2].

1. Download `wget https://bootstrap.pypa.io/get-pip.py`
2. `python get-pip.py --user`. This will install pip to your local directory `(.local/bin)`.
3. Set path. Write `PATH=$PATH:~/.local/bin` in your `.bash_profile`.

## Install pyenv in remote computer locally
* Reference [here][3], [here][4], [here][5].

1. `$ git clone https://github.com/pyenv/pyenv.git ~/.pyenv`. Be aware of your directory installing the `pip`.
2. `$ echo 'export PYENV_ROOT="/home/usrname/.pyenv"' >> ~/.bash_profile`. I changed `$HOME/.pyenv` to `/home/usrname/.pyenv`. `usrname` part could be any directory.
3. `$ echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bash_profile`.
4. `$ echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bash_profile`
5. `source .bash_profile`
6. Start! (`$ pyenv` will show you the options).


## Read text files in terminal with less
### Options
* `-F`: 行数が短くて位置画面に収まる場合は less がすぐに終了する。
* `--help`: ヘルプ表示
* `-i`: 検索モードでキーワードをすべて小文字で入力した場合に、大文字小文字の区別をしない。 検索キーワードに大文字が混ざっていた場合にはこのオプションをつけていても大文字小文字を区別する。
* `-N`: 行番号を表示する。(`cat` でこれに相当するのは `-n`)
* `-r`: エスケープシーケンスなどのバイナリをエスケープシーケンスとして解釈せずに、 そのまま出力される。
* `-R`: 色のエスケープシーケンスをそのとおりに解釈して 色付きで表示する。 色以外のエスケープシーケンスは解釈せず、 そのまま出力される。 `ls` は `--color`、 `grep` は `--color=always` を付けると 色付きで出力される。
* `-S`: 長い行を折り返さずに横方向にもページングできるようにする。 各行の左の方だけ見えれば十分な場合にもこのオプションは便利。
* `--version`: バージョン表示
* `-X`: `less` 終了時に画面をクリアしない。

-- というパラメータを渡すとそれ以降のパラメータをオプションではなくファイル名とみなしてくれるので、 - で始まるファイル名を扱いたい場合に使うとよい。


### command while reading a file
* `q`: `less`コマンドを終了
* `SPACE`: 1画面分下にスクロール
* `f`: 1画面分下にスクロール
* `b`: 1画面分上にスクロール
* `g`: ファイルの先頭に移動
* `Shift + <`: ファイルの先頭に移動
* `Shift + G`: ファイルの最後に移動
* `Shift + >`: ファイルの最後に移動

### Reference
[here](https://hydrocul.github.io/wiki/commands/less.html)



# Dealing with pics
## Jpegoptim
https://github.com/tjko/jpegoptim

Optimize the size of png and jpeg.

e.g. `jpegoptim --strip-all --max=90 test.jpg`
* `--strip-all`: erase all meta data
* `--max=90`: 90% of the quality
* `*.jpg`: set wild card to optimize multiple files

# Use Gmail in China
http://kinto-un.hatenablog.com/entry/2015/02/15/152313

# Finder easier path
* Use [Finderpath][1]

[0]:https://stackoverflow.com/questions/6481005/how-to-obtain-the-number-of-cpus-cores-in-linux-from-the-command-line
[1]:https://bahoom.com/finderpath/
[2]:https://gist.github.com/saurabhshri/46e4069164b87a708b39d947e4527298
[3]:https://github.com/pyenv/pyenv
[4]:https://github.com/Shusei-E/Code_Tips/blob/master/MacOS/SettingEnvironment.md
[5]:https://qiita.com/maskedw/items/aaa2fd7abfd493cf2820
