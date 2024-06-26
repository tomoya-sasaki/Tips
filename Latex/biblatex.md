# Biblatex

## Add `.bst` file and `.bib`
* Add `.bst` file and `.bib` file under `texmf` folder
* Create a new folder if it does not exist

```
# bib
/Users/tomoyasasaki/Library/texmf/bibtex/bib/

# bst
/Users/tomoyasasaki/Library/texmf/bibtex/bst/
```

## Date and Year
* Exclude date and year from bibliography
```
\DeclareSourcemap{
  \maps[datatype=bibtex]{
    \map{
      \step[fieldset=month, null]
      \step[fieldsource=date, match=\regexp{([0-9]{4})-([0-9]{2})(-[0-9]{2})?}, replace={1}]
    }
  }
}
```

## Eprint
* Exclude eprint from bibliography (arxiv ID, DOI etc)
```
\usepackage[%
eprint = false, %exclude arxiv ID
doi = false, %exclude DOI
isbn = false %exclude isbn
]{biblatex-chicago} 
```

## Sort bib file
* Use `bibtool`. Install with brew.
* [Link](https://tex.stackexchange.com/questions/426341/using-bibtool-to-sort-a-bib-file-by-types-and-keys-alphabetically)

```
% by key (within each type, sorted with key)
bibtool -s --sort.format='{%s($key)}' -i bibsort.bib -o bibsorted.bib
% sort with two variables
bibtool -s --sort.format='{%s($type) %s($key)}' -i bibsort.bib -o bibsorted.bib
```

## Font size of reference

* Check [here](https://tex.stackexchange.com/questions/474994/biblatex-biber-atnextbibliography-and-fontsize) and [here](https://tex.stackexchange.com/questions/205432/with-biblatex-how-do-i-make-the-fontsize-of-the-bibliography-smaller)

```
\renewcommand*{\bibfont}{\normalfont\small}
```

## The section name for biliography
* Change section name

```
\printbibliography[title=Mein Titel]

```

* No section name

```
\printbibliography[heading=none]

```

## Error messages

### Cannot run `biber`
* First solution: delete cache in the location that `biber --cache` returns. Reference [here](https://tex.stackexchange.com/questions/579291/biber-exiting-with-error-code-2-but-no-error-messages)

* You probably need to update the entire MacTex with `brew` or other methods if you see the following errors
* This message probably implies that there are incompatibility between biber and biblatex versions
* References [here](https://bbs.archlinux.org/viewtopic.php?id=278226), [here](https://tex.stackexchange.com/questions/286706/troubleshooting-for-biber), [here](https://tex.stackexchange.com/questions/633088/biber-biblatex-error-after-update)

```
LaTeX Warning: There were undefined references.

Package biblatex Warning: Please (re)run Biber on the file:
(biblatex)                test
(biblatex)                and rerun LaTeX afterwards.
```