#!/bin/bash
#
# Retrieves the number of search results for a given keyword
#
# Author: Nikolas Schmidt-Voigt <nikolas.schmidt-voigt@dmc.de>

SCRIPTNAME=serpnum.sh

usage () {
  echo "Usage: $SCRIPTNAME keyword"
}

if (( $# == 1 ))
then
  curl "http://www.google.de/search" --data-urlencode q="$1" -G -A 'Mozilla/5.0' -s | sed 's/.*resultStats">[^<0-9]*\([\.0-9]*\).*/\1\n/'
else
  usage
fi

exit 0
