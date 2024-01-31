\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{apuntes}[2024/01/28 Apuntes]

\RequirePackage{etoolbox}

% --------- class options ---------
% variables
\def\apuntes@ptsize{12pt}
\def\apuntes@pagesize{letterpaper}
\def\apuntes@font{LatinModern}
\newtoggle{apuntes@print}
\newtoggle{apuntes@toc}
\newtoggle{apuntes@clases}
\newtoggle{apuntes@todo}

% Print Mode
\DeclareOption{print}{
  \def\apuntes@ptsize{10pt}
  \toggletrue{apuntes@print}
  \toggletrue{apuntes@toc}
}

% font size (default: 12pt)
\DeclareOption{10pt}{\def\apuntes@ptsize{10pt}}
\DeclareOption{11pt}{\def\apuntes@ptsize{11pt}}
\DeclareOption{12pt}{\def\apuntes@ptsize{12pt}}

% font (default: lmodern)
\DeclareOption{lmodern}{\def\apuntes@font{LatinModern}}
\DeclareOption{charter}{\def\apuntes@font{CharterBT}}
\DeclareOption{libertine}{\def\apuntes@font{Libertine}}
\DeclareOption{cmbright}{\def\apuntes@font{ComputerModernBright}}

% page size (default: letterpaper)
\DeclareOption{letterpaper}{\def\apuntes@pagesize{letterpaper}}
\DeclareOption{legalpaper}{\def\apuntes@pagesize{legalpaper}}

% include lists of contents
\DeclareOption{toc}{\toggletrue{apuntes@toc}}
\DeclareOption{clases}{\toggletrue{apuntes@clases}}
\DeclareOption{todo}{\toggletrue{apuntes@todo}}

% pass undeclared options to article
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

\ProcessOptions\relax
\LoadClass[\apuntes@ptsize]{article}

\RequirePackage[spanish]{babel}

\RequirePackage{xstring}

% Custom packages
\RequirePackage{math-macros}
\RequirePackage[\iftoggle{apuntes@print}{bw}{}]{math-environments}
\RequirePackage[\iftoggle{apuntes@print}{invisible}{}]{fancy-dates}

% Font
\IfStrEqCase{\apuntes@font}{
  {LatinModern}{
    \RequirePackage{lmodern}
    \RequirePackage[T1]{fontenc}
  }
  {CharterBT}{
    \RequirePackage[bitstream-charter]{mathdesign}
    \RequirePackage[T1]{fontenc}
  }
  {Libertine}{
    \RequirePackage{libertine}
    \RequirePackage{libertinust1math}
    \RequirePackage[T1]{fontenc}
  }
  {ComputerModernBright}{
    \RequirePackage{cmbright}
    \RequirePackage[OT1]{fontenc}
  }
}

\RequirePackage{amsmath,amssymb,amsthm}
\RequirePackage{mathtools}

\RequirePackage[margin=1in,paper=\apuntes@pagesize]{geometry}
\RequirePackage{hyperref}
\RequirePackage{enumitem}
% \RequirePackage{fancyhdr}
% \RequirePackage{needspace} % needspace for dynamic line breaking
\RequirePackage{tikz}
\usetikzlibrary{calc}
\RequirePackage{tikz-cd}

% todo notes
\RequirePackage[\iftoggle{apuntes@todo}{status=draft}{}]{fixme}
\newcommand{\todo}[2][]{\fxnote[nomargin,\ifblank{#1}{inline}{#1}]{#2}}

\RequirePackage{subfiles}

\hypersetup {
  pdfstartview=FitH,
  colorlinks=\iftoggle{apuntes@print}{false}{true},
  citecolor=blue,
  linkcolor=blue
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
\gdef\@emailprofesor{}
\gdef\@ayudante{\empty}
\gdef\@emailayudante{\empty}
\renewcommand{\author}[1]{\gdef\@author{#1}}
\newcommand{\class}[1]{\gdef\@class{#1}}
\newcommand{\profesor}[1]{\gdef\@profesor{#1}}
\newcommand{\emailprofesor}[1]{\gdef\@emailprofesor{#1}}
\newcommand{\ayudante}[1]{\gdef\@ayudante{#1}}
\newcommand{\emailayudante}[1]{\gdef\@emailayudante{#1}}


% \fancypagestyle{firstpagestyle}
% {
% \fancyhf{}
% \renewcommand{\headrulewidth}{0pt}
% }
%   \fancypagestyle{generalpagestyle}
%   {
%   \fancyhf{}
%   \renewcommand{\headrulewidth}{.5pt}
%   \fancyhead[L]{\footnotesize \@class\ - \@title}
%   \fancyhead[R]{\footnotesize \@author}
%   \fancyfoot[R]{\thepage}
% }
%   \pagestyle{generalpagestyle}

\newcommand{\titleformat}[1]{\textbf{\Large{#1}}}
\newcommand{\siglaformat}[1]{\textbf{\scriptsize{#1}}}
\newcommand{\authorformat}[1]{\textsc{\normalsize{#1}}}
\newcommand{\dateformat}[1]{\small{#1}}
\renewcommand{\maketitle} {
  % \thispagestyle{firstpagestyle}
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
      \node (Q3) {\phantom{\@profesor\IfStrEq{\@emailprofesor}{}{}{~(\emph{\@emailprofesor})}}};
      \node (Q4) {\phantom{\@ayudante\IfStrEq{\@emailayudante}{}{}{~(\emph{\@emailayudante})}}};
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
      node at (\p7) {\textbf{Profesor:} \@profesor\IfStrEq{\@emailprofesor}{}{}{~(\emph{\@emailprofesor})}}
      node at (\p8) {\textbf{Ayudante:} \@ayudante\IfStrEq{\@emailayudante}{}{}{~(\emph{\@emailayudante})}};
      % Fecha
      \node at ($(A.south) - (0,2.8)$) {\dateformat{\@date}};
    \end{tikzpicture}
  \end{center}

  % Lists of contents
  \iftoggle{apuntes@toc}{
    \vspace*{-4ex}
    \tableofcontents
  }{}
  \iftoggle{apuntes@clases}{
    \newpage
    \listofclases
  }{}
  \iftoggle{apuntes@todo}{
    \newpage
    \listoffixmes
  }{}
  \newpage
}


% Lists
\newlist{enumroman}{enumerate}{1}
\setlist[enumroman, 1]{label=(\roman*)}
\newlist{enumalph}{enumerate}{1}
\setlist[enumalph, 1]{label=(\alph*)}

% Commands
\newcommand{\onlyinsubfile}[1]{#1}
\newcommand{\notinsubfile}[1]{}
