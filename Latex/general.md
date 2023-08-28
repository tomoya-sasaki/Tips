# Set path
* See [ReadmeETC.md](https://github.com/UT-GLP-2014/TMY/blob/master/code_tips/etc/ReadmeETC.md) in `~/code_tips/etc/`

# `ascmac.sty`
When you use `itembox` or `screen` with `Xelatex` or `LuaLatex` (maybe applicable to other systems as well).
See [here](http://akitsu-sanae.hatenablog.com/entry/2017/09/25/134202)

```
\usepackage{ascmac}
\newdimen\tbaselinshift
```

## Title
### Remove the space between the title and the top
* Reference [here](https://tex.stackexchange.com/questions/123374/reduce-space-at-the-top-using-maketitle)

```
\title{\vspace{-60pt}Title}
```


# `titlesec.sty`
* If you want to change the font size of each section

```
\titleformat*{\section}{\LARGE\bfseries}
\titleformat*{\subsection}{\Large\bfseries}
\titleformat*{\subsubsection}{\large\bfseries}
```
* If you want to stuck the space between the sections

```
\usepackage[compact]{titlesec}
```

# Texmaker
See [here](http://blog.livedoor.jp/ti5942/?p=63)

# Compile separately
* Use `subfiles.sty` ([example](https://tex.stackexchange.com/questions/7052/how-do-i-choose-which-sections-to-compile-from-a-latex-document))
* `main.tex` for the main document
* Tex file for each section (e.g. `sec1.tex`, `sec2.tex` ...)

```
% this is main.tex
\documentclass{article}
\usepackage{subfiles} % write this at the end of preamble
\begin{document}
  \subfile{sec1}
  \subfile{sec2}
\end{document}
```

* Create latex files for each section

```
\documentclass[main.tex]{subfiles}
\begin{document}
  \section{Methods}
\end{document}
```

# Font size
```
Command             10pt    11pt    12pt
\tiny               5       6       6
\scriptsize         7       8       8
\footnotesize       8       9       10
\small              9       10      10.95
\normalsize         10      10.95   12
\large              12      12      14.4
\Large              14.4    14.4    17.28
\LARGE              17.28   17.28   20.74
\huge               20.74   20.74   24.88
\Huge               24.88   24.88   24.88
```

# Miscellaneous
## To make math symbols in section title bold

```
\makeatletter
\g@addto@macro\bfseries{\boldmath}
\makeatother
```

## Checkmark

```
\documentclass{article}
\usepackage{amssymb}
\usepackage{bbding}
% \usepackage{dingbat}
\usepackage{pifont}
\usepackage{wasysym}

\begin{document}

% amssymb
\checkmark

% bbding
\Checkmark
\CheckmarkBold

% dingbat
% \checkmark

% pifont
\ding{51}
\ding{52}

% wasysym
\CheckedBox

\end{document}
```
## Text aligned left/center/right

```
\documentclass{article}

\newcommand\textbox[1]{%
  \parbox{.333\textwidth}{#1}%
}

\begin{document}

% left and right
\noindent Left longer sample simple \hfill Right

% left, center, and right
\noindent\textbox{Left longer sample text\hfill}\textbox{\hfil Center\hfil}\textbox{\hfill Right}

\end{document}
```


