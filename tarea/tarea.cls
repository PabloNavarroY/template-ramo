\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tarea}[2023/01/01 Tarea]
\def\hw@papersize{letterpaper}
\DeclareOption{letterpaper}{\def\hw@papersize{letterpaper}}
\DeclareOption{legalpaper}{\def\hw@papersize{legalpaper}}
\def\hw@ptsize{12pt} % https://tex.stackexchange.com/a/634138/215221
\DeclareOption{10pt}{\def\hw@ptsize{10pt}}
\DeclareOption{11pt}{\def\hw@ptsize{11pt}}
\DeclareOption{12pt}{\def\hw@ptsize{12pt}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[\hw@papersize, \hw@ptsize]{article}
\RequirePackage[margin=1in]{geometry}
\RequirePackage[utf8]{inputenc}
\RequirePackage[spanish]{babel}
\RequirePackage[T1]{fontenc}
\RequirePackage{lmodern}

\RequirePackage{amsmath,amssymb,amsthm}
\RequirePackage{mathtools}
\RequirePackage{cancel}

\RequirePackage{enumitem}
\RequirePackage{needspace} % needspace for dynamic line breaking
\RequirePackage{hyperref} % for pdf bookmarks, other information and org-mode
\RequirePackage{ifthen}
\RequirePackage{fancyhdr}
\RequirePackage{math-environments}
\RequirePackage{math-macros}
\RequirePackage{subfiles}

\hypersetup {
  pdfstartview=FitH,
  colorlinks=false
}

\AtBeginDocument{
  \hypersetup {
    pdftitle={\@title},
    pdfauthor={\@author},
    pdfsubject={\@class}
  }
}


\gdef\@author{\empty}
\gdef\@class{\empty}
\gdef\@profesor{\empty}
\gdef\@ayudante{\empty}
\renewcommand{\author}[1]{\gdef\@author{#1}}
\newcommand{\class}[1]{\gdef\@class{#1}}
\newcommand{\profesor}[1]{\gdef\@profesor{#1}}
\newcommand{\ayudante}[1]{\gdef\@ayudante{#1}}

\fancypagestyle{firstpagestyle}
{
   \fancyhf{}
   \renewcommand{\headrulewidth}{0pt}
   \fancyfoot[R]{\footnotesize \thepage}
}
\fancypagestyle{generalpagestyle}
{
   \fancyhf{}
   \renewcommand{\headrulewidth}{.5pt}
   \fancyhead[L]{\footnotesize \@title}
   \fancyhead[R]{\footnotesize \@class}
   \fancyfoot[R]{\thepage}
}
\pagestyle{generalpagestyle}

\renewcommand{\maketitle} {
  % Left side
  \noindent
  \begin{minipage}{.6\linewidth}
    \noindent\ifthenelse{\equal{\@class}{\empty}}{}{\textbf{\@class}\par}
    \noindent\ifthenelse{\equal{\@profesor}{\empty}}{}{\textbf{Profesor:} \@profesor\par}
    \noindent\ifthenelse{\equal{\@ayudante}{\empty}}{}{\textbf{Ayudante:} \@ayudante\par}
    \vfill
  \end{minipage}
  \hfill
  % Right side
  \begin{minipage}{.3\linewidth}
    \begin{flushright}
      \noindent\ifthenelse{\equal{\@author}{\empty}}{}{\@author\par}
      \noindent\@date\par
    \end{flushright}
    \vfill
  \end{minipage}
  \vspace*{1ex}
  \begin{center}
    \Large\textbf{\@title}
  \end{center}
  \vspace*{-6ex}
  \listofpreguntas
  \thispagestyle{firstpagestyle}
  \vspace*{1ex}
}


% --------- Lists ---------
\newlist{enumroman}{enumerate}{1}
\setlist[enumroman, 1]{label=(\roman*)}
\newlist{enumalph}{enumerate}{1}
\setlist[enumalph, 1]{label=(\alph*)}

% --------- Commands ---------
\newcommand{\onlyinsubfile}[1]{#1}
\newcommand{\notinsubfile}[1]{}
