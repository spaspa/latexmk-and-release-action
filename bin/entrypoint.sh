#!/bin/sh -l
set -eux

FILE_NAME=${1:-main.tex}

# create directory to output aux
find . -name '*.tex' -exec dirname {} \; | uniq | sed -e 's_\./_out/_g' | sed -e '/^\./d' | xargs mkdir -p

latexmk "$FILE_NAME"

DATE=`date +"%Y.%m.%d.%I.%M.%S"`

# create release
res=`curl -H "Authorization: token $GITHUB_TOKEN" -X POST https://api.github.com/repos/$GITHUB_REPOSITORY/releases \
-d "
{
  \"tag_name\": \"v$(echo ${DATE})\",
  \"target_commitish\": \"$GITHUB_SHA\",
  \"name\": \"main.pdf v$(echo ${DATE})\",
  \"draft\": false,
  \"prerelease\": false
}"`

# extract release id
rel_id=`echo ${res} | python3 -c 'import json,sys;print(json.load(sys.stdin)["id"])'`

# upload built pdf
curl -H "Authorization: token $GITHUB_TOKEN" -X POST https://uploads.github.com/repos/$GITHUB_REPOSITORY/releases/${rel_id}/assets?name=main.pdf\
  --header 'Content-Type: application/pdf'\
  --upload-file out/main.pdf
