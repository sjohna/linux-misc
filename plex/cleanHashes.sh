#!/bin/bash

set -e

if [[ "$USER" != "plexsupport" ]]; then
    echo "cleanHashes.sh can only run as the plexsupport user"
    exit 1
fi

IFS=$'\n'
files=`find . -name '.*.hash'`

echo "Removing hash files without matching files."

for hashPath in $files
do
    dir=`dirname $hashPath`
    hashFile=`basename $hashPath`
    file="${hashFile:1}"
    file="${file%.hash}"
    filePath="$dir/$file"

    if [ ! -f "$filePath" ]; then
        echo "${hashPath}: no corresponding file, deleting"
	rm $hashPath
    fi
done
