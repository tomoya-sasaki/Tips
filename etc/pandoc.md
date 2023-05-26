# Pandoc
## Create a table of index
* `--toc` method to create a table of index.
* You need to specify `-s` to produce a standalone document with table of contents

```
$ pandoc -s --toc happiness.txt -o happiness.html
```

## Create a pdf
* No page number: `-V pagestyle=empty`
* Landscape: `-V geometry:landscape`

```
pandoc sample.md -V pagestype=empty -V geometry:landscape -0 sample.pdf
```