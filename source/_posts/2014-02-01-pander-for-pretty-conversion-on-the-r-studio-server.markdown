---
layout: post
title: "Pander/Pandoc for Pretty Conversion on the R Studio Server"
date: 2014-02-01 11:42:14 -0500
comments: true
categories: [Tech Note]
---

Eventually we get around to teaching our students to turn in Homework assignments as R Markdown documents, and towards the end of the semester many of them will do a data analysis project, complete with a report generated as an HTML file.

But frankly the HTML output is a bit ugly.  What if students want something that looks a bit better?  What if they use R for data analysis in another class, and the instructor wants the report in some other format---a .docx, for instance?

Our solution, for now, involves [Pandoc](http://johnmacfarlane.net/pandoc/), an excellent universal document converter written by John MacFarlane.  The R package `pander` facilitates the use of Pander for conversion of documents that began as R Markdown, so you just need to ask your sysadmin to install these Pandoc and `pander` on the server.  `pander` calls Pandoc, which will in turn convert a Markdown document into a variety of formats:  pdf, docx, odt, etc., as per your request.

For pdf output, Pandoc first turns the converts the Markdown into $\LaTeX$, so you will need to make sure that $\LaTeX$ is installed on the server as well (some minimal version probably comes with the distribution).  The engine default engine for conversion is `pdflatex`, followed by `lualatex` and `xelatex`, so you need to make sure that one of these is installed.  [`xelatex` came along with our CentOS R Studio server, but had to be installed.]

Students would use Pandoc through the `Pandoc.convert()` function from the `pander` package.  First, one knits the r Markdown document, simply in order to produce the Markdown document along the way.  Then run something like:

```
require(pander)
Pandoc.convert(f="path/to/MyReport.md", format="pdf", options="-S")
```

R complains bitterly in the console---apparently it attempts to open a preview window but cannot---but produces the desired file in the same directory as the Markdown file.

We find that pdf and docx format both look rather nice, and boast a table of contents as well.  The pdf centers plots, too (this is popular with students).  Sadly, the code chunks do lose their background color under Pandoc's default highlighting style of "pygments".  If you try for some other style, e.g.,

```
Pandoc.convert(f="path/to/MyReport.md", format="pdf", options="-S --highlight-style="tango")
```
then in some installations of $\LaTeX$, including the one on our server, there will be an error.  We have not yet decided whether to bug the sysadmin to install a fuller version of $\LaTeX$ in order to get overcome this difficulty.





