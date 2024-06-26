
## Theme
* Choose from [here](http://deic.uab.es/~iblanes/beamer_gallery/).

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

## Overlay
* In the following code, characteristics of each animal appear one by one in the same page

```
\documentclass{beamer}

\begin{document}

\begin{frame}
\begin{block}{Pets}
\begin{overlayarea}{\textwidth}{6cm}
\begin{itemize}
    \item<2-> \strut Cats
    \only<3>{\begin{itemize}
        \item \strut Lazy
        \item \strut Cuddly
    \end{itemize}}
    \item<4-> \strut Goldfish
    \only<5>{\begin{itemize}
        \item<5> \strut Wet
        \item<5> \strut Lives in pond
    \end{itemize}}
    \item<6-> \strut Birds
    \only<7>{\begin{itemize}
        \item<7> \strut Fly
        \item<7> \strut Have feathers
    \end{itemize}}
\end{itemize}
\end{overlayarea}
\end{block}

\end{frame}

\end{document}
```

## When you use `minipage`
1. A new paragraph is started with the first minipage, which adds the indent. -> `\noindent`
2. No space between the two minipages. Add `%`.

```
\documentclass[draft=on]{scrbook}
\usepackage{blindtext}

\begin{document}
\noindent
\begin{minipage}{.5\textwidth}
  TEXT 1
\end{minipage}% This must go next to `\end{minipage}`
\begin{minipage}{.5\textwidth}
  TEXT 2
\end{minipage}
\end{document}
```

## `textblock`/`block`
```
% この場合は (230pt, 100pt) の位置に 0.4\linewidth の幅のブロックができる．
\begin{textblock*}{0.4\linewidth}(230pt, 100pt)
    \centering
    \includegraphics[width=\linewidth]{./figure.pdf}
\end{textblock*}
```

## Format
#### Remove footer

```
% gets rid of bottom navigation bars
\setbeamertemplate{footline}[frame number]{}

% gets rid of bottom navigation symbols
\setbeamertemplate{navigation symbols}{}

% gets rid of footer
% will override 'frame number' instruction above
% comment out to revert to previous/default definitions
\setbeamertemplate{footline}{}
```
#### Remove header

```
\setbeamertemplate{headline}{}
```


## Table
#### Numbering figures

```
\setbeamertemplate{caption}[numbered]

```
## Button
#### Place button at the left bottom

```
\documentclass{beamer}
%\usepackage{textpos}
\usepackage{tikz}
\setbeamertemplate{navigation symbols}{}

\begin{document}

\begin{frame}[plain,fragile,label=here]
\begin{center}
\includegraphics[width=3in,height=3in]{crocuses}
\end{center}
\begin{tikzpicture}[remember picture, overlay]
\node[shift={(-0.6cm,0.5cm)}]() at (current page.south east){%
\hyperlink{there}{\beamerbutton{Back}}};
\end{tikzpicture}
\end{frame}

\begin{frame}[fragile,label=there]{test}

text
\begin{tikzpicture}[remember picture, overlay]
\node[shift={(-0.6cm,0.5cm)}]() at (current page.south east){%
\hyperlink{here}{\beamerbutton{Back}}};
\end{tikzpicture}

\end{frame}
\end{document}
```

* If you want the botton to be the left

```
\hfill\hyperlink{here}{\beamerbutton{Back}}
```

## Japanese
* Check [here](https://qiita.com/zr_tex8r/items/69e8cc32038ff29f5ac3)
* [here](http://neurodynamics.jp/etc/beamer), or [here](https://en.wikibooks.org/wiki/LaTeX/Presentations##Themes) might be also useful.

