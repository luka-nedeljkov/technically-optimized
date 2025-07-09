#!/bin/bash

print_help() {
	echo "Usage: ./fix-client.sh <directory>"
	echo "Directory must contains .mrpack file"
	exit 1
}

if [[ -z "$1" ]]; then
	print_help
fi

if [ ! -d "$1" ]; then
	print_help
fi

cd $1

filename=$(ls -1 | grep mrpack)
version=$(echo $filename | sed "s/.mrpack//")

if [[ -z "$filename" ]]; then
	print_help
fi

mkdir temp
mv "$filename" temp
cd temp

unzip "$filename"

rm "$filename"

sed -i "s/\"client\": \"unsupported\"/\"client\": \"required\"/g" modrinth.index.json

zip "$filename" -r overrides modrinth.index.json

mv "$filename" ..
cd ..
rm -r temp
