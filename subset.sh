#!/bin/env bash
#
# This script crops the elevation model to the expected scene extent.
#
# It is necessary because otherwise SNAP performs poorly using continental-scale DSM.
#

file=$1
window=$(
grep POLYGON $(echo $file | sed 's:.zip$:.xml:') |
sed 's:^.*(::; s:).*$::' |
awk '
BEGIN{RS=","}
{for(i=1;i<3;i++)
    { min[i]=(min[i] && min[i]<$i ? min[i]:$i); max[i]=(max[i] && max[i]>$i ? max[i]:$i) }
}
END{ print min[1],max[2],max[1],min[2] }'
)
#echo $window
rm -f subset.tif
gdal_translate -projwin $window -projwin_srs EPSG:4326 -of GTiff -co TILED=YES elevation.tif subset.tif > /dev/null && 
    echo DSM OK $window

