#!/bin/sh
while read SDIR
do
  mkdir -p $PUB_PATH/$SDIR
done < `dirname $0`/subdirs.lst
