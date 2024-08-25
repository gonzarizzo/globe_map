#!/usr/bin/env Rscript

# author: Gonzalo Rizzo

# setup ---------
# load packages
library(terra)
library(sf)
library(s2)
library(ggplot2)

# read world shapefile
co <- vect("resources/Large Scale/shp/Admin_0_polygons.shp")
cty <- co[co$Name=='Uruguay']

# Calculate the centroid of the cty polygon
cty_centroid <- centroids(cty)

# Reproject the centroid to WGS 84 (EPSG:4326)
cty_centroid_wgs84 <- project(cty_centroid, "EPSG:4326")

# Extract the latitude and longitude of the centroid
coords <- crds(cty_centroid_wgs84)
lon <- coords[1]
lat <- coords[2]

# visible half of the world
b = s2_buffer_cells(as_s2_geography(paste0("POINT(", lon, " ", lat, ")")), 9800000) # visible half

# intersect the visible oceans and visible countries
cty <- st_as_sf(cty)
co <- st_as_sf(co)

# extract the oceans
g = as_s2_geography(TRUE)
oc = s2_difference(g, s2_union_agg(co)) # oceans

i = s2_intersection(b, oc) # visible ocean
i2 <- s2_intersection(b, co) # visible countries

# define orthographic projections
ortho <- paste0('+proj=ortho +lat_0=', lat, ' +lon_0=', lon, ' +x_0=0 +y_0=0 +a=6371000 +b=6371000 +units=m +no_defs')

# define a circle that will represent the oceans
circle <- st_point(x = c(0,0)) %>% st_buffer(dist = 6371000) %>% st_sfc(crs = ortho)

# create the graticule
grat <- sf::st_graticule(lon=seq(-180,180, 30),
                         lat = seq(-90,90, 30),
                         ndiscr = 5000)
grat2 <- s2_intersection(b, grat) # visible graticulates

# world map in base R
pdf("results/base_cty_globe.pdf", 4, 4)
par(mar = c(1,1,1,1))
plot(st_transform(st_as_sfc(i), paste0("+proj=ortho +lat_0=", lat, " +lon_0=", lon)), col = 'aliceblue')
plot(st_transform(st_as_sfc(grat2), paste0("+proj=ortho +lat_0=", lat, " +lon_0=", lon)), col = 'black', add = T)
plot(st_transform(st_as_sfc(i2), paste0("+proj=ortho +lat_0=", lat, " +lon_0=", lon)), col = 'gray', add = T)
plot(st_transform(st_as_sfc(cty), paste0("+proj=ortho +lat_0=", lat, " +lon_0=", lon)), col = 'darkgreen', add = T)
dev.off()

# world map in ggplot language
pdf("results/ggplot_cty_globe_100.pdf", 4, 4)
ggplot() +
  geom_sf(data = st_transform(st_as_sfc(b), ortho), fill = '#FFFFFF', color = '#6E6E6F', alpha=1, linewidth = 0.5)+
  geom_sf(data=st_transform(st_as_sfc(grat2), ortho), color = '#6E6E6F', linewidth = 0.5) +
  geom_sf(data=st_transform(st_as_sfc(i2), ortho), fill='#CBCBCC', color = '#6E6E6F', linewidth = 0.5) +
  geom_sf(data=st_transform(st_as_sfc(cty), ortho), fill='#217439', color = '#6E6E6F', linewidth = 0.5) +
  theme(panel.grid.major = element_blank(),
        panel.background = element_rect(fill = NA))
dev.off()

tiff("results/cty_globe.tif", 4, 4, units = "in", res = 300)
ggplot() +
  geom_sf(data = circle, fill = '#FFFFFF', color = '#6E6E6F', alpha=1, linewidth = 0.5)+
  geom_sf(data=st_as_sfc(grat2), color = '#6E6E6F', linewidth = 0.5) +
  geom_sf(data=st_as_sfc(i2), fill='#CBCBCC', color = '#6E6E6F', linewidth = 0.5) +
  geom_sf(data=st_as_sfc(cty), fill='#217439', color = '#6E6E6F', linewidth = 0.5) +
  coord_sf(crs = ortho) +
  theme(panel.grid.major = element_blank(),
        panel.background = element_rect(fill = NA))
dev.off()
