#!/usr/bin/env bash

url="https://giscollective.s3.amazonaws.com/projectlinework/moriarty-hand.zip"

# make a directory to store data
mkdir resources/

# download shapefiles, unzip shape and remove zip file
wget -O resources/moriarty-hand.zip $url \
&& unzip -o resources/moriarty-hand.zip -d resources/ \
&& rm resources/moriarty-hand.zip