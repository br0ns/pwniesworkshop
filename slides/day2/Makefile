TARGET=slides.pdf
TEXFILES=*.tex

all: $(TARGET)

$(TARGET): $(GRAPHS) $(TEXFILES) $(HELPFILES) Makefile

clean:
	rm -rf *.nav *.snm *.vrb *.blg *.bbl *.aux *.log *.out *.toc *~ $(TARGET)

%_dot.pdf: %.dot
	dot $*.dot -Tpdf -o $*_dot.pdf

%.pdf: %.tex
	rm -rf *.blg *.bbl *.aux *.out *.tox
	pdflatex $*.tex
	bibtex $* || true
	pdflatex $*.tex
	pdflatex $*.tex
