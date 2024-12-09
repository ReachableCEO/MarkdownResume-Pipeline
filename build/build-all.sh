#!/bin/bash


#Read in candidate specific variables

source ./ResumeVarialbes.env

#############################################
# Setup globals
#############################################
export BUILD_TEMP_DIR="../build-temp"
export BUILD_OUTPUT_DIR="../build-output"
export BuildYamlJobBoard="$BUILD_TEMP_DIR/BuildJobBoard.yml"
export BuildYamlClientSubmission="$BUILD_TEMP_DIR/BuildClientSubmision.yml"

export CandidateName=$CandidateName
export CandidateLogo=$CandidateLogo
export CandidateTagline=$CandidateTagline
export ResumeSourceCode=$ResumeSourceCode
export URLCOLOR=$URLCOLOR
export PAGEBACKGROUND=$PAGEBACKGROUND

# Expand the variables into the rendered YAML files for use by the build process

./mo MarkdownResume-BuildTemplateInput-ClientSubmission.yml > $BuildYamlClientSubmission
./mo MarkdownResume-BuildTemplateInput-JobBoard.yml > $BuildYamlJobBoard


