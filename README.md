
This is a paper aiming to cover aspects of social scientific workflow useful for graduate students.

To create a pdf file in RStudio, click on "Knit to PDF". 

At the command line do (assuming that pandoc and pandoc-citeproc and pandoc-crossref are installed):

```
Rscript -e "library(knitr); knit('workflow.Rmd')"

/usr/local/bin/pandoc +RTS -K512m -RTS workflow.md --to latex --from markdown+autolink_bare_uris+ascii_identifiers+tex_math_single_backslash --output workflow.pdf --template bowersarticletemplate.latex --number-sections --highlight-style tango --latex-engine /Library/TeX/texbin/pdflatex --filter /usr/local/bin/pandoc-crossref --bibliography references.bib --filter /usr/local/bin/pandoc-citeproc
```

To make a LaTeX file:

```

/usr/local/bin/pandoc +RTS -K512m -RTS workflow.md --to latex --from markdown+autolink_bare_uris+ascii_identifiers+tex_math_single_backslash --output workflow.tex --template bowersarticletemplate.latex --number-sections --highlight-style tango --latex-engine /Library/TeX/texbin/pdflatex --filter /usr/local/bin/pandoc-crossref --bibliography references.bib --filter /usr/local/bin/pandoc-citeproc
```

To make a Word file:

```

/usr/local/bin/pandoc +RTS -K512m -RTS workflow.md --to docx --from markdown+autolink_bare_uris+ascii_identifiers+tex_math_single_backslash --output workflow.docx --template bowersarticletemplate.latex --number-sections --highlight-style tango --latex-engine /Library/TeX/texbin/pdflatex --filter /usr/local/bin/pandoc-crossref --bibliography references.bib --filter /usr/local/bin/pandoc-citeproc

```
