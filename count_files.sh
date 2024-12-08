#!/bin/bash

for dir in s*/ ; do
  echo $dir
  ls -1U "$dir"* | wc -l ;
  ls -1U "$dir"*
  echo
done
