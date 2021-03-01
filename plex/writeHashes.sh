#!/bin/bash

set -e

if [[ "$USER" != "plexsupport" ]]; then
    echo "writeHashes.sh can only run as the plexsupport user"
    exit 1
fi

IFS=$'\n'
files=`find . -name '*.mkv'`

echo "Creating or updting hashes for files matching pattern *.mkv"

for filePath in $files
do
    dir=`dirname $filePath`
    file=`basename $filePath`
    hashFile=".$file.hash"
    hashPath="$dir/$hashFile"

    if [ -f $hashPath ]; then
        if [ $filePath -nt $hashPath ]; then
            echo "$filePath: hash exists but file is newer, regenerating."
            xxh128sum $filePath > $hashPath
        fi
    else
        echo "$filePath: no hash file found, generating."
        xxh128sum $filePath > $hashPath
    fi
done
