# Use rocker/rstudio as base
FROM rocker/r-ubuntu

RUN apt-get update && apt-get install -y pandoc

# Set up project directory structure
RUN mkdir /project
WORKDIR /project
RUN mkdir code
RUN mkdir raw_data
RUN mkdir output

# Copy project files
COPY code code
COPY raw_data raw_data
COPY Makefile .
COPY .Rprofile .
COPY renv.lock . 
COPY report.Rmd .
COPY render_report.R .
COPY final_project_readme.Rmd .

# Set up renv
RUN mkdir renv
COPY renv/activate.R renv
COPY renv/settings.json renv

# Restore R environment
RUN Rscript -e "renv::restore(prompt = FALSE)"

# Create directory for final report
RUN mkdir final_report

# Install pandoc
RUN apt-get update && apt-get install -y pandoc

# Generate the final report
CMD make && mv report.html final_report
