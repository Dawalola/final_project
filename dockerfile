# Use rocker/rstudio as base
FROM rocker/r-ubuntu


RUN apt-get update && apt-get install -y pandoc

run mkdir /project
workdir /project

run mkdir code
run mkdir raw_data
run mkdir output
copy code code
copy raw_data raw_data
copy Makefile .
copy .Rprofile .
copy renv.lock . 
COPY report.Rmd .
copy render_report.R .
COPY final_project_readme.Rmd .

run mkdir renv
copy renv/activate.R renv
copy renv/settings.json renv



run Rscript -e "renv::restore(prompt = FALSE)"
run mkdir final_report
run apt-get update && apt-get install -y pandoc

cmd make && mv report.html final_report