# Terminal
## `fg` and `bg`
* place a job in front or background
* `bg` or <kbd>ctrl</kbd>+<kbd>z</kbd>

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

## Open Finder

* Open home directory
```
$ open ~ 
```

* Open current directory
```
$ open .
```

## Show files with time of modification

```
ls --full-time
ls -l --time-style=full-iso

ls -l --time-style=+"%Y %H:%M:%S"
```

* In OSX, `ls -lT` also works

## Check time zone
* [here](https://www.tecmint.com/check-linux-timezone/)

```
$ date
$ date +"%Z %z"
$ timedatectls
$ timedatectls | grep "Time zone"
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
```SonDirectory

### "flatten" directory. 
* Move files in subdirectories to its parent directories
* When you want to move from this (or `ParentDirectory $ find . -type f`)

```
GrandParentDirectory $ find ~/ParentDirectory/ -type f
~/ParentDirectory/rooty.jpg
~/ParentDirectory/SonDirectory1/beta-tool-preview.jpg
~/ParentDirectory/SonDirectory2/test-tools.jpg
~/ParentDirectory/SonDirectory3/test-png.jpg
~/ParentDirectory/SonDirectory3/test1.jpg
```
to this

```
GrandParentDirectory $ find ~/ParentDirectory/ -type f
~/ParentDirectory/rooty.jpg
~/ParentDirectory/beta-tool-preview.jpg
~/ParentDirectory/test-tools.jpg
~/ParentDirectory/test-png.jpg
~/ParentDirectory/test1.jpg
```

```
GrandParentDirectory $ find ParendDirectory/ -mindepth 2 -type f -exec mv -i '{}' ParendDirectory/ ';'
```

### `unzip`
* If your file is too large, you may not be able to unzip using apps such as unarchiver [here](https://apple.stackexchange.com/questions/135853/error-opening-a-zip-file-no-such-file-or-directory)
* Use `unzip`

```
unzip ~/filelocation/filename.zip -d ~/whereunzipfilegoes
```

* If the zipped file needs repair

```
zip -FF ~/Downloads/filename.zip --out ~/Downloads/Repairedversion.zip
unzip ~/Repairedversion.zip -d ~/whereunzipfilegoes
```

## ssh connections
* How to connect
```
$ usrname@ipaddress
or 
$ usrname@hostname
```

* How to transfer files
* __Be sure that you have to be at your local environment__

```
# Syntax 
scp [options] username1@source_host:directory1/filename1 username2@destination_host:directory2/filename2

# Example
# you can skip the account of the host computer 
# if you are logged in
scp usrname@host:/moving/file/path /local/path 
scp /local/path user@remoteHost:/home/user/test.txt 

# moving whole directory
scp -r user@remoteHost:/remote/dir /local/dir
```
## `screen` method
### Basic
* Change to new "screen" [here](https://www.utakata.work/entry/2017/11/23/100000)

```
$ ssh target-server
[username@target-server ~]$ screen
[username@target-server ~]$
```

* To move back, <kbd>Ctrl</kbd> + <kbd>a</kbd> then <kbd>Ctrl</kbd> + <kbd>d</kbd>

```
[username@target-server ~]$ screen
[detached]
[username@target-server ~]$
```

* To check the list of "screens"

```
[username@target-server ~]$ screen -ls
There are screens on:
    5689.pts-10.target-server(Detached)
1 Sockets in /var/run/screen/S-username
```

* To exit/quit

```
[username@target-server ~]$ exit
[screen is terminating]
[yoshiyuki_sakamoto@nv-sysmanage01 ~]$
```

### `quit` screen method outside the screen
* send a 'quit' command:

```
screen -X -S "sessionname" quit
```

* send a Ctrl-C to a screen session running a script:

```
screen -X -S "sessionname" stuff "^C"
```

* Kill multiple sessions

```
screen -ls | grep pts | cut -d. -f1 | awk '{print $1}' | xargs kill
```

* Kill (multiple) detached sessions

```
screen -ls | grep Detached | cut -d. -f1 | awk '{print $1}' | xargs kill
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

# Window
### Macのタスク切り替えで、最小化されたウィンドウを表示する方法

<kbd>Command</kbd> + <kbd>Tab</kbd> でアプリを選択した後、<kbd>Option</kbd>を押して<kbd>Command</kbd>を離す


# Mac Dock Navigation Keyboard Shortcuts
Here are eight must-know keystrokes for navigating the Mac Dock. Note you must first summon the Dock with the keyboard navigation enabled, which is the first tip. From then on, you can use the additional keyboard navigation tricks.

* <kbd>Control</kbd>+<kbd>Function</kbd>+<kbd>F3</kbd> to summon the Dock with keyboard navigation enabled, works even if the Dock is hidden by default
* <kbd>&larr;</kbd> & <kbd>&rarr;</kbd> to move within the Dock items
* <kbd>&uarr;</kbd> to pull open the Dock items menu, the same as right-click
* Return key to launch the currently selected app
* Use keyboard letters to jump to apps by first letter of the app name
* Hold <kbd>Option</kbd> key while navigating to, then hit the Up Arrow key to access Force Quit
* <kbd>Command</kbd>+<kbd>Return</kbd> to reveal the Dock item in the Finder
* <kbd>Command</kbd>+<kbd>Option</kbd>+<kbd>Return</kbd> to hide all other apps and windows except for the selected Dock item

# Prevent sleep
* `caffeinate` may work [here](https://computers.tutsplus.com/tutorials/quick-tip-how-to-stop-your-mac-from-sleeping-using-the-command-line--mac-50905)

```
$ caffeinate
R
```

* Type `caffeinate` before starting `R` or `Python` may work