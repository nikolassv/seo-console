#!/bin/bash
#
# Gets some html meta data for a given URL
#
# Author: Nikolas Schmidt-Voigt <n.schmidt-voigt@googlemail.com>

SCRIPTNAME='htmlmeta.sh'
RESPONSEFILE='httpresponse.tmp~'

usage () {
  echo "Usage: $SCRIPTNAME url"
}

if (( $# == 1 ))
then
  curl "$1" -i -s > $RESPONSEFILE
  statuscode=$( grep HTTP "$RESPONSEFILE" | sed 's/HTTP\/1\.[01] \(.*\)/\1/')

  if [[ $statuscode =~ ^200 ]]
  then
    title=$(grep '<title>' "$RESPONSEFILE" | sed 's/.*<title>\([^<]*\).*/\1/')
    canonical=$(grep -e '<link[^>]*rel=["'']canonical' "$RESPONSEFILE" | sed 's/.*\(<link[^>]*rel=["'']canonical[^>]*>\)/\1/' | sed 's/.*href=["'']\([^"'']*\).*/\1/')
    robots=$(grep -e '<meta[^>]*name=["'']robots' "$RESPONSEFILE" | sed 's/.*\(<meta[^>]*name=["'']robots[^>]*>\)/\1/' | sed 's/.*content=["'']\([^"'']*\).*/\1/')

    echo "Title:            $title"
    echo "Canonical-Link:   $canonical"
    echo "Robots-Meta-Tag:  $robots"

  else
    echo $statuscode
  fi

  rm $RESPONSEFILE

else
  usage
fi

exit 0

