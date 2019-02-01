# Set path
* See [ReadmeETC.md](https://github.com/UT-GLP-2014/TMY/blob/master/code_tips/etc/ReadmeETC.md) in `~/code_tips/etc/` 
# Beamer
## When you want to use `minipage` in beamer
* use `\begin{column}`

``` 
\begin{columns}[T]
	\begin{column}{0.48\textwidth}
	\end{column}{0.48\textwidth}
	
	\begin{column}{0.48\textwidth}
	\end{column}{0.48\textwidth}
\end{columns}
```

# `ascmac.sty`
When you use `itembox` or `screen` with `Xelatex` or `LuaLatex` (maybe applicable to other systems as well).
See [here](1)

```
\usepackage{ascmac}
\newdimen\tbaselinshift
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
See [here](2)

# General stuff
## To make math symbols in section title bold

```
\makeatletter
\g@addto@macro\bfseries{\boldmath}
\makeatother
```

[1]:http://akitsu-sanae.hatenablog.com/entry/2017/09/25/134202
[2]:http://blog.livedoor.jp/ti5942/?p=63