#!/usr/bin/env bash

# shellcheck disable=SC1091
#source "$(dirname "${BASH_SOURCE[0]}")/bash3boilerplate.sh"

# Setup globals
#readonly BUILD_OUTPUT_DIR="../build-output"
readonly BUILD_TEMP_DIR="../build-temp"
readonly BUILDYAML_JOBBOARD="$BUILD_TEMP_DIR/JobBoard.yml"
readonly BUILDYAML_CLIENTSUBMISSION="$BUILD_TEMP_DIR/ClientSubmission.yml"

#TODO make this work. For now, editing this script and setting the below export lines is required.
#source ./ResumeVariables.env

export CandidateName="First Middle Last"
export CandidateLogo=""
export CandidateTagline="Your.Tagline.Here."
export ResumeSourceCode="https://git.knownelement.com/reachableceo/MarkdownResume-Pipeline"
export URLCOLOR="blue"
export PAGEBACKGROUND="../vendor/git.knownelement.com/ExternalVendorCode/pandoc-latex-template/examples/page-background/backgrounds"

# Expand variables into rendered YAML files. These will be used by pandoc to create the output artifacts

./mo ./BuildTemplate-JobBoard.yml > $BUILDYAML_JOBBOARD
./mo ./BuildTemplate-ClientSubmission.yml > $BUILDYAML_CLIENTSUBMISSION