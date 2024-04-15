report.html: raw_data/raw.xlsx code/project_code.Rmd
	Rscript render_report.R


.PHONY: clean
clean:
	rm -f output/*.rds && rm -f report.html
	
install:
    R -e "renv::restore()"
	
