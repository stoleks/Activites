#!/bin/bash
# replace string in chapter dir
for entry in $1/*/*.tex ; do
  if grep -q -Fwi $2 $entry ; then
    echo "replace $2 in $entry"
    sed -i "s@$2@$3@g" $entry
  fi
done

# replace string in "root" dir
for entry in $1/*.tex ; do
  if grep -q -Fwi $2 $entry ; then
    echo "replace $2 in $entry"
    sed -i "s@$2@$3@g" $entry
  fi
done
