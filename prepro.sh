#!/bin/env bash
#
# Preprocess Sentinel 1 scenes using gpt
#

if [ "$#" != "2" ]; then # validate argument count
echo Usage: . prepro.sh input_scene.zip output_scene.dim
else

GPT=./gpt # symlinked to bin/gpt of local SNAP install

scene=$1
radiometriconly=temp.dim # temporary intermediate
output=$2

GPT graph.xml -Sscene=$scene -t $radiometriconly
GPT Terrain-Correction -Ssource=$radiometriconly -t $output

fi

