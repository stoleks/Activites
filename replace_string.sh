#!/bin/bash

for entry in $1/C*/*.tex ; do
  # echo $entry
  if grep -q -Fwi $2 $entry ; then
    echo "replace $2 in $entry"
    sed -i "s@$2@$3@g" $entry
  fi
done
