# GNU make
ENGINE = lualatex
BIB = biber
JOB = OpAmp_10417

.PHONY: quick pdf clean

quick: main.tex
	$(ENGINE) --jobname=$(JOB) main.tex

pdf: main.tex
	$(ENGINE) --jobname=$(JOB) main.tex
	$(BIB) $(JOB)
	$(ENGINE) --jobname=$(JOB) main.tex
	$(ENGINE) --jobname=$(JOB) main.tex

# UNIX-like
clean:
	rm -f *.log *.out *.aux *.bbl *.bcf *.blg *.xml *.toc