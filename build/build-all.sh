#!/usr/bin/env bash

# shellcheck disable=SC1091
source "$(dirname "${BASH_SOURCE[0]}")/bash3boilerplate.sh"

# Load environment variables
source "./ResumeVariables.env"

# Setup globals
readonly BUILD_TEMP_DIR="../build-temp"
readonly BUILD_OUTPUT_DIR="../build-output"
readonly BUILD_YAML_JOB_BOARD="$BUILD_TEMP_DIR/BuildJobBoard.yml"
readonly BUILD_YAML_CLIENT_SUBMISSION="$BUILD_TEMP_DIR/BuildClientSubmission.yml"

readonly CANDIDATE_NAME="$CandidateName"
readonly CANDIDATE_LOGO="$CandidateLogo"
readonly CANDIDATE_TAGLINE="$CandidateTagline"
readonly RESUME_SOURCE_CODE="$ResumeSourceCode"
readonly URL_COLOR="$URLCOLOR"
readonly PAGE_BACKGROUND="$PAGEBACKGROUND"

# Expand variables into rendered YAML files
./mo "MarkdownResume-BuildTemplateInput-ClientSubmission.yml" > "$BUILD_YAML_CLIENT_SUBMISSION"
./mo "MarkdownResume-BuildTemplateInput-JobBoard.yml" > "$BUILD_YAML_JOB_BOARD"

