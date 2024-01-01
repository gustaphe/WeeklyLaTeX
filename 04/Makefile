.PHONY : all clean

all : solution.pdf

solution.pdf : solution.tex table.tex figure.tikz
	xelatex -file-line-error -interaction=nonstopmode $<

table.tex figure.tikz : solution.jl
	julia --project=. $<

clean :
	${RM} *.aux *.log *.out *.pdf table.tex figure.tikz
