GRAPHS=
TARGET=slides.pdf
TEXFILES=*.tex
HELPFILES=
DEPFILE=.depend

all: $(TARGET)

$(TARGET): $(GRAPHS) $(TEXFILES) $(HELPFILES) Makefile

clean:
	rm -rf *.nav *.snm *.vrb *.blg *.bbl *.aux *.log *.out *.toc *.eps *.data *.o *.hi *_haskell.log *~ $(DEPFILE) $(GRAPHS) $(TARGET)

%.svg: %.dot
	dot $*.dot -Tsvg -o $*.svg

%.png: %.dot
	dot $*.dot -Tpng -o $*.png

%.ps: %.dot
	dot $*.dot -Tps -o $*.ps

%_dot.pdf: %.dot
	dot $*.dot -Tpdf -o $*_dot.pdf

%_neato.pdf: %.dot
	neato $*.dot -Tpdf -o $*_neato.pdf

%_circo.pdf: %.dot
	circo $*.dot -Tpdf -o $*_circo.pdf

%.mapleout: %.maple
	$(HOME)/bin/maple $*.maple > $*.mapleout

%_guimaple.ps: %.maple
	mwrapper $*.maple

%_maple.ps: %.maple
	$(HOME)/bin/maple $*.maple

%_dia.eps: %.dia
	dia $*.dia -e $*_dia.eps

%_eps.pdf: %.eps
	epstopdf $*.eps -o $*_eps.pdf

%.pdf: %.tex
	rm -rf *.blg *.bbl *.aux *.out *.tox
	pdflatex $*.tex
	bibtex $* || true
	pdflatex $*.tex
	pdflatex $*.tex

print: $(TARGET)
	cat $(TARGET) | ssh mathias@ask.diku.dk lp -d m1b

%_haskell.log: %.hs
	runghc $*.hs > $*_haskell.log

$(DEPFILE):
	@ghc -M -dep-makefile $(DEPFILE) $(shell find . -name "*.hs")
	@sed -i -e 's/\.\(hi\|o\)\b/.hs/g' $(DEPFILE)
	@egrep -v "^(.*) : \1" $(DEPFILE) | grep : | grep -v "^#" > $(DEPFILE).new; mv $(DEPFILE).new $(DEPFILE)
	@sed -i -e 's/.*/\0\n	@touch $$@\n/' $(DEPFILE)

#-include $(DEPFILE)
