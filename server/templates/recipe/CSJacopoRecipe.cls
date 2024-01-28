%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Jacopo Recipe
% LaTeX Class
% Version 1.0 (February 15, 2022)
%
% This class originates from:
% https://www.LaTeXTemplates.com
%
% Author:
% Vel (vel@latextemplates.com)
%
% License:
% CC BY-NC-SA 4.0 (https://creativecommons.org/licenses/by-nc-sa/4.0/)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%----------------------------------------------------------------------------------------
%	CLASS CONFIGURATION
%----------------------------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{CSJacopoRecipe}[2022/02/15 Creodocs Jacopo Recipe Class v1.0]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}} % Pass through any extra options specified to the base class
\ProcessOptions\relax % Process class options

\LoadClass{extarticle} % Load the base class

%----------------------------------------------------------------------------------------
%	REQUIRED PACKAGES AND MISC CONFIGURATIONS
%----------------------------------------------------------------------------------------

\usepackage[usenames, dvipsnames, svgnames, table]{xcolor} % Required for using preset color names or defining new ones

\usepackage{etoolbox} % Required for conditional logic and easily changing commands

\usepackage{setspace} % Required for changing line spacing

\usepackage{dashrule} % Required for dashed horizontal rules

\usepackage{enumitem} % Required for list customization
\setlist{partopsep=0pt, topsep=0pt} % Remove vertical spacing before the methods list

\setlength{\parindent}{0pt} % No paragraph indentation

\pagestyle{empty} % Suppress headers and footers

\usepackage{paracol} % Required for multi-column layouts
\setlength\columnsep{0.05\textwidth} % Horizontal whitespace between columns

\usepackage{changepage} % Required for temporarily indenting text blocks

%----------------------------------------------------------------------------------------
%	MARGINS
%----------------------------------------------------------------------------------------

\usepackage[
	top=2cm, % Top margin
	bottom=2.5cm, % Bottom margin
	left=1.25cm, % Left margin
	right=4.5cm, % Right margin
	%showframe % Uncomment to show frames around the margins for debugging purposes
]{geometry}

%----------------------------------------------------------------------------------------
%	FONTS
%----------------------------------------------------------------------------------------

\usepackage[T1]{fontenc} % Output font encoding for international characters
\usepackage[utf8]{inputenc} % Required for inputting international characters

\usepackage{mathpazo} % Default serif font Palatino

\newcommand{\sourcesanspro}[1]{{\fontfamily{SourceSansPro-LF}\selectfont#1}} % Custom Source Sans Pro font command

\usepackage{microtype} % Improve typography

%----------------------------------------------------------------------------------------
%	CUSTOM GRAPHICS
%----------------------------------------------------------------------------------------

\usepackage{tikz} % Required for custom graphics

\newcommand*{\circled}[2]{\tikz[baseline=(char.base)]{ % First argument is the margin around the contents of the circle and the second is the content of the circle
	\node[shape=circle, draw, inner sep=#1, fill=black, text=white] (char) {\footnotesize\bfseries\sourcesanspro{#2}};} % Black circle with white text
}

%----------------------------------------------------------------------------------------
%	TEXT STYLING COMMANDS
%----------------------------------------------------------------------------------------

\newcommand{\ingredient}[1]{{\textit{\normalsize #1}}\par\vspace{0.01\textheight}} % Styles an individual recipe ingredient

\newcommand{\method}[1]{\item \hspace{-3pt}{\large #1}} % Styles an individual recipe method

\newcommand{\seprule}{\hdashrule[0pt][x]{2\textwidth}{0.5pt}{1pt}} % Outputs a dashed horizontal rule to separate major recipe elements

%----------------------------------------------------------------------------------------
%	RECIPE HEADER
%----------------------------------------------------------------------------------------

\newcommand{\outputrecipeheader}{
	\switchcolumn[1] % Switch to the right column
	
	\begin{adjustwidth}{0cm}{-2cm} % Extra right margin space
		\ifdefempty{\recipedescription}{}{ % If a description was specified
			\textit{\color{Grey}\recipedescription} % Description
		
			\vspace*{0.01\textheight} % Vertical whitespace
		}
		
		{\raggedright\sourcesanspro{\fontsize{32pt}{36pt}\selectfont\bfseries\MakeUppercase{\recipetitle}\par}} % Recipe title
		
		\vspace*{0.03\textheight} % Vertical whitespace
		
		%------------------------------------------------
		
		\ifdefempty{\recipeserves}{\ifdefempty{\recipepreptime}{\ifdefempty{\recipecookingtime}{\ifdefempty{\recipedifficulty}{\newcommand{\norecipeinfoflag}{1}}{}}{}}{}}{} % Test whether no recipe information was entered and set a flag if so

		\ifundef{\norecipeinfoflag}{ % Don't display the recipe information section if none of the information in it has been entered
			\seprule % Horizontal rule
			
			\vspace*{0.0055\textheight} % Vertical whitespace between the rule and recipe information
			
			\sourcesanspro{% Sans font
				\ifdefempty{\recipeserves}{}{\textbf{SERVES}\hspace{4pt}\recipeserves\hspace{8pt}}% Servings
				\ifdefempty{\recipepreptime}{}{\textbf{PREP}\hspace{4pt}\recipepreptime\hspace{8pt}}% Preparation time
				\ifdefempty{\recipecookingtime}{}{\textbf{COOKING}\hspace{4pt}\recipecookingtime\hspace{8pt}}% Cooking time
				\ifdefempty{\recipedifficulty}{}{\textbf{DIFFICULTY}\hspace{4pt}\recipedifficulty}% Difficulty
			}
			
			\vspace*{-0.004\textheight} % Reduce vertical whitespace under recipe information so it equals whitespace above
			
			\seprule % Horizontal rule
			
			\vspace*{0.03\textheight} % Vertical whitespace under the recipe information
		}{% If there is no recipe information
			\seprule % Horizontal rule
			
			\vspace*{0.03\textheight}% Vertical whitespace
		}
	\end{adjustwidth}
}

%----------------------------------------------------------------------------------------
%	INGREDIENTS LIST
%----------------------------------------------------------------------------------------

\newenvironment{recipeingredients}{
	\switchcolumn[0]* % Switch to the left column, * to sync the column to the top of the methods list

	\raggedright % Suppress hyphenation
}{
}

%----------------------------------------------------------------------------------------
%	METHODS LIST
%----------------------------------------------------------------------------------------

\newenvironment{recipemethods}{
	\switchcolumn[1] % Switch to the right column
	
	\setstretch{1.1} % Slightly increase line spacing

	\begin{sloppypar} % Reduce the number of overhanging words (into the right margin) at the cost of extra space between words, this is a typographic decision to keep the neat right margin at all costs
		\begin{enumerate}[
			align=left, % Label to start at the left margin
			leftmargin=0pt, % Text on additional lines to be up against the left margin
			itemindent=!, % Compute item indent automatically
			labelwidth=0pt, % No label width as it's populated by TikZ
			labelindent=0pt, % No label indent
			label=\protect\circled{1.5pt}{\arabic*}, % Output circle with the specified internal padding in the first parameter and the text in the second; to change styling of the text do it like so for something different: \protect\circled{1.5pt}{\textit{\arabic*}.}
		]
}{
		\end{enumerate}
		
		\ifdefempty{\extramethodinfo}{}{\bigskip\textit{\color{Grey}\extramethodinfo}} % Optional extra information or tips
	\end{sloppypar}
	
	\setstretch{1} % Reset line spacing
}

%----------------------------------------------------------------------------------------
%	CUSTOM COMMANDS
%----------------------------------------------------------------------------------------

\newcommand{\recipetitle}[1]{\renewcommand{\recipetitle}{#1}}
\newcommand{\recipedescription}[1]{\renewcommand{\recipedescription}{#1}}
\newcommand{\recipeserves}[1]{\renewcommand{\recipeserves}{#1}}
\newcommand{\recipepreptime}[1]{\renewcommand{\recipepreptime}{#1}}
\newcommand{\recipecookingtime}[1]{\renewcommand{\recipecookingtime}{#1}}
\newcommand{\recipedifficulty}[1]{\renewcommand{\recipedifficulty}{#1}}
\newcommand{\extramethodinfo}[1]{\renewcommand{\extramethodinfo}{#1}}
