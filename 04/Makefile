.PHONY : all clean

all : challenge.pdf

challenge.pdf : challenge.tex table.tex figure.tikz
	xelatex -file-line-error -interaction=nonstopmode $<

table.tex figure.tikz : challenge.jl
	julia $<

clean :
	${RM} *.aux *.log *.out *.pdf table.tex figure.tikz
