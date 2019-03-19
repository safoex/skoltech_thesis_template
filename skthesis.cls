\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{skthesis}[10/02/2018]


\def\mystretch{1.4}		% Double spacing hack
%% `vi' and `upcase' document style options.  Krishna Sethuraman (1990)
\DeclareOption{upcase}{\typeout{Uppercase cover page.}
	\gdef\choosecase#1{\uppercase\expandafter{#1}}}
\def\choosecase#1{#1}

%% leftblank option by Kevin Fu

%  Thesis looks much like report
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions
\LoadClass{report}

\usepackage[russian, english]{babel}
\usepackage[utf8]{inputenc}

\usepackage{fontspec}
\defaultfontfeatures[Times New Roman]{
	Extension = .ttf ,
	UprightFont = fonts/times,
	BoldFont = fonts/timesbd,
	ItalicFont = fonts/timesi,
	BoldItalicFont = fonts/timesbi
	}	
\setmainfont{Times New Roman}	
\newfontfamily\cyrillicfont{Times New Roman}

\usepackage{titlesec}
\titleformat{\chapter}[display]
  {\normalfont\Large\bfseries\centering}
  {\chaptertitlename\ \thechapter}{0pt}{\Huge}
% \titleformat{\section}
%   {\normalfont\large\bfseries\centering}
%   {\thesection}{1em}{}
\titlespacing*{\chapter}{0pt}{30pt}{20pt}



% If the user wants single spacing, set baselinestretch=1.

\usepackage{setspace}

% Note - doublespace.sty has some float-related troubles in
% combination with graphics or color, and is not officially compliant
% with 2e.  setspace is a replacement which is 2e-compliant.

% Read the doublespace style that we got from Rochester:
%\input setdoublespace.sty 		

\def\baselinestretch{\mystretch}	% Double spacing hack

\parindent 1.27cm
%%%%%%%  Set up margins and formatting params %%%

% Margins.
%  Note we want 1in top margin assuming no header line, so push header
%	into 1in margin.
%  Draft mode brings the header back down.

\usepackage{geometry}
\geometry{left=3cm}
\geometry{right=1.5cm}
 \geometry{top=2cm}
 \geometry{bottom=2cm}

% The next two macros compensate page style for headers and footers
% We only need them in page styles that USE headers and footers.
    % If we have a header, it must be 1in from top of page.
\def\pulldownheader{			% Shift header down 1in from top
    \addtolength{\topmargin}{\headheight}	
    \addtolength{\topmargin}{\headsep}	
    \addtolength{\textheight}{-\headheight}
    \addtolength{\textheight}{-\headsep}
}
    % If we have a footer, put it 1in up from bottom
\def\pullupfooter{				% Shift footer up
    \addtolength{\textheight}{-\footskip}
%    \addtolength{\textheight}{-\footheight}  %footheight doesn't
%    						exist in 2e
}

%%%%%%%  End of margins and formatting params %%%

\def\prevdegrees#1{\gdef\@prevdegrees{#1}}
\def\@prevdegrees{}

\def\department#1{\gdef\@department{#1}}
\def\departmentrus#1{\gdef\@departmentrus{#1}}
% If you are getting two degrees, use \and between the names.
\def\degree#1{\setbox0\hbox{#1}	 %for side effect of setting \@degreeword
  \gdef\@degree{#1}}

\def\degreerus#1{\setbox0\hbox{#1}	 %for side effect of setting \@degreeword
  \gdef\@degreerus{#1}}

% \and is used inside the \degree argument to separate two degrees
\def\and{\gdef\@degreeword{degrees} \par and \par}
\def\@degreeword{degree}


\def\copyrightnotice#1{\copyrightnoticetext{\copyright\ #1.  All rights
reserved.}}
\def\copyrightnoticerus#1{\copyrightnoticetextrus{\copyright\ #1.  Все права защищены.}}
% Occacionally you will need to exactly specify the text of the 
% copyright notice.  The \copyrightnoticetext command is then useful.
\long\def\copyrightnoticetext#1{\gdef\@copyrightnotice{#1}}
\def\@copyrightnotice{All rights reserved.\copyright\\
The author hereby grants to Skoltech permission to reproduce and to distribute publicly paper and electronic copies
of this thesis document in whole and in part in any medium now known or hereafter created.}

\long\def\copyrightnoticetextrus#1{\gdef\@copyrightnoticerus{#1}}
\def\@copyrightnoticerus{Все права защищены.\copyright\\
Автор настоящим дает Сколковскому институту науки и технологий
разрешение на воспроизводство и свободное распространение бумажных и электронных копий настоящей
диссертации в целом или частично на любом ныне существующем или созданном в будущем носителе.
}


\def\thesisdate#1{\gdef\@thesisdate{#1}}

\def\thesisdaterus#1{\gdef\@thesisdaterus{#1}}

% authors's name and title in russian
\def\authorrus#1{\gdef\@authorrus{#1}}
\def\titlerus#1{\gdef\@titlerus{#1}}


% typically just a month and year
\def\degreemonth#1{\gdef\@degreemonth{#1}}
\def\degreemonthrus#1{\gdef\@degreemonthrus{#1}}
\def\degreeyear#1{\gdef\@degreeyear{#1}}
% Usage: \supervisor{name}{title}
%        \chairman{name}{title}

% since there can be more than one supervisor,
% we build the appropriate boxes for the titlepage and
% the abstractpage as the user makes multiple calls
% to \supervisor
\newbox\@titlesupervisor \newbox\@titlecovisor	\newbox\@abstractsupervisor

\newbox\@titlerussupervisor \newbox\@titleruscovisor \newbox\@abstractrussupervisor


\def\supervisor#1#2#3{\setbox\@titlesupervisor\vbox
  {\unvbox\@titlesupervisor \vskip 10pt% plus 1fil minus 1fil
  \def\baselinestretch{1}\large
  \signature{Research Advisor:}{#1 \\ #2}}
  \setbox\@abstractsupervisor\vbox{\unvbox\@abstractsupervisor
  \vskip\baselineskip \def\baselinestretch{1}\@normalsize 
  \par\noindent Research Advisor: \\ Name: #1 \\ Degree: #3 \\ Title: #2}}

\def\supervisorrus#1#2#3{\setbox\@titlerussupervisor\vbox
  {\unvbox\@titlerussupervisor \vskip 10pt% plus 1fil minus 1fil
  \def\baselinestretch{1}\large
  \signature{Научный руководитель:}{#1 \\ #2}}
  \setbox\@abstractrussupervisor\vbox{\unvbox\@abstractrussupervisor
  \vskip\baselineskip \def\baselinestretch{1}\@normalsize 
  \par\noindent Научный руководитель: \\ Имя: #1 \\ Ученое звание, степень: #3 \\ Должность: #2}}


\def\cosupervisor#1#2#3{\setbox\@titlecovisor\vbox
  {\unvbox\@titlecovisor \vskip 10pt% plus 1fil minus 1fil
  \def\baselinestretch{1}\large
  \signature{Co-Advisor:}{#1 \\ #2}}
  \setbox\@abstractsupervisor\vbox{\unvbox\@abstractsupervisor
  \vskip\baselineskip \def\baselinestretch{1}\@normalsize 
  \par\noindent Co-Advisor: \\ Name: #1 \\ Degree: #3 \\ Title: #2}}

\def\cosupervisorrus#1#2#3{\setbox\@titleruscovisor\vbox
  {\unvbox\@titleruscovisor \vskip 10pt% plus 1fil minus 1fil
  \def\baselinestretch{1}\large
  \signature{Со-руководитель:}{#1 \\ #2}}
  \setbox\@abstractrussupervisor\vbox{\unvbox\@abstractrussupervisor
  \vskip\baselineskip \def\baselinestretch{1}\@normalsize 
  \par\noindent Со-руководитель: \\ Имя: #1 \\ Ученое звание, степень: #3 \\ Должность: #2}}

% department chairman, not thesis committee chairman
\def\chairman#1#2{\gdef\@chairmanname{#1}\gdef\@chairmantitle{#2}}

%% `upcase' documentclass option: \choosecase is defined either as a dummy or
%% a macro to change the (expanded) argument to uppercase.
\usepackage{graphicx}
\def\maketitle{\begin{titlepage}
\centering{\includegraphics[scale=0.15]{images/sklogo}}
\par
MASTER\/'S THESIS\\
\large
{\def\baselinestretch{1.2}\Large\bf \choosecase{\@title} \par}
\par
\choosecase{Master\/'s Educational Program:} \choosecase{\@department}
\par
%\skip 5\baselineskip
\vfill
\signature{Student}{\@author \\ \@department \\ \@thesisdate}
\par
\vfill
\unvbox\@titlesupervisor
\par
\vfill
\unvbox\@titlecovisor
%\signature{Accepted by}{\@chairmanname \\ \@chairmantitle}
\vfill
\small{Moscow \@degreeyear \\ \@copyrightnotice}
\end{titlepage}}

\def\rusmaketitle{\begin{titlepage}
\centering{\includegraphics[scale=0.15]{images/sklogo}}
\par
МАГИСТЕРСКАЯ ДИССЕРТАЦИЯ\\
\large
{\def\baselinestretch{1.2}\Large\bf \choosecase{\@titlerus} \par}
\par
\choosecase{Магистерская образовательная программа:} \choosecase{\@departmentrus}
\par
%\skip 5\baselineskip
\vfill
\signature{Студент}{\@authorrus \\ \@departmentrus \\ \@thesisdaterus}
\par
\vfill
\unvbox\@titlerussupervisor
\par
\vfill
\unvbox\@titleruscovisor
%\signature{Accepted by}{\@chairmanname \\ \@chairmantitle}
\vfill
\small{Москва \@degreeyear \\ \@copyrightnoticerus}
\end{titlepage}}


% this environment should probably be called abstract,
% but we want people to also be able to get at the more
% basic abstract environment
\def\abstractpage{\cleardoublepage
\begin{center}{\large{\bf \@title} \\
\@author \\[\baselineskip]}
\par
\def\baselinestretch{1}\@normalsize
Submitted to the Skolkovo Institute of Science and Technology \\
on \@thesisdate
\end{center}
\par
\begin{abstract}}


\def\endabstractpage{\end{abstract}\noindent
 \unvcopy\@abstractsupervisor \newpage}


\def\abstractpagerus{\cleardoublepage
\begin{center}{\large{\bf \@titlerus} \\
\@authorrus \\[\baselineskip]}
\par
\def\baselinestretch{1}\@normalsize
Представлено в Сколковский институт науки и технологий \\
\@thesisdaterus
\end{center}
\par
\begin{abstractrus}}


\def\endabstractpagerus{\end{abstractrus}\noindent
 \unvcopy\@abstractrussupervisor \newpage}


%% This counter is used to save the page number for the second copy of
%% the abstract.
\newcounter{savepage}

% You can use the titlepage environment to do it all yourself if you
% don't want to use \maketitle.  If the titlepage environment, the
% paragraph skip is infinitely stretchable, so if you leave a blank line
% between lines that you want space between, the space will stretch so
% that the title page fills up the entire page.
\def\titlepage{\centering
  \thispagestyle{empty}
  \parindent 0pt \parskip 10pt plus 1fil minus 1fil
  \def\baselinestretch{1}\@normalsize\vbox to \vsize\bgroup\vbox to 9in\bgroup}

\def\endtitlepage{\par\kern 0pt\egroup\vss\egroup\newpage}

\def\signature#1#2{\par\hfill#1\hrulefill\null\\*
  {\raggedleft #2\par}}

\def\abstract{\subsection*{\centering Abstract}\small\def\baselinestretch{1}\@normalsize}
\def\endabstract{\par}

\def\abstractrus{\subsection*{\centering Реферат}\small\def\baselinestretch{1}\@normalsize}
\def\endabstractrus{\par}

\usepackage{kantlipsum}