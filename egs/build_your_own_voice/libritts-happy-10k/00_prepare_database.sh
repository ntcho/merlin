#!/bin/bash -e

if test "$#" -ne 2; then
    echo "Usage: ./00_prepare_database.sh <path_to_file_id_list_txt> <path_to_source_database_dir>"
    exit 1
fi

fild_id_list=$1  # file_id_list.txt
database_dir=$2  # ../../../data/libritts/database

mkdir -p database/{txt,wav,labels}

echo "Found $(cat $fild_id_list | wc -l) files from $fild_id_list"

cat $fild_id_list | xargs -I {} ln -s ../../$database_dir/wav/{}.wav database/wav/{}.wav
cat $fild_id_list | xargs -I {} ln -s ../../$database_dir/txt/{}.txt database/txt/{}.txt

echo "Created $(ls database/txt | wc -l) files to ./database/txt"
echo "Created $(ls database/wav | wc -l) files to ./database/wav"
