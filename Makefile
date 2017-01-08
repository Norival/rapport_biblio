RDIR=./R
REPORTING=$(RDIR)/reporting
DATA=$(wildcard $(RDIR)/data/*)
RFILES=$(wildcard $(RDIR)/*.R)
OUT_FILES=$(RFILES:.R=.Rout)

R=Rscript -e
VIEWER=zathura 2>/dev/null

all: reporting

reporting: $(REPORTING).pdf

$(REPORTING).pdf: $(REPORTING).Rmd $(DATA)
	$(R) "rmarkdown::render('$<')"

view: $(REPORTING).pdf
	$(VIEWER) $< &

.PHONY: clean mrproper

clean:
	rm -rfv $(OUT_FILES)

mrproper: clean
	rm -rfv $(REPORTING).pdf
