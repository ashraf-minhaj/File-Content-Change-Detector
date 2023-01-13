#!/bin/bash
# 
# author: ashraf minhaj
# mail  : asrhaf_minhaj@yahoo.com

set -e                     # exit when any command fails

file="../src/app.py"       # change the file name according to your need
hash_file="../src/hash.md5"

if [[ ! -f $hash_file ]]
then
    # if the hash file does not exist, create a new one
    echo "content file does not exist, creating new one for future comparison."
    md5sum $file > $hash_file
else
    # read old file and make hash from the current file
    old_hash=$(cat $hash_file | awk '{ print $1 }')
    new_hash=$(sudo md5sum $file | awk '{ print $1 }')

    echo "hashes"
    echo "Old: $old_hash"
    echo "New: $new_hash"

    # compare old hash with the current file hash
    # if does not match, update content.md5 hash
    # if [ $old_hash = $new_hash ]
    if [ $(cat $hash_file | awk '{ print $1 }') = $(sudo md5sum $file | awk '{ print $1 }') ]
    then
        echo "No change detected"
    else
        echo "Content changed, updating hash. Do something."
        # do something here
        sudo md5sum $file > $hash_file
    fi
fi