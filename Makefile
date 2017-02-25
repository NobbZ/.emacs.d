ORG_FILES := settings.org
PNG_FILES := structure.png structure-planned.png hello-world.png

PDFS  := $(ORG_FILES:%.org=_pages/%.pdf)
HTMLS := $(ORG_FILES:%.org=_pages/%.html)

PNGS  := $(PNG_FILES:%=_pages/%)

.SECONDARY: $(PDFS) $(HTMLS) $(PNGS)

EXECUTABLES = java latexmk lualatex emacs

EXECUTABLES_CHECK = $(foreach exec,$(EXECUTABLES),\
	$(if $(shell which $(exec)),,$(error "Executable $(exec) not in PATH")))

pages: $(PDFS) $(HTMLS) $(PNGS)
	cd _pages; git add $(^:_pages/%=%); git commit -m $(shell date +\"%Y-%M-%dT%T\"); git pull --rebase; git push
	git push

_pages:
	git clone git@github.com:NobbZ/emacs.d _pages; cd _pages; git checkout gh-pages

_pages/%: % | _pages
	cp $< $@

%.pdf: %.org
	emacs --batch -l ./init.el $< -f org-latex-export-to-pdf --kill

%.html: %.org
	emacs --batch -l ./init.el $< -f org-html-export-to-html --kill

clean:
	rm -rfv *.html
	rm -rfv *.pdf
	rm -rfv *.tex
	rm -rfv *.png
	rm -rfv *.fdb_latexmk
	rm -rfv *.fls
	rm -rfv *.pyg

