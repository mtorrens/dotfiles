Read me file for the example thesis for use with nddiss2e class file.

QUICK
-----

Just type "make" command, and you'll have a pdf file (example.pdf) which
reflects the correct formatting as per Spring 2004 guidelines.

For more details (esp. pdf/ps conflicts and chapter-wise bibliography),
read on.

OVERVIEW
--------

This is a sample dissertation package for the University of Notre Dame,
provided by the Graduate Student Union (GSU).  This package also doubles
as a sample Master's Thesis, since the styles are the same (except for a
few words on the title page).

This package is meant for graduate students of any discipline at Notre
Dame, and has been tailored for typical unix environment (although it
should work for a windows setup as well).

The /nddiss2e/ class package has been installed on AFS and the Linux
cluster(s) supported by OIT, hence, aside from getting access to the
OIT-maintained LaTeX and dvips executables, you should not need to do
anything to your environment; the class file, /nddiss2e.cls/, should
just magically be found when you invoke LaTeX or pdfLaTeX.

Even in absence of OIT-supported machine(s), it *should* work on most
other environments as well.  Most of the Linux distributions provide
teTeX/LaTeX bundles and it is easy to setup your own TEXMF hierarchy in
your home directories as well. Please read the included file
(readme-texmf.txt) for more information on this topic.


WARNING
-------

The /nddiss2e/ class package and the resulting dissertation document
format has been approved by the Graduate School's reviewers. However, it
is still possible to create an incorrectly formatted thesis, if the
directions in the /nddiss2e/ documentation are not followed. This
example is _not_ a substitute for the instructions in the actual
/nddiss2e/ documentation.


HOW TO USE THE NDDISS2e CLASS
-----------------------------

The /nddiss2e/ class file provides very few options but you must fill in
several 'variables' (such as title, your name advisor's name etc.). See
the complete documentation for details. The documentation is available
from http://www.gsu.nd.edu OR http://graduateschool.nd.edu (its short,
but would be very helpful in preparing your thesis with the correct
format)

This sample package includes concrete examples of most of what is
discussed in the /nddiss2e/ documentation file.


WHAT IS IN THIS SAMPLE DISSERTATION
-----------------------------------

In any unix environment, if you type "make" in the 'example' directory,
it should build a pdf file called "example.pdf", which you can view with
your favorite pdf previewer.  This is a full thesis, and includes
examples of many of the types of things that usually appear in
dissertations, such as tables, figures, table of contents, a
bibliography, etc.  You may wish to print this file out and use it as an
example for acceptable formats.

You can also type "make ps" to make the file "example.ps", if you wish
to make a postscript version of your dissertation or "make dvi" to make
DVI version, instead.


HOW TO USE THIS SAMPLE DISSERTATION
-----------------------------------

The goal of this sample is to provide you with a set of files from
which you can simply delete the content and use as a template for your
own thesis.

That is, you just have to set a few switches (all clearly documented)
and replace the text content with your own.  Then, all you have to do is
invoke "make", which should do the trick of creating your thesis in a
'press-quality' pdf file.  Hopefully, this will save a lot of headaches
in trying to figure out the mysteries of LaTeX, make, etc.

This sample is divided up into several files, all of which have
helpful comments included:

-------------------------------------------------------------------------
README.1st.txt		- This file

Makefile		- This makefile is setup to build the sample
				  dissertation PDF or PS file.  Just
				  type "make" (or "make ps" to build the PS
				  file).

example.tex	- This is the "top-level" .tex file.  It contains
			  the settings for the title page, table of
			  contents, list of tables/figures,
			  acknowledgments, dedication, abstract,
			  includes the two chapter .tex files, and the
			  bibliography.

chapter1.tex		- The text for the first chapter.
chapter2.tex		- The text for the second chapter.
appendix.tex		- The text for the appendix.

example.bib			- BibTeX entries for the bibliography.

sample_nd.eps		- An encapsulated postscript figure that is
					  used in the sample dissertation.

sample_nd.pdf		- A pdf figure (converted from sample_nd.eps by
					  using eps2pdf/epstopdf) that is used in the
					  sample dissertation.

-------------------------------------------------------------------------


A NOTE ABOUT THE MAKEFILE
-------------------------

To use this Makefile for your own thesis, you should really only need to
change a few entries at the top of the file, all of which are clearly
marked.  There is also a clearly marked "You should not need to edit
below this line" line; unless you understand LaTeX and the rules of
"make", I would recommend against fiddling with things below there.

Basically, you just need to enter the names of the .tex files (and any
other files in your dissertation, such a figure files, .bib files,
etc.) in your thesis, and make will ensure that when you edit any one
of those files, the thesis will be rebuilt.

The Makefile is "smart", in that it will re-run latex multiple times
until all references have stopped changing.  It will also run BibTeX,
if necessary, to generate your bibliography.

Basically, once you put in your filenames, you should just need to
type "make", and when it is finished, your .pdf file will be created.

Here is a list of all the targets pre-programmed into the Makefile:

-------------------------------------------------------------------------
pdf (default)	- Builds the example.pdf file
pdf				- Builds the example.ps and
dvi				- Builds the example.dvi file
clean		- Removes the target files(example.pdf/.ps/.dvi), if present.
squeaky		- Removes all the "extra" files that latex (et al.)
			  create, and only leaves your source files (.tex,
			  .bib, figures, etc.).  This also removes your example.pdf
			  /.ps/.dvi files.
-------------------------------------------------------------------------


A NOTE ABOUT PDF AND PS FILES
-----------------------------

Always use "make squeaky" _before_ using "make". 

(you can use both in one command eg. "make squeaky pdf")

Doing this ensures that previously files created by LaTeX or pdfLaTeX
are removed and they are created fresh in the current process. This is
more necessary when creating a pdf or a dvi/ps file after creating a
dvi/ps or a pdf file, respectively since pdfLaTeX or LaTeX will give you
errors while processing incompatible files from the previous run.

A NOTE ABOUT BIBLIOGRAPHIES
---------------------------

The /nddiss2e/ class file uses 'natbib' package for citation/reference
indexing by default. Other packages such as 'cite' or 'citation'
conflict with the definitions in 'natbib' package and result in errors.
Hence, _Do_not_ use other citation packages.

The Graduate School guidelines are not clear on whether it allows for a
creation for single bibliography as well as chapter-wise bibliography.
This example can do that, but you must first perform a few steps:

In the file "example.tex":
- in the beginning, _uncomment_ the line
	\usepackage{chapterbib}.
- at the end, _comment_ out the following lines:
	\backmatter
	\bibliographstyle{nddiss2e}
	\bibliography{example}

In _each_ chapter file ("chapter1.tex","chapter2.tex" & "appendix.tex"):
- at the end of file, uncomment the following lines:
	\bibliographstyle{nddiss2e}
	\bibliography{example}

- Instead of using the normal 'makefile', use the other
  makefile called 'makefile.chapterbib' as

    make -f makefile.chapterbib squeaky pdf

- OR In the 'makefile', fill in the top-level filenames for your chapters
  (chapter1.tex, chapter2.tex & appendix.tex in this example) in the
  CHAP_CITE_TEX macros.  Be sure that these files are *not* mentioned
  again in the OTHER_SRC_FILES macro, later in the Makefile. 
  You are now setup to "make".  Invoke "make", and you should have a .pdf
  file with bibliographies at the end of each chapter.


AVAILABILITY / CONTACT
----------------------

This package is provided in the behalf of the Graduate Student Union (U.
Notre Dame) and the Graduate School. The complete package is available
as part of the /nddiss2e/ class package from http://www.gsu.nd.edu or
http://graduateschool.nd.edu

The most appropriate contact for questions and comments in this package
is Ms. Shari Hill (Reviewer, Graduate School, email: sharihill@nd.edu)
who will forward me the suggestions or queries.

Sameer Vijay
Jul 26, 2005 10:00
