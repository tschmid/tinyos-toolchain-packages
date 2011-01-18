#! /usr/bin/env bash
# Here we setup the environment
# variables needed by the tinyos 
# make system

echo "Setting up for TinyOS @version@"
export TOSROOT=
export TOSDIR=
export MAKERULES=

TOSROOT="/@prefix@/tinyos-@version@"
TOSDIR="$TOSROOT/tos"
CLASSPATH=$CLASSPATH:$TOSROOT/support/sdk/java
PYTHONPATH=.:$TOSROOT/support/sdk/python:$PYTHONPATH
MAKERULES="$TOSROOT/support/make/Makerules"

export TOSROOT
export TOSDIR
export CLASSPATH
export PYTHONPATH
export MAKERULES

