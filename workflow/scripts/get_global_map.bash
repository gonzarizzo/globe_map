#!env bash

url="https://giscollective.s3.amazonaws.com/projectlinework/moriarty-hand.zip"

# make a directory to store data
mkdir resources/

# download shapefiles, unzip shape and remove zip file
wget -O resources/moriarty-hand.zip $url \
&& unzip -o -j resources/moriarty-hand.zip \
    "Small Scale/shp/Admin_0_polygons.CPG" \
    "Small Scale/shp/Admin_0_polygons.dbf" \
    "Small Scale/shp/Admin_0_polygons.prj" \
    "Small Scale/shp/Admin_0_polygons.sbn" \
    "Small Scale/shp/Admin_0_polygons.sbx" \
    "Small Scale/shp/Admin_0_polygons.shp" \
    "Small Scale/shp/Admin_0_polygons.shx" \
    -d resources/ \
&& rm resources/moriarty-hand.zip