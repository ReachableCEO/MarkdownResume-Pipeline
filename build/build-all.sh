#!/usr/bin/env bash

#TODO make this work. For now, editing this script and setting the below export lines is required.
#source ./ResumeVariables.env

export CandidateName="First Middle Last"
export CandidatePhone="1 123 456 7890"
export CandidateLocation="Place 1/Place 2"
export CandidateEmail="candidate@domain.com"
export CandidateOneLineSummary="Super awesome and stuff."
export CandidateLinkedin="linkedin.com"
export CandidateGithub="github.com"
export CandidateLogo=""
export CandidateTagline="Your.Tagline.Here."
export ResumeSourceCode="https://git.knownelement.com/reachableceo/MarkdownResume-Pipeline"
export URLCOLOR="blue"
export PAGEBACKGROUND="../vendor/git.knownelement.com/ExternalVendorCode/pandoc-latex-template/examples/page-background/backgrounds/background3.pdf"

####################################################
#DO NOT CHANGE ANYTHING BELOW THIS LINE
####################################################

# shellcheck disable=SC1091
#source "$(dirname "${BASH_SOURCE[0]}")/bash3boilerplate.sh"

############################################################
# Setup globals
############################################################

readonly BUILD_OUTPUT_DIR="../build-output"
readonly BUILD_TEMP_DIR="../build-temp"
readonly BUILDYAML_JOBBOARD="$BUILD_TEMP_DIR/JobBoard.yml"
readonly BUILDYAML_CLIENTSUBMISSION="$BUILD_TEMP_DIR/ClientSubmission.yml"

echo "Cleaning up from previous runs..."

JobBoardMarkdownOutputFile="$BUILD_OUTPUT_DIR/job-board/Resume.md"
JobBoardPDFOutputFile="$BUILD_OUTPUT_DIR/job-board/Resume.pdf"
JobBoardMSWordOutputFile="$BUILD_OUTPUT_DIR/job-board/Resume.doc"

ClientSubmissionMarkdownOutputFile="$BUILD_OUTPUT_DIR/client-submission/Resume.md"
ClientSubmissionPDFOutputFile="$BUILD_OUTPUT_DIR/client-submission//Resume.pdf"
ClientSubmissionMSWordOutputFile="$BUILD_OUTPUT_DIR/client-submission/Resume.doc"

rm $BUILDYAML_JOBBOARD
rm $JobBoardMarkdownOutputFile
rm $JobBoardPDFOutputFile
rm $JobBoardMSWordOutputFile

rm $BUILDYAML_CLIENTSUBMISSION
rm $ClientSubmissionMarkdownOutputFile
rm $ClientSubmissionPDFOutputFile
rm $ClientSubmissionMSWordOutputFile

# Expand variables into rendered YAML files. These will be used by pandoc to create the output artifacts

./mo ./BuildTemplate-JobBoard.yml > $BUILDYAML_JOBBOARD
./mo ./BuildTemplate-ClientSubmission.yml > $BUILDYAML_CLIENTSUBMISSION

echo "Combining markdown files into single input file for pandoc..."

# Create contact info md file
./mo ../Templates/ContactInfo/ContactInfo-JobBoard.md > $BUILD_TEMP_DIR/ContactInfo-JobBoard.md
./mo ../Templates/ContactInfo/ContactInfo-ClientSubmit.md > $BUILD_TEMP_DIR/ContactInfo-ClientSubmit.md

#Pull in contact info
cat $BUILD_TEMP_DIR/ContactInfo-JobBoard.md >> $JobBoardMarkdownOutputFile
echo " " >> $JobBoardMarkdownOutputFile

cat $BUILD_TEMP_DIR/ContactInfo-ClientSubmit.md >> $ClientSubmissionMarkdownOutputFile
echo " " >> $ClientSubmissionMarkdownOutputFile

echo "## Career Highlights" >> $JobBoardMarkdownOutputFile
echo "## Career Highlights" >> $ClientSubmissionMarkdownOutputFile

cat ../Templates/SkillsAndProjects/Projects.md >> $JobBoardMarkdownOutputFile
echo "\pagebreak" >> $JobBoardMarkdownOutputFile

cat ../Templates/SkillsAndProjects/Projects.md >> $ClientSubmissionMarkdownOutputFile
echo "\pagebreak" >> $ClientSubmissionMarkdownOutputFile

echo " " >> $JobBoardMarkdownOutputFile
echo "## Employment History" >> $JobBoardMarkdownOutputFile
echo " " >> $JobBoardMarkdownOutputFile

echo " " >> $ClientSubmissionMarkdownOutputFile
echo "## Employment History" >> $ClientSubmissionMarkdownOutputFile
echo " " >> $ClientSubmissionMarkdownOutputFile

#And here we do some magic...
#Pull in :

# employer
# title
# start/end dates of employment 
# long form position summary data from each position

IFS=$'\n\t'
for position in \
$(cat ../Templates/WorkHistory/WorkHistory.csv); do

COMPANY="$(echo $position|awk -F ',' '{print $1}')"
TITLE="$(echo $position|awk -F ',' '{print $2}')"
DATEOFEMPLOY="$(echo $position|awk -F ',' '{print $3}')"

echo " " >> "$JobBoardMarkdownOutputFile"
echo "**$COMPANY | $TITLE | $DATEOFEMPLOY**" >> $JobBoardMarkdownOutputFile
echo " " >> "$JobBoardMarkdownOutputFile"

echo "**$COMPANY | $TITLE | $DATEOFEMPLOY**" >> $ClientSubmissionMarkdownOutputFile
echo " " >> "$ClientSubmissionMarkdownOutputFile"

echo " " >> "$JobBoardMarkdownOutputFile"
cat ../Templates/JobHistoryDetails/$COMPANY.md >> "$JobBoardMarkdownOutputFile"
echo " " >> "$JobBoardMarkdownOutputFile"

cat ../Templates/JobHistoryDetails/$COMPANY.md >> "$ClientSubmissionMarkdownOutputFile"
echo " " >> "$ClientSubmissionMarkdownOutputFile"
done

#Pull in my skills and generate a beautiful table.

echo "\pagebreak" >> $JobBoardMarkdownOutputFile
echo " " >> "$JobBoardMarkdownOutputFile"
echo "## Skills" >> "$JobBoardMarkdownOutputFile"
echo " " >> "$JobBoardMarkdownOutputFile"

echo "\pagebreak" >> $ClientSubmissionMarkdownOutputFile
echo " " >> "$ClientSubmissionMarkdownOutputFile"
echo "## Skills" >> "$ClientSubmissionMarkdownOutputFile"
echo " " >> "$ClientSubmissionMarkdownOutputFile"

#Table heading
echo "|Skill|Experience|Skill Details|" >> $JobBoardMarkdownOutputFile
echo "|---|---|---|" >> $JobBoardMarkdownOutputFile

echo "|Skill|Experience|Skill Details|" >> $ClientSubmissionMarkdownOutputFile
echo "|---|---|---|" >> $ClientSubmissionMarkdownOutputFile

#Table rows
IFS=$'\n\t'
for skill in \
$(cat ../Templates/SkillsAndProjects/Skills.csv); do
SKILL_NAME="$(echo $skill|awk -F '|' '{print $1}')"
SKILL_YEARS="$(echo $skill|awk -F '|' '{print $2}')"
SKILL_DETAIL="$(echo $skill|awk -F '|' '{print $3}')"
echo "|**$SKILL_NAME**|$SKILL_YEARS|$SKILL_DETAIL|" >> $JobBoardMarkdownOutputFile
echo "|**$SKILL_NAME**|$SKILL_YEARS|$SKILL_DETAIL|" >> $ClientSubmissionMarkdownOutputFile

done
unset IFS

echo "Generating PDF output for job board version..."

pandoc \
"$JobBoardMarkdownOutputFile" \
--template eisvogel \
--metadata-file="../build-temp/JobBoard.yml" \
--from markdown \
--to=pdf \
--output $JobBoardPDFOutputFile

echo "Generating MSWord output for job board version..."

pandoc \
"$JobBoardMarkdownOutputFile" \
--metadata-file="../build-temp/JobBoard.yml" \
--from markdown \
--to=docx \
--reference-doc=resume-docx-reference.docx \
--output $JobBoardMSWordOutputFile

echo "Generating PDF output for client submission version..."

pandoc \
"$ClientSubmissionMarkdownOutputFile" \
--template eisvogel \
--metadata-file="../build-temp/ClientSubmission.yml" \
--from markdown \
--to=pdf \
--output $ClientSubmissionPDFOutputFile

echo "Generating MSWord output for client submission version..."

pandoc \
"$ClientSubmissionMarkdownOutputFile" \
--metadata-file="../build-temp/ClientSubmission.yml" \
--from markdown \
--to=docx \
--reference-doc=resume-docx-reference.docx \
--output $ClientSubmissionMSWordOutputFile