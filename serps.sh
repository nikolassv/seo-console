#!/bin/bash
#
# Retrieves search results for a given keyword
#
# Author: Nikolas Schmidt-Voigt <nikolas.schmidt-voigt@dmc.de>

SCRIPTNAME=serpnum.sh


while read keyword
do
  curl "http://www.google.de/search" --data-urlencode q="$keyword" -G -A 'Mozilla/5.0' -s | grep -o '<h3 class="r"><a href="/url[^''"]*"' | sed 's/.*url.q=\([^"&]*\).*/\1/'
  sleep 3s
done

exit 0
