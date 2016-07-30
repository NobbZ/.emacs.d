ORG_FILES := settings.org
PNG_FILES := structure.png structure-planned.png hello-world.png

PDFS  := $(ORG_FILES:%.org=_pages/%.pdf)
HTMLS := $(ORG_FILES:%.org=_pages/%.html)

PNGS  := $(PNG_FILES:%=_pages/%)

pages: $(PDFS) $(HTMLS) $(PNGS)
	cd _pages; git add $(^:_pages/%=%); git commit -m $(shell date +\"%Y-%M-%dT%T\"); git push

_pages/%: %
	cp $< $@

%.pdf: %.org
	emacs --batch -l ~/.emacs.d/init.el $< -f org-latex-export-to-pdf --kill

%.html: %.org
	emacs --batch -l ~/.emacs.d/init.el $< -f org-html-export-to-html --kill

clean:
	rm -rfv *.html
	rm -rfv *.pdf
	rm -rfv *.tex
	rm -rfv *.png
