#!/bin/bash
#
# Retrieves search results for a given keyword
#
# Author: Nikolas Schmidt-Voigt <nikolas.schmidt-voigt@dmc.de>

SCRIPTNAME=serpnum.sh

usage () {
  echo "Usage: $SCRIPTNAME keyword"
}

if (( $# == 1 ))
then
  curl "http://www.google.de/search" --data-urlencode q="$1" -G -A 'Mozilla/5.0' -s | grep -o '<h3 class="r"><a href="/url[^''"]*"' | sed 's/.*url.q=\([^"&]*\).*/\1/'
else
  usage
fi

exit 0
