#!/bin/bash
#
# Gets the http status code for a given URL
#
# Author: Nikolas Schmidt-Voigt <nikolas.schmidt-voigt@dmc.de>

SCRIPTNAME='httpstatus.sh'
RESPONSEFILE='httpresponse.tmp~'

usage () {
  echo "Usage: $SCRIPTNAME url"
}

if (( $# == 1 ))
then
  curl "$1" -i -s > $RESPONSEFILE
  statuscode=$( grep HTTP "$RESPONSEFILE" | sed 's/HTTP\/1\.[01] \(.*\)/\1/')

  echo "Status: $statuscode"

  if [[ $statuscode =~ ^301 ]]
  then
    location=$(grep Location "$RESPONSEFILE" | sed 's/Location:\(.*\)/\1/')
    echo "---> $location"
  fi

  rm $RESPONSEFILE

else
  usage
fi

exit 0

