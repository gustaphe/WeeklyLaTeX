.PHONY : all clean
all : challenge.pdf

challenge.pdf : challenge.tex invoice.sty
	xelatex --file-line-error --interaction=nonstopmode $<

clean :
	${RM} *.log *.aux *.out
