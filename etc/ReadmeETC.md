# Dealing with pics
## Jpegoptim
https://github.com/tjko/jpegoptim

Optimize the size of png and jpeg.

e.g. `jpegoptim --strip-all --max=90 test.jpg`
* `--strip-all`: erase all meta data
* `--max=90`: 90% of the quality
* `*.jpg`: set wild card to optimize multiple files

## When you want to use ColorSync
* Right click the PDF file you desire to work with and then select "Open with..."
* Select the "Colorsync Utility" application

# Use Gmail in China
http://kinto-un.hatenablog.com/entry/2015/02/15/152313

# Finder easier path
* Use [Finderpath][1]

# Convert html to pdf or img

```
$ wkhtmltopdf [html file] [name of pdf file]
$ wkhtmltoimage [html file] [name of img file]
```

# Bash
* bash のワイルドカードの「*」には隠しファイル（ドットファイル）は含まれません

# Google Search

## Language setting

1. Web interface language: `hl=`
Example: `www.google.com/search?q=vilnius&hl=lt`

2. Pages in specified language: `lr=lang_`
Example: `www.google.com/search?q=vilnius&lr=lang_lt`

3. Pages originating from specified country: `cr=country`
Example: `www.google.com/search?q=vilnius&cr=countryLT`
Note that the two country code characters have to be in UPPERCASE ! Otherwise Google ignores the parameter (as of 2017-01-03) (even though lower case works fine for hl= and lr=lang_).

There is another parameter - gl= - for search results as they would appear in specified country. I tried testing it, but for me results were not differing for different parameter values. Maybe that's obsolete or overwritten by some other paremeters/settings of browser or my Google account.

# Pandoc
* Create a table of index
* `--toc` method to create a table of index. 
* You need to specify `-s` to produce a standalone document with table of contents

```
$ pandoc -s --toc happiness.txt -o happiness.html
```



[0]:https://stackoverflow.com/questions/6481005/how-to-obtain-the-number-of-cpus-cores-in-linux-from-the-command-line
[1]:https://bahoom.com/finderpath/
[2]:https://gist.github.com/saurabhshri/46e4069164b87a708b39d947e4527298
[3]:https://github.com/pyenv/pyenv
[4]:https://github.com/Shusei-E/Code_Tips/blob/master/MacOS/SettingEnvironment.md
[5]:https://qiita.com/maskedw/items/aaa2fd7abfd493cf2820
