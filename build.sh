#!/bin/sh

# git clone $1 ./project
# cd ./project
USAGE="Usage: build.sh <repository>"

if [ $# -eq 0 ]; then
	echo "No repository given\n"
	echo $USAGE
	exit 1
fi


if [ "$1" = "-h" ] [ "$1" = "--help" ]; then
	echo $USAGE
	exit 0
fi

TAG="builder"
docker build -t $TAG -f build.dockerfile $1
docker run -v /var/run/docker.sock:/var/run/docker.sock $TAG
