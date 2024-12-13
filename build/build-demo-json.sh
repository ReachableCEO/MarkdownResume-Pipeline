#!/bin/bash

#####################################################################################################
#JSON Resume
#####################################################################################################

export BUILD_OUTPUT_DIR="../build-output/JSONResume/"
export JSON_TEMPLATE_DIRECTORY="../Templates/JSONResume/"


###################################################################
# Modify the CandiateVariables.env file to refelct your information
###################################################################
###################################################

source "./CandidateVariables.env"

####################################################
####################################################
####################################################
#DO NOT CHANGE ANYTHING BELOW THIS LINE
####################################################
####################################################
####################################################

add_header() 

{

echo "{" > $BUILD_OUTPUT_DIR/resume.json

}

add_meta_section()

{

cat << META >> $BUILD_OUTPUT_DIR/resume.json
  "meta": {
    "theme": "$JSONRESUME_THEME"
  },
META

}

add_basics_section() 

{

cat << BASICS >> $BUILD_OUTPUT_DIR/resume.json
  "basics": {
    "name": "$CandidateName",
    "phone": "$CandidatePhone",
    "label": "$CandidateRole",
    "image": "$CandidateAvatar",
    "summary": "$CandidateOneLineSummary",
    "website": "$CandidateWebsite",
    "url": "https://lordajax.com",
    "email": "$CandidateEmail",
    "location": {
      "city": "$CandidateLocation",
      "countryCode": "$CandidateCountry"
    },
  },
BASICS

}

add_work_section() 
{

    local input_file=$JSON_TEMPLATE_DIRECTORY/work.csv
    cat << 'WORK_START'
  "work": [
WORK_START
    awk -F, 'NR>1 {
        printf "    {\n"
        printf "      \"name\": \"%s\",\n", $1
        printf "      \"position\": \"%s\",\n", $2
        printf "      \"url\": \"%s\",\n", $3
        printf "      \"startDate\": \"%s\",\n", $4
        if ($5 != "") printf "      \"endDate\": \"%s\",\n", $5
        printf "      \"summary\": \"%s\",\n", $6
        printf "      \"highlights\": [\n        \"%s\"\n      ]\n", gensub(/\|/, "\",\n        \"", "g", $7)
        printf "    }%s\n", (NR==NR?"":",")
    }' "$input_file"
    cat << 'WORK_END'
  ],
WORK_END

}

add_volunteer_section() 

{

  local input_file="$JSON_TEMPLATE_DIRECTORY/volunteer.csv"
  cat << 'VOLUNTEER_START' >> $BUILD_OUTPUT_DIR/resume.json
  "volunteer": [
VOLUNTEER_START
    
    awk -F, 'NR>1 {
        printf "    {\n"
        printf "      \"organization\": \"%s\",\n", $1
        printf "      \"position\": \"%s\",\n", $2
        printf "      \"url\": \"%s\",\n", $3
        printf "      \"startDate\": \"%s\",\n", $3
        printf "      \"endDate\": \"%s\",\n", $3
        printf "      \"summary\": \"%s\"\n", $4
        printf "      \"highlights\": ["
        printf "        " $7
        printf "      ]"
        printf "    }%s\n", (NR==NR?"":",")
    }' "$input_file"
    cat << 'VOLUNTEER_END'
  ],
VOLUNTEER_END

}

add_awards_section() 

{

    local input_file=$JSON_TEMPLATE_DIRECTORY/awards.csv
    cat << 'AWARDS_START' >> $BUILD_OUTPUT_DIR/resume.json
  "awards": [
AWARDS_START
    awk -F, 'NR>1 {
        printf "    {\n"
        printf "      \"title\": \"%s\",\n", $1
        printf "      \"date\": \"%s\",\n", $2
        printf "      \"awarder\": \"%s\",\n", $3
        printf "      \"summary\": \"%s\"\n", $4
        printf "    }%s\n", (NR==NR?"":",")
    }' "$input_file"
    cat << 'AWARDS_END'
  ],
AWARDS_END
}


add_publications_section() 

{

    local input_file=$JSON_TEMPLATE_DIRECTORY/publications.csv
    cat << 'PUBLICATIONS_START' >> $BUILD_OUTPUT_DIR/resume.json
  "publications": [
PUBLICATIONS_START
    awk -F, 'NR>1 {
        printf "    {\n"
        printf "      \"name\": \"%s\",\n", $1
        printf "      \"publisher\": \"%s\",\n", $2
        printf "      \"releaseDate\": \"%s\",\n", $3
        printf "      \"url\": \"%s\",\n", $4
        printf "      \"summary\": \"%s\"\n", $5
        printf "    }%s\n", (NR==NR?"":",")
    }' "$input_file"
    cat << 'PUBLICATIONS_END'
  ],
PUBLICATIONS_END

}

add_volunteer_section() 

{

    local input_file=$JSON_TEMPLATE_DIRECTORY/volunteer.csv
    cat << 'VOLUNTEER_START' >> $BUILD_OUTPUT_DIR/resume.json
  "volunteer": [
VOLUNTEER_START
    awk -F, 'NR>1 {
        printf "    {\n"
        printf "      \"organization\": \"%s\",\n", $1
        printf "      \"position\": \"%s\",\n", $2
        printf "      \"url\": \"%s\",\n", $3
        printf "      \"startDate\": \"%s\",\n", $4
        printf "      \"summary\": \"%s\",\n", $5
        printf "      \"highlights\": [\n        \"%s\"\n      ]\n", gensub(/\|/, "\",\n        \"", "g", $6)
        printf "    }%s\n", (NR==NR?"":",")
    }' "$input_file"
    cat << 'VOLUNTEER_END'
  ],
VOLUNTEER_END

}

add_skills_section() 

{

    local input_file="$JSON_TEMPLATE_DIRECTORY/skills.csv"
    cat << 'SKILLS_START' >> $BUILD_OUTPUT_DIR/resume.json
  "skills": [
SKILLS_START
    awk -F, 'NR>1 {
        printf "    {\n"
        printf "      \"keywords\": [\n        \"%s\"\n      ],\n", gensub(/\|/, "\",\n        \"", "g", $3)
        printf "      \"level\": \"%s\",\n", $2
        printf "      \"name\": \"%s\"\n", $1
        printf "    }%s\n", (NR==NR?"":",")
    }' "$input_file"
    cat << 'SKILLS_END'
  ],
SKILLS_END

}

add_education_section() 

{

    local input_file="$JSON_TEMPLATE_DIRECTORY/education.csv"
    cat << 'EDUCATION_START' >> $BUILD_OUTPUT_DIR/resume.json
  "education": [
EDUCATION_START
    awk -F, 'NR>1 {
        printf "    {\n"
        printf "      \"institution\": \"%s\",\n", $1
        if ($2 != "") printf "      \"url\": \"%s\",\n", $2
        printf "      \"area\": \"%s\",\n", $3
        printf "      \"studyType\": \"%s\",\n", $4
        printf "      \"startDate\": \"%s\",\n", $5
        printf "      \"endDate\": \"%s\"", $6
        if ($7 != "") printf ",\n      \"score\": \"%s\"", $7
        if ($8 != "") printf ",\n      \"courses\": [\n        \"%s\"\n      ]", gensub(/\|/, "\",\n        \"", "g", $8)
        printf "\n    }%s\n", (NR==NR?"":",")
    }' "$input_file"
    cat << 'EDUCATION_END'
  ],
EDUCATION_END

}

add_languages_section() 

{

    local input_file="$JSON_TEMPLATE_DIRECTORY/languages.csv"
    cat << 'LANGUAGES_START' >> $BUILD_OUTPUT_DIR/resume.json
  "languages": [
LANGUAGES_START
    awk -F, 'NR>1 {
        printf "    {\n"
        printf "      \"language\": \"%s\",\n", $1
        printf "      \"fluency\": \"%s\"\n", $2
        printf "    }%s\n", (NR==NR?"":",")
    }' "$input_file"
    cat << 'LANGUAGES_END'
  ],
LANGUAGES_END

}

add_interests_section() 

{
    local input_file="$JSON_TEMPLATE_DIRECTORY/interests.csv"
    cat << 'INTERESTS_START' >> $BUILD_OUTPUT_DIR/resume.json
  "interests": [
INTERESTS_START
    awk -F, 'NR>1 {
        printf "    {\n"
        printf "      \"name\": \"%s\",\n", $1
        printf "      \"keywords\": [\n        \"%s\"\n      ]\n", gensub(/\|/, "\",\n        \"", "g", $2)
        printf "    }%s\n", (NR==NR?"":",")
    }' "$input_file"
    cat << 'INTERESTS_END'
  ],
INTERESTS_END

}

add_references_section() 

{

    local input_file="$JSON_TEMPLATE_DIRECTORY/references.csv"
    cat << 'REFERENCES_START' >> $BUILD_OUTPUT_DIR/resume.json
  "references": [
REFERENCES_START
    awk -F, 'NR>1 {
        printf "    {\n"
        printf "      \"name\": \"%s\",\n", $1
        printf "      \"reference\": \"%s\"\n", $2
        printf "    }%s\n", (NR==NR?"":",")
    }' "$input_file"
    cat << 'REFERENCES_END'
  ]
REFERENCES_END

}


add_footer() 

{

echo "}" >> $BUILD_OUTPUT_DIR/resume.json

}

main()

{

  add_header
  add_meta_section $JSON_TEMPLATE_DIRECTORY/meta.csv
  add_basics_section $JSON_TEMPLATE_DIRECTORY/basics.csv
  #add_profiles_section $JSON_TEMPLATE_DIRECTORY/profiles.csv
  #add_work_section $JSON_TEMPLATE_DIRECTORY/work.csv
  #add_volunteer_section $JSON_TEMPLATE_DIRECTORY/volunteer.csv
  #add_education-section $JSON_TEMPLATE_DIRECTORY/education.csv
  #add_awards_section $JSON_TEMPLATE_DIRECTORY/awards.csv
  #add_certificates_section $JSON_TEMPLATE_DIRECTORY/certificates.csv
  #add_publications_section $JSON_TEMPLATE_DIRECTORY/publications.csv
  #add_skills_section $JSON_TEMPLATE_DIRECTORY/skills.csv
  #add_languages_section $JSON_TEMPLATE_DIRECTORY/languages.csv
  #add_interests_section $JSON_TEMPLATE_DIRECTORY/interests.csv
  #add_references_section $JSON_TEMPLATE_DIRECTORY/references.csv
  #add_projects_section $JSON_TEMPLATE_DIRECTORY/projects.csv
  add_footer

}


main