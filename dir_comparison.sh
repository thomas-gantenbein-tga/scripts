#!/bin/bash
# Usage: dir_comparison.sh <Path>
# Run twice to see what changed in the directory between the two runs
directoryToWatch=$1
if [ ! -e /tmp/dirlist1.txt ]
then
 du --bytes --separate-dirs --all --exclude=/proc/* --exclude=/tmp* $directoryToWatch > /tmp/dirlist1.txt
 echo "created first list of files and directories"
 exit 0
fi

du --bytes --separate-dirs --all --exclude=/proc/*  --exclude=/tmp* $directoryToWatch > /tmp/dirlist2.txt
echo "created second list of files and directories"
diff --side-by-side --suppress-common-lines /tmp/dirlist1.txt /tmp/dirlist2.txt > /tmp/comparison.txt
linecount=$(cat /tmp/comparison.txt | wc -l)
if [ $linecount -eq 0 ]
then
  echo "No differences found"
else
  cat /tmp/comparison.txt
fi

rm /tmp/dirlist1.txt
mv /tmp/dirlist2.txt /tmp/dirlist1.txt

