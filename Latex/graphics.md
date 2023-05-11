## Put four figures
```
\documentclass{article}

\usepackage{graphicx}
\usepackage{subcaption}
\usepackage{mwe}

\begin{document}
    \begin{figure*}
        \centering
        \begin{subfigure}[b]{0.475\textwidth}
            \centering
            \includegraphics[width=\textwidth]{Example-Image}
            \caption[Network2]%
            {{\small Network 1}}    
            \label{fig:mean and std of net14}
        \end{subfigure}
        \hfill
        \begin{subfigure}[b]{0.475\textwidth}  
            \centering 
            \includegraphics[width=\textwidth]{Example-Image}
            \caption[]%
            {{\small Network 2}}    
            \label{fig:mean and std of net24}
        \end{subfigure}
        \vskip\baselineskip
        \begin{subfigure}[b]{0.475\textwidth}   
            \centering 
            \includegraphics[width=\textwidth]{Example-Image}
            \caption[]%
            {{\small Network 3}}    
            \label{fig:mean and std of net34}
        \end{subfigure}
        \quad
        \begin{subfigure}[b]{0.475\textwidth}   
            \centering 
            \includegraphics[width=\textwidth]{Example-Image}
            \caption[]%
            {{\small Network 4}}    
            \label{fig:mean and std of net44}
        \end{subfigure}
        \caption[ The average and standard deviation of critical parameters ]
        {\small The average and standard deviation of critical parameters: Region R4} 
        \label{fig:mean and std of nets}
    \end{figure*}
\end{document}
```

## Change the position when you use minipage
```
\mbox{\raisebox{-30mm}{\includegraphics[width=35mm]{aaaa.eps}}}

% When you want outer frame box
\fbox{\raisebox{-30mm}{\includegraphics[width=35mm]{aaaa.eps}}}
```

## Manually add caption
* Also effective in beamer, where you cannot use minipage

```
\documentclass{beamer}
\begin{document}
\begin{frame}
\begin{columns}[T] % align columns
\begin{column}{.48\textwidth}
\color{red}\rule{\linewidth}{4pt}

Left Part
\end{column}%
\hfill%
\begin{column}{.48\textwidth}
\color{blue}\rule{\linewidth}{4pt}

Right Part
\end{column}%
\end{columns}
\end{frame}
\end{document}
```



## LaTeXで横長の表を90度回転させて配置する方法
今、ある論文をLaTeXを用いて書いています。
表を入れたいのですが、大きくて、横にしなければ入りません。
LaTeXでどうすればいいのか調べました。
ポイントは2つ。
最初に、プリアンブルに

```
\usepackage{lscape}
```
を記載すること。

次に、横にしたいところで、

```
\begin{landscape}
\end{landscape}
```
とすること。

シンプルな解決方法ですっきりしました。

