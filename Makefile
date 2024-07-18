SHELL=/bin/bash

LATEX := ./bin/latexrun --color auto -W no-overfull -W no-citation
PAPER := paper
LATEX_OUT := .latex.out

.PHONY: all clean

all: $(PAPER).pdf

.PHONY: FORCE
$(PAPER).pdf: FORCE
	$(LATEX) $(PAPER).tex -O $(LATEX_OUT) -o $@

arxiv: arxiv.tar.gz

arxiv.tar.gz: $(PAPER).pdf
	rm -rf arxiv
	mkdir -p arxiv
	latexpand --empty-comments $(PAPER).tex > arxiv/paper.tex
	cp .latex.out/paper.bbl arxiv/
	cp paper.cls macros.tex arxiv/
	# mkdir -p arxiv/figures arxiv/graphs
	# cp figures/*.pdf arxiv/figures/
	# cp graphs/*.pdf arxiv/graphs/
	(cd arxiv && tar czf ../arxiv.tar.gz *)

clean:
	$(LATEX) --clean-all -O $(LATEX_OUT)
	@rm $(PAPER).pdf
