#!/bin/env bash
#
# Preprocess a Sentinel 1 scene using ESA SNAP (Sentinel 1 Toolbox) Graph Processing Tool
#
# Expected to take ~10min for one scene, ~4x concurrency, ~10% sys versus user.

if [ "$#" != "2" ]; then # validate argument count
    echo Usage: . prepro.sh input_scene.zip output_scene.dim
else

    GPT=./gpt # symlinked to bin/gpt of local SNAP install

    scene=$1
    radiometriconly=temp.dim # temporary intermediate
    output=$2

    # clean workspace
    rm -r temp.data temp.dim

        ./subset.sh $scene
        $GPT graph.xml -Sscene=$scene -t $radiometriconly
        $GPT Terrain-Correction -Ssource=$radiometriconly -t $output \
            -PexternalDEMFile=subset.tif -PexternalDEMNoDataValue=-999.5 -PnodataValueAtSea=false

    rm -r temp.data temp.dim

    # resample and compress (~5GB -> ~200MB)
    for img in ${output%.*}.data/*.img; do 
        gdalwarp $img ${img%.*}.tif \
            -t_srs EPSG:3577 -tr 25 25 -tap -r average -srcnodata 0 \
            -of GTIFF -co TILED=YES -co COMPRESS=DEFLATE -co SPARSE_OK=TRUE -co NUM_THREADS=4
        rm $img
    done

fi

