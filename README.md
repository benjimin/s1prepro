Pre-processing of Sentinel 1
============================

This project aims to be pulled into the contrib section of the [AGDC](https://github.com/data-cube/agdc-v2). 

It takes Synthetic Aperture Radar data (specifically GRD scenes from the Sentinel 1 platform) and prepares it for ingestion into the datacube. It uses the Sentinel Toolbox (SNAP 4.0) software.

Processing steps
----------------
Prerequisites: 
- Sentinel 1 GRD (ground-range, detected amplitude) scenes.
- Precise orbital ephemeris metadata. (Possibly also calibration?)
- A digital model for the elevations of the scattering surface (DSM/DEM).
- gpt (graph processing tool) from the Sentinel Toolbox software.

Stages:

1. Update metadata (i.e. orbit vectors)
2. Trim border noise (an artifact of the S1 GRD products)
3. Calibrate (radiometric, outputting beta-nought)
4. Flatten (radiometric terrain correction)
5. Range-Doppler (geometric terrain correction)
6. Format for the AGDC (e.g. export metadata, tile and index)

Implementation
--------------
Note, this is "for now" and not necessarily optimal.

Will use auto-downloaded auxilliary data (ephemeris, DEM) initially. Later, intend to use GDAL to subset a DSM, or test efficiency of chunked file-formats for the DSM raster.

Steps 1-4 will be combined in a gpt xml.

Step 5 will be a gpt command-line instruction. (Some operators chain together inefficiently, at least in previous gpt versions.)

Step 6 will be a python prep script.

The overall orchestration will initially be a shell script. (Other options would be a Makefile or a python cluster scheduling script.)

