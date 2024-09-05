# Snakemake workflow: `Globe_map`

[![Snakemake](https://img.shields.io/badge/snakemake-≥6.3.0-brightgreen.svg)](https://snakemake.github.io)
[![GitHub actions status](https://github.com/gonzarizzo/globe_map/workflows/Tests/badge.svg?branch=main)](https://github.com/gonzarizzo/globe_map/actions?query=branch%3Amain+workflow%3ATests+is%3Asuccess)


A Snakemake workflow for creating a global map that highlights a country.


## Usage

The usage of this workflow is described in the [Snakemake Workflow Catalog](https://snakemake.github.io/snakemake-workflow-catalog/?usage=gonzarizzo%2Fglobe_map).

If you use this workflow in a paper, don't forget to give credits to the authors by citing the URL of this (original) <repo>sitory and its DOI (see above).

# TODO

* Replace `<owner>` and `<repo>` everywhere in the template (also under .github/workflows) with the correct `<repo>` name and owning user or organization.
* Replace `<name>` with the workflow name (can be the same as `<repo>`).
* Add a description on how to use it:

  1. Clone from github running: `git clone https://github.com/gonzarizzo/globe_map.git`
  2. cd to globe_map running: `cd globe_map`
  3. By running `snakemake` you will reproduce everything. Check if it is needed to run snakemake deploy first to create the environments, and then run `snakemake`.

* The workflow will occur in the snakemake-workflow-catalog once it has been made public. Then the link under "Usage" will point to the usage instructions if `<owner>` and `<repo>` were correctly set.
