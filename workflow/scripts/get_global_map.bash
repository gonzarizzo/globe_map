#!/usr/bin/env bash

url="https://giscollective.s3.amazonaws.com/projectlinework/moriarty-hand.zip"

# make a directory to store data
mkdir resources/

# download shapefiles, unzip shape and remove zip file
wget -O resources/moriarty-hand.zip $url \
&& unzip -j resources/moriarty-hand.zip \
    "Large Scale/shp/Admin_0_Polygons.CPG" \
    "Large Scale/shp/Admin_0_Polygons.dbf" \
    "Large Scale/shp/Admin_0_Polygons.prj" \
    "Large Scale/shp/Admin_0_Polygons.shp" \
    "Large Scale/shp/Admin_0_Polygons.shx" \
    -d resources/ \
&& rm resources/moriarty-hand.zip