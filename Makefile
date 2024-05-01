report.html: raw_data/raw.xlsx code/project_code.Rmd
	Rscript render_report.R


.PHONY: clean
clean:
	rm -f output/*.rds && rm -f report.html
	
install:
    R -e "renv::restore()"
    
# docker-associated rules (run on local machine)
PROJECTFILES = raw_data/raw.xlsx code/project_code.Rmd Makefile
RENVFILES = renv.lock renv/activate.R renv/settings.json 

# rule to build project_image
project_image: Dockerfile $(PROJECTFILES) $(RENVFILES)
	docker build -t project_image .
	touch $@
	
# rule to build the report automatically in our container
 final_report/report.html:
	docker run -v "/$$(pwd)/final_report":/project/final_report project_image
   
	
