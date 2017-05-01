#!/bin/env bash
#
# Preprocess a selection of overlapping scenes
#

# expect to take ~10min per scene, ~4x concurrency, ~10% sys versus user.

s1=/g/data/fj7/Copernicus/Sentinel-1/C-SAR/GRD/2015/2015-02/40S145E-45S150E/S1A_IW_GRDH_1SDV_20150223T090912_20150223T090925_004748_005E1F_4B90.zip
s2=/g/data/fj7/Copernicus/Sentinel-1/C-SAR/GRD/2015/2015-10/40S140E-45S145E/S1A_IW_GRDH_1SDV_20151015T192606_20151015T192629_008167_00B798_776D.zip
s3=/g/data/fj7/Copernicus/Sentinel-1/C-SAR/GRD/2015/2015-10/40S145E-45S150E/S1A_IW_GRDH_1SDV_20151021T090921_20151021T090934_008248_00B9DC_E779.zip
s4=/g/data/fj7/Copernicus/Sentinel-1/C-SAR/GRD/2015/2015-10/40S145E-45S150E/S1A_IW_GRDH_1SDV_20151022T191805_20151022T191825_008269_00BA6E_9CCF.zip

o1=output1.dim
o2=output2.dim
o3=output3.dim
o4=output4.dim

. prepro.sh $s1 $o1
. prepro.sh $s2 $o2
. prepro.sh $s3 $o3
. prepro.sh $s4 $o4


