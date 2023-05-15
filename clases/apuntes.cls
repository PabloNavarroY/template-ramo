\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{apuntes}[2023/01/01 Apuntes]
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
\RequirePackage[utf8]{inputenc}
\RequirePackage[spanish]{babel}
\RequirePackage[T1]{fontenc}
\RequirePackage{lmodern}
\RequirePackage[margin=1in]{geometry}

\RequirePackage{amsmath,amssymb,amsthm}
\RequirePackage{mathtools}

\RequirePackage{enumitem}
\RequirePackage{needspace} % needspace for dynamic line breaking
\RequirePackage{hyperref} % for pdf bookmarks, other information and org-mode
\RequirePackage{ifthen}
\RequirePackage{etoolbox}
\RequirePackage{fancyhdr}
\RequirePackage{tikz}

% Custom packages
\RequirePackage{math-macros}
\RequirePackage{math-environments}
\RequirePackage{fancy-dates}

\RequirePackage{subfiles}

\hypersetup {
  pdfstartview=FitH,
  colorlinks=false
}

\AtBeginDocument{
  \hypersetup {
    pdftitle={\@class \@title},
    pdfauthor={\@author},
    pdfsubject={Apuntes}
  }
}


\gdef\@author{\empty}
\gdef\@class{\empty}
\gdef\@profesor{\empty}
\gdef\@ayudante{\empty}
\gdef\@imprimir{\empty}
\renewcommand{\author}[1]{\gdef\@author{#1}}
\newcommand{\class}[1]{\gdef\@class{#1}}
\newcommand{\profesor}[1]{\gdef\@profesor{#1}}
\newcommand{\ayudante}[1]{\gdef\@ayudante{#1}}
\newcommand{\imprimir}[1]{\gdef\@imprimir{#1}}

\newcommand{\siimprimir}[2]{\ifthenelse{\equal{\@imprimir}{\empty}}{#2}{#1}}

\fancypagestyle{firstpagestyle}
{
   \fancyhf{}
   \renewcommand{\headrulewidth}{0pt}
}
\fancypagestyle{generalpagestyle}
{
   \fancyhf{}
   \renewcommand{\headrulewidth}{.5pt}
   \fancyhead[L]{\footnotesize \@class\ - \@title}
   \fancyhead[R]{\footnotesize \@author}
   \fancyfoot[R]{\thepage}
}
\pagestyle{generalpagestyle}

\renewcommand{\maketitle} {
  \thispagestyle{firstpagestyle}
  \begin{center}
    \textbf{\scriptsize\@class}\par
    \textbf{\Large\@title}\par
    \begin{tikzpicture}
      \draw[thick] (-1.5,0) -- (-.4,0);
      \filldraw (.1,0) -- (0,.1) -- (-.1,0) -- (0,-.1) -- cycle;
      \draw[thick] (.4,0) -- (1.5,0);
    \end{tikzpicture}
    \par
    \textsc{\@author}\par
    \vspace*{4ex}
    {\textbf{Profesor:} \@profesor}\par
    {\textbf{Ayudante:} \@ayudante}\par
    \vspace*{4ex}
    {\small\@date}
  \end{center}

  % Tablas de contenidos
  \tableofcontents
  \thispagestyle{firstpagestyle}
  \listofclases
  \thispagestyle{firstpagestyle}
  \siimprimir{}{\newpage}
}


% --------- Lists ---------
\newlist{enumroman}{enumerate}{1}
\setlist[enumroman, 1]{label=(\roman*)}
\newlist{enumalph}{enumerate}{1}
\setlist[enumalph, 1]{label=(\alph*)}

% --------- Commands ---------
\newcommand{\onlyinsubfile}[1]{#1}
\newcommand{\notinsubfile}[1]{}
