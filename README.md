# Overview

This repo hosts code for the DataLab network report. The network report provides an introductory examination of network datasets, with a focus on determining future applicability and directions for further network analysis. The report contains sections which describe general information about networks and the metrics calculated, the metrics in the context of the specific network that was used to create the report, and matching interactive visualizations. You can see an example report by looking at the github pages for this repo.

The intended workflow for this report is as follows:

1. Provide the network handout to research partners, available in `src/researcher_handout.Rmd`.
2. Raw data is provided to DataLab undergraduate interns, who use `src/data_template.R` as an example of how to format the data.
3. The formatted data is run through `src/report_dash.Rmd` to create the report.
4. The research partners meet with the undergraduate intern and DataLab staff to discuss the report and future directions.

# Data and Formatting

The network report expects a standardized data input, a template of which is provided in `src/data_template.R`. The report itself is generated in `src/report_dash.rmd`; kniting this document will create a self-contained html file which can be viewed in any web browser.

`src/data_template.R` provides an example data set, and will walk you through the required components for the network report. You will need to provide or create an edgelist and an attributes file, which will then be combined and saved an an igraph object. This igraph object is then the sole input to `src/report_dash.rmd` for generating the final report.