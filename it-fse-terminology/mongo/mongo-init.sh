#!/bin/bash

echo "Starting"

zstd_folder=/docker-entrypoint-initdb.d/mongo-dump/input
#No need to write in host fs
collections_folder=/tmp/output

echo "Input folder: $zstd_folder"
mkdir -p $collections_folder || { echo "Failed to create folder $collections_folder"; exit 1; }

echo "Decompressing files (.zstd)"
# Enter the target folder containing .zstd
cd $zstd_folder || { echo "Failed to enter folder ${zstd_folder}"; exit 1; }


# Iterate and extract
for file in *zst; do
  filename="${file%%.*}"
  echo "Decompressing: $filename"
  zstd -d < $file > $collections_folder/$filename.json || { echo "Failed to decompress $file"; exit 1; }
done

# Save on mongo
echo "Importing collections on MongoDB"
for file in ${collections_folder}/*json;do
collection_name="${file%%.*}"
mongoimport --db "fse" --collection "${collection_name}" --file $file --jsonArray
done

echo "Removing working folder"
rm -rf $collections_folder || { echo "Failed to remove folder $collections_folder"; exit 1; }
echo "Done"