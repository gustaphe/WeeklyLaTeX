.PHONY : all


all : challenge.pdf preview.pdf

%.pdf : %.tex
	xelatex --file-line-error --interaction=nonstopmode $<

preview.pdf : challenge.pdf
	gs -o $@ \
		-sDEVICE=pdfwrite \
		-c "[/CropBox [45 45 550 374]" \
		-c "/PAGES pdfmark" \
		-f $<

		
# left, bottom, right, top
# 16mm, 16mm, 194mm, 132mm
# 45 45 550 374
