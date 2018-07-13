#!/bin/bash

set -e # If program fails -> fail script

USAGE="
Usage: ./build.sh [OPTIONS] REPOSITORY

Options:
  -h, --help              Display this message.
  -r, --run-args          Arguments added into command \"docker run <here> image\".  (default: \"\")
  -c, --container-args    Arguments added into command \"docker run image <here>\".  (default: \"\")

"


# FROM: https://stackoverflow.com/a/14203146/7607701
POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -h|--help)
    printf "$USAGE"
    exit 0
    ;;
    -r|--run-args)
    RUN_ARGS="$2"
    shift # past argument
    shift # past value
    ;;
    -c|--container-args)
    CONTAINER_ARGS="$2"
    shift # past argument
    shift # past value
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters


if [ $# -eq 0 ]; then
	printf "\nError: No repository given\n"
	echo "$USAGE"
	exit 1
fi

TAG="builder"
docker build -t $TAG -f build.dockerfile $1
docker run -v /var/run/docker.sock:/var/run/docker.sock $RUN_ARGS $TAG $CONTAINER_ARGS
