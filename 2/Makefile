.PHONY : all

all : challenge.pdf

%.pdf : %.tex
	xelatex --file-line-error --interaction=nonstopmode $<
