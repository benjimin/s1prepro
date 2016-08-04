Pre-processing of Sentinel 1
============================

This project aims to be pulled into the contrib section of the [AGDC](https://github.com/data-cube/agdc-v2). 

It takes Synthetic Aperture Radar data (specifically GRD scenes from the Sentinel 1 platform) and prepares it for ingestion into the datacube. It uses the Sentinel Toolbox (SNAP 4.0) software.

*NOTE: in-progress, not yet ready for use.*

Processing steps
----------------
Prerequisites: 
- Sentinel 1 GRD (ground-range, detected amplitude) scenes.
- Precise orbital ephemeris metadata. (Possibly also calibration?)
- A digital model for the elevations of the scattering surface (DSM/DEM).
- gpt (graph processing tool) from the Sentinel Toolbox software.
- Access to a configured AGDC instance.

Stages:

1. Update metadata (i.e. orbit vectors)
2. Trim border noise (an artifact of the S1 GRD products)
3. Calibrate (radiometric, outputting beta-nought)
4. Flatten (radiometric terrain correction)
5. Range-Doppler (geometric terrain correction)
6. Format for the AGDC (e.g. export metadata, tile and index)

Implementation
--------------
Initially will use auto-downloaded auxilliary data (ephemeris, DEM). Later, intend to use GDAL tools to subset a DSM, or test efficiency of chunked file-formats for the DSM raster.

Steps 1-4 will be combined in a gpt xml.

Step 5 will be a gpt command-line instruction. (Some operators chain together inefficiently, at least in previous gpt versions.)

Step 6 will be a python prep script.

The overall orchestration will initially be a shell script. (Other options would be a Makefile or a python cluster scheduling script.)

A jupyter notebook will demonstrate the result (using AGDC API).

Known flaws
-----------

- Ocean is masked out. (This is due to the nodata value used for the DEM by the terrain correction steps.)
- Border noise is not entirely eliminated (some perimeter pixels).
- Could conceive a more efficient unified radiometric/geometric terrain-correction operator (to reduce file IO concerning DSM)?
- Further comparison with GAMMA software output is necessary.
- Signal intensity units unspecified.
- Currently autodownloading ancilliary data (e.g. using 3s SRTM, which is suboptimal).

Instructions
------------

1. Ensure the environment has been prepared (run "datacube system check")
2. Define the products (run "datacube product add productdef.yaml")
3. Preprocess some scenes (run "demo.sh")
4. For each newly preprocessed scene, run a preparation script (e.g. "python prep.py output1.dim") to generate metadata (yaml) in an appropriate format for datacube indexing.
5. For each of those prepared scenes, index into the datacube (e.g. "datacube dataset add output1.yaml --auto-match")
6. Verify the data using the datacube API (e.g. a python notebook).


