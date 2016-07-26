#!/bin/env bash
#
# Preprocess Sentinel 1 scenes using gpt
#

GPT=./gpt # symlinked to bin/gpt of local SNAP install

scene=/g/data/fj7/SAR/Sentinel-1/GRD/2015-02/S1A_IW_GRDH_1SDV_20150223T090912_20150223T090925_004748_005E1F_4B90.zip
# original GRD scene

radiometriconly=temp.dim # temporary intermediate

output=output.dim # fully preprocessed scene

$GPT graph.xml -Sscene=$scene -t $radiometriconly
$GPT Terrain-Correction -Ssource=$radiometriconly -t $output

