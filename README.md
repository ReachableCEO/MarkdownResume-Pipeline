# MarkdownResume-Pipeline

- [MarkdownResume-Pipeline](#markdownresume-pipeline)
  - [Introduction](#introduction)
  - [Directory Overview](#directory-overview)
  - [Build pipeline](#build-pipeline)
    - [Outputs](#outputs)
  - [Production Use](#production-use)

## Quick licensing. One 

- Only the code is covered by the AGOL v3.0 only. Data files are excluded. 
 
- Any data files you pass to the code and any generated outputs are excluded from the AGPL v3.0. You retain all rights under applicable law to any input and output data. 
- This also includes anything you do with the illustrative example files included. They are not considered derivative works. 

- Any use, inclusion , consumption of the code in source or binary or micro service etc form is covered under AGOL v3.0 only.   

## Introduction

Resume formatting/publication/management is difficult, tedious, annoying etc. The @ReachableCEO has hacked the process and made it easy! This repository is the core build scripts, templates etc used for resume management. It's meant as one half of a complete solution.

Please see [MarkdownResum-Pipeline-ClientExample repository](https://git.knownelement.com/reachableceo/MarkdownResume-Pipeline-ClientExample) for the other half. You would clone that repository and follow the instructions. That repository has this repository vendored into it.

## Directory Overview

- build: build script and associated support files.
- build-output: markdown file for pandoc gets placed here. If you want to make formatting changes before conversion to PDF/Word, you can do so.
- build-temp: working directory for the build process. In case you need to debug an intermediate step.
- Templates
  - CandidateInfoSheet: contains the markdown/yaml template files for a candidate information sheet. This allows you to produce a standardized reply to recruiters to eliminate an average of 6 emails/phone calls per inbound lead. It has a rate sheet and all the standard "matrix" tables they need to fill out for submission to an end client (or, in reality, to the US based recruiting team who interfaces with the client).
  - ContactInfo: contact info (one version for the recruiter facing resume, one version for client facing).
  - JobHistoryDetails: details for each position listed in WorkHistory/WorkHistory.csv.
  - SkillsAndProjects: This contains what the name says. Holds a skills.csv file that gets turned into a skills table and a projects file that gets placed at beginning of resume as a career highlights section.
  - WorkHistory: contains the WorkHistory.csv file used by the build script to generate Employment History section.

## Build pipeline

In the build directory:

- build-demo.sh - End to end self contained build example for testing the repository after changes to templates.
- build-pipeline-server.sh - Used by client repository to builds three assets:
  - PDF/Word for submitting to job portals
  - PDF/Word for submitting to end clients (strips cover sheet/contact info)
  - PDF of the candidate information sheet.
- BuildTemplate-* : Templatized YAML metadata files that get rendered during the build process to be used by Pandoc.
- resume-docx-reference.docx: Template "style" file for Word output.

### Outputs

- Word format output is a best effort . The style file was sourced from : <https://sdsawtelle.github.io/blog/output/simple-markdown-resume-with-pandoc-and-wkhtmltopdf.html> (vendored in vendor/git.knownelement.com/ExternalVendorCode/markdown-resume just in case)
- PDF output considered production. Please see: <https://github.com/Wandmalfarbe/pandoc-latex-template> (vendored in vendor/git.knownelement.com/ExternalVendorCode/pandoc-latex-template ) and <https://github.com/ReachableCEO/rcdoc-pipeline> if you want to re-create/modify the build pipeline for your own markdown project.

## Production Use

This system is in production use by the @ReachableCEO:

- [MarkdownResume-ClientExample-ReachableCEO](https://git.knownelement.com/reachableceo/MarkdownResume-ReachableCEO)
- [ReachableCEO Career Site](https://resume.reachableceo.com)
- uploaded to all major job portals

This was a labor of love by the @ReachableCEO in the hopes others can massively optimize the job hunt process.
