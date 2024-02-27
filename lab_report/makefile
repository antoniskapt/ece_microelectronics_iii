# GNU make
ENGINE = lualatex
BIB = biber
JOB = Tmima2_Omada4

pdf: main.tex
	$(ENGINE) --jobname=$(JOB) main.tex
	$(BIB) $(JOB)
	$(ENGINE) --jobname=$(JOB) main.tex
	$(ENGINE) --jobname=$(JOB) main.tex

# UNIX-like
clean:
	rm -f *.log *.out *.aux *.bbl *.bcf *.blg *.xml *.toc main.synctex.gz

# Windows
w_clean:
	del *.log
	del *.out
	del *.aux
	del *.bbl
	del *.bcf
	del *.blg
	del *.xml
	del *.toc
	del main.synctex.gz