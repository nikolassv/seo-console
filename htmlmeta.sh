#!/bin/bash
#
# Gets some html meta data for a given URL
#
# Author: Nikolas Schmidt-Voigt <nikolas.schmidt-voigt@dmc.de>

SCRIPTNAME='htmlmeta.sh'
RESPONSEFILE='httpresponse.tmp~'

while read url
do
  curl "$url" -i -s > $RESPONSEFILE
  statuscode=$( grep HTTP "$RESPONSEFILE" | sed 's/HTTP\/1\.[01] \(.*\)/\1/')

  if [[ $statuscode =~ ^200 ]]
  then
    title=$(grep '<title>' "$RESPONSEFILE" | sed 's/.*<title>\([^<]*\).*/\1/')
    canonical=$(grep -e '<link[^>]*rel=["'']canonical' "$RESPONSEFILE" | sed -e 's/.*\(<link[^>]*rel=["'']canonical[^>]*>\).*/\1/' -e 's/.*href=["'']\([^"'']*\).*/\1/')
    robots=$(grep -e '<meta[^>]*name=["'']robots' "$RESPONSEFILE" | sed -e 's/.*\(<meta[^>]*name=["'']robots[^>]*>\).*/\1/' -e 's/.*content=["'']\([^"'']*\).*/\1/')
    description=$(grep -e '<meta[^>]*name=["'']description' "$RESPONSEFILE" | sed -e 's/.*\(<meta[^>]*name=["'']description[^>]*>\).*/\1/' -e 's/.*content=["'']\([^"'']*\).*/\1/')

    echo "\"$url\", \"$title\", \"$canonical\", \"$robots\", \"$description\""
  else
    echo "\"$url\", \"$statuscode\""
  fi

  rm $RESPONSEFILE

done

exit 0

