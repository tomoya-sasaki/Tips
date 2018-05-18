# Window
### Macのタスク切り替えで、最小化されたウィンドウを表示する方法

<kbd>Command</kbd> + <kbd>Tab</kbd> でアプリを選択した後、<kbd>Option</kbd>を押して<kbd>Command</kbd>を離す

# Pandoc
* Create a table of index
* `--toc` method to create a table of index. 
* You need to specify `-s` to produce a standalone document with table of contents

```
$ pandoc -s --toc happiness.txt -o happiness.html
```