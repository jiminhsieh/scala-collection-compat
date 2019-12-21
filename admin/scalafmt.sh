#!/usr/bin/env bash

# set -x

HERE="`dirname $0`"
VERSION="1.5.1"
COURSIER="$HERE/.coursier"
SCALAFMT="$HERE/.scalafmt-$VERSION"

if [ ! -f $COURSIER ]; then
  curl -L -o $COURSIER https://git.io/vgvpD
  chmod +x $COURSIER
fi

if [ ! -f $SCALAFMT ]; then
  $COURSIER bootstrap com.geirsson:scalafmt-cli_2.11:$VERSION --main org.scalafmt.cli.Cli -o $SCALAFMT
  chmod +x $SCALAFMT
fi

error_message=`$SCALAFMT "$@"`

if [[ $error_message == *"Exception"* ]]; then
  exit 1
else
  exit 0
fi
