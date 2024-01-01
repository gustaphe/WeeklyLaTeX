.PHONY : all

all : solution.pdf

%.pdf : %.tex
	xelatex --file-line-error --interaction=nonstopmode $<
