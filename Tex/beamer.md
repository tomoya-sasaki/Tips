# General tips
* Japanese:[here][1], [here][2], or [here][3].

# Theme
* Choose from [here][4].

# Overlay
* In the following code, characteristics of each animal appear one by one

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

# When you use `minipage`
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

# `textblock`/`block`
```
% この場合は (230pt, 100pt) の位置に 0.4\linewidth の幅のブロックができる．
\begin{textblock*}{0.4\linewidth}(230pt, 100pt)
    \centering
    \includegraphics[width=\linewidth]{./figure.pdf}
\end{textblock*}
```

# Format
## Remove footer

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

[1]:http://ayapin-film.sakura.ne.jp/LaTeX/Slides/guide4beamer.pdf
[2]:http://neurodynamics.jp/etc/beamer
[3]:https://en.wikibooks.org/wiki/LaTeX/Presentations#Themes
[4]:http://deic.uab.es/~iblanes/beamer_gallery/

