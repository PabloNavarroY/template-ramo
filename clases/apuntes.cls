\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{apuntes}[2023/01/01 Apuntes]
\def\hw@papersize{letterpaper}
\DeclareOption{letterpaper}{\def\hw@papersize{letterpaper}}
\DeclareOption{legalpaper}{\def\hw@papersize{legalpaper}}
\def\hw@ptsize{12pt} % https://tex.stackexchange.com/a/634138/215221
\DeclareOption{10pt}{\def\hw@ptsize{10pt}}
\DeclareOption{11pt}{\def\hw@ptsize{11pt}}
\DeclareOption{12pt}{\def\hw@ptsize{12pt}}
\def\hw@font{lmodern}
\DeclareOption{concrete}{\def\hw@font{concrete}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[\hw@papersize, \hw@ptsize]{article}


\RequirePackage[utf8]{inputenc}
\RequirePackage[spanish]{babel}

\RequirePackage{ifthen}

% Font stuff
\RequirePackage[T1]{fontenc}
% --------- lmodern ---------
% \RequirePackage{lmodern}
% --------- concrete ---------
% \RequirePackage{concrete}
% \RequirePackage{beton}
% \RequirePackage{euler}
% \renewcommand{\bfdefault}{sbc}
% --------- libertinus ---------
\RequirePackage{libertinus}
\RequirePackage{libertinust1math}

\RequirePackage{amsmath,amssymb,amsthm}
\RequirePackage{mathtools}

% Custom packages
\RequirePackage{math-macros}
\RequirePackage{math-environments}
\RequirePackage{fancy-dates}
\RequirePackage{todolist}


\RequirePackage[margin=1in]{geometry}

\RequirePackage{enumitem}
\RequirePackage{needspace} % needspace for dynamic line breaking
\RequirePackage{hyperref} % for pdf bookmarks, other information and org-mode
\RequirePackage{etoolbox}
\RequirePackage{fancyhdr}
\RequirePackage{tikz}
\usetikzlibrary{calc}
\RequirePackage{tikz-cd}

\RequirePackage{subfiles}

\hypersetup {
  pdfstartview=FitH,
  colorlinks=true
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
\gdef\@emailprofesor{\empty}
\gdef\@ayudante{\empty}
\gdef\@emailayudante{\empty}
\gdef\@imprimir{\empty}
\renewcommand{\author}[1]{\gdef\@author{#1}}
\newcommand{\class}[1]{\gdef\@class{#1}}
\newcommand{\profesor}[1]{\gdef\@profesor{#1}}
\newcommand{\emailprofesor}[1]{\gdef\@emailprofesor{#1}}
\newcommand{\ayudante}[1]{\gdef\@ayudante{#1}}
\newcommand{\emailayudante}[1]{\gdef\@emailayudante{#1}}
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

\newcommand{\titleformat}[1]{\textbf{\Large{#1}}}
\newcommand{\siglaformat}[1]{\textbf{\scriptsize{#1}}}
\newcommand{\authorformat}[1]{\textsc{\normalsize{#1}}}
\newcommand{\dateformat}[1]{\small{#1}}
\renewcommand{\maketitle} {
  \thispagestyle{firstpagestyle}
  \begin{center}
    \begin{tikzpicture}
      % Título y sigla
      \node at (0,0) (T) {\titleformat{\@title}};
      \draw let
      \p1 = ($(T.south) - (0,.2)$),
      \n1 = {-veclen(\p1)},
      \p2 = ($0.6*(T.east)$),
      \n2 = {veclen(\p2)}
      in
      [thick] (-\n2,\n1) -- (\n2,\n1) node (S) [midway, fill=white]{\siglaformat{\@class}};
      % Autor
      \node at ($(S.south) - (0,.2)$) (A) {\authorformat{\@author}};
      % Profesor y ayudante
      \node (Q1) {\phantom{\textbf{Profesor:}}};
      \node (Q2) {\phantom{\textbf{Ayudante:}}};
      \node (Q3) {\phantom{\@profesor\ifthenelse{\equal{\@emailprofesor}{\empty}}{}{~(\emph{\@emailprofesor})}}};
      \node (Q4) {\phantom{\@ayudante\ifthenelse{\equal{\@emailayudante}{\empty}}{}{~(\emph{\@emailayudante})}}};
      \draw let
      \p1 = ($(Q1.east) - (Q1.west)$),
      \n1 = {veclen(\p1)},
      \p2 = ($(Q2.east) - (Q2.west)$),
      \n2 = {veclen(\p2)},
      \p3 = ($(Q3.east) - (Q3.west)$),
      \n3 = {veclen(\p3)},
      \p4 = ($(Q4.east) - (Q4.west)$),
      \n4 = {veclen(\p4)},
      \n5 = {max(\n1,\n2)}, % largo parte izquierda
      \n6 = {max(\n3,\n4)}, % largo parte derecha
      \n7 = {(\n5 - \n6) / 2},
      \p5 = ($(A.south) + (\n7,-1)$),
      \p6 = ($(\p5) - (0,.55)$),
      \n8 = {(\n3 - \n1) / 2},
      \n9 = {(\n4 - \n2) / 2},
      \p7 = ($(\p5) + (\n8,0)$),
      \p8 = ($(\p6) + (\n9,0)$),
      in
      node at (\p7) {\textbf{Profesor:} \@profesor\ifthenelse{\equal{\@emailprofesor}{\empty}}{}{~(\emph{\@emailprofesor})}}
      node at (\p8) {\textbf{Ayudante:} \@ayudante\ifthenelse{\equal{\@emailayudante}{\empty}}{}{~(\emph{\@emailayudante})}};
      % Fecha
      \node at ($(A.south) - (0,2.8)$) {\dateformat{\@date}};
    \end{tikzpicture}
  \end{center}

  % Tablas de contenidos
  \vspace*{-4ex}
  \tableofcontents
  \thispagestyle{plain}
  \newpage
  \siimprimir{}{
    \listofclases
    \thispagestyle{plain}
    \newpage
    \listoftodos
    \thispagestyle{plain}
    \newpage
  }
}


% --------- Lists ---------
\newlist{enumroman}{enumerate}{1}
\setlist[enumroman, 1]{label=(\roman*)}
\newlist{enumalph}{enumerate}{1}
\setlist[enumalph, 1]{label=(\alph*)}

% --------- Commands ---------
\newcommand{\onlyinsubfile}[1]{#1}
\newcommand{\notinsubfile}[1]{}
