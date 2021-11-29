#!/bin/bash

# Cache simple dict lookup.
# This way, when I look up a word multiple times, the command won't have to fetch the same definition repeatedly, which makes it a bit faster.
# Also pipes the definition to "less", just in case.

tempdir="/tmp/dictemp"
searchterm="$1"

[ ! -d "$tempdir" ] && mkdir "$tempdir"

if [ -z "$searchterm" ]; then
	echo "Enter a search term" >&2
	exit 1
fi

tempdef="$tempdir/$searchterm"
if [ -f "$tempdef" ]; then
	definition=$(<"$tempdef")
else
	definition=$(dict "$searchterm")
	if [ "$?" -ne 0 ]; then
		exit 2
	fi
	echo "$definition" > "$tempdef"
fi

echo "$definition" | less
