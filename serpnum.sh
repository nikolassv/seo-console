#!/bin/bash
#
# Retrieves the number of search results for a given keyword
#
# Author: Nikolas Schmidt-Voigt <nikolas.schmidt-voigt@dmc.de>

SCRIPTNAME=serpnum.sh

while read keyword
do
  num=$(curl 'http://www.google.de/search' --data-urlencode q="$keyword" -G -A 'Mozilla/5.0' -s | sed 's/.*resultStats">[^<0-9]*\([\.0-9]*\).*/\1\n/')
  echo "\"$keyword\", \"$num\""
  sleep 3s
done

exit 0
