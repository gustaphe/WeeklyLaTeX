.PHONY : all clean
all : solution.pdf

solution.pdf : solution.tex invoice.sty
	xelatex --file-line-error --interaction=nonstopmode $<

clean :
	${RM} *.log *.aux *.out
