# Bash template from https://betterdev.blog/minimal-safe-bash-script-template/
#!/usr/bin/env bash

set -Eeuo pipefail
trap cleanup SIGINT SIGTERM ERR EXIT

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

cleanup() {
  trap - SIGINT SIGTERM ERR EXIT
  rm -rf $database_tmp_dir
}

die() {
  local msg=$1
  local code=${2-1} # default exit status 1
  msg "$msg"
  exit "$code"
}

### Choose root directory of dataset
echo "Root directory of the dataset: \c"
read -r dataset_dir
echo "$dataset_dir"

### Input patterns for wav files
echo "Patterns for wav files (default='*.wav'): \c"
read -r pattern_wav
if [[ -z "$pattern_wav" ]]; then
  pattern_wav="*.wav"
fi
echo "$pattern_wav"

### Find the wav files using the given pattern
list_wav=(`find "$dataset_dir/." -name "$pattern_wav" -type f`)
count_wav=${#list_wav[@]}
echo "Found $count_wav files matching '$pattern_wav'"

### Input patterns for txt files
echo "Patterns for txt files (default='*.txt'): \c"
read -r pattern_txt
if [[ -z "$pattern_txt" ]]; then
  pattern_txt="*.txt"
fi
echo "$pattern_txt"

### Find the txt files using the given pattern
list_txt=(`find "$dataset_dir/." -name "$pattern_txt" -type f`)
count_txt=${#list_txt[@]}
echo "Found $count_txt files matching '$pattern_txt'"

### Check whether the number of files match
if [[ $count_wav -ne $count_txt ]]; then
  die "Number of files does not match: $count_wav vs $count_txt"
fi

database_tmp_dir="$script_dir/../symlink_dataset_tmp"
database_final_dir="$script_dir/../database"

### Create txt and wav directories
mkdir -p $database_tmp_dir/{txt,wav}
echo "Creating symlinks to $database_tmp_dir..."

### Create symlink to ./database/{txt,wav}
for i in "${list_wav[@]}"; do
  ln -s "$i" "$database_tmp_dir/wav/$(basename $i)"
done
echo "Created $count_wav symlinks to '$script_dir/database/wav/'"

for i in "${list_txt[@]}"; do
  ln -s "$i" "$database_tmp_dir/txt/$(basename $i)"
done
echo "Created $count_txt symlinks to '$script_dir/database/txt/'"

### Rename to final directory
mv $database_tmp_dir $database_final_dir
echo "Completed creating symlinks to $database_final_dir"