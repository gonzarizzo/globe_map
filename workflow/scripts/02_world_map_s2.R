#!/usr/bin/env Rscript

library(sf)
library(s2)
library(ggplot2)

# load maps
co = s2_data_countries()
cty = s2_data_countries("Uruguay")

# extract the oceans
g = as_s2_geography(TRUE)
oc = s2_difference(g, s2_union_agg(co)) # oceans

# Find the centroid of the cty object
cty_centroid = s2_centroid_agg(cty)

# Convert the centroid to lat/lon coordinates
lat_lon = s2_as_text(cty_centroid)

# Extract the numeric coordinates from the WKT string
coords <- as.numeric(unlist(strsplit(gsub("POINT \\(|\\)", "", lat_lon), " ")))

# Store the coordinates in lon and lat objects
lon <- coords[1]
lat <- coords[2]

# visible half of the world
b = s2_buffer_cells(as_s2_geography(paste0(lat_lon)), 9800000) # visible half

# intersect the visible oceans and visible countries
i = s2_intersection(b, oc) # visible ocean
i2 = s2_intersection(b, co) # visible countries

# define orthographic projections
ortho <- paste0('+proj=ortho +lat_0=', lat, ' +lon_0=', lon, ' +x_0=0 +y_0=0 +a=6371000 +b=6371000 +units=m +no_defs')

# define a circle that will represent the oceans
circle <- st_point(x = c(0,0)) %>% st_buffer(dist = 6371000) %>% st_sfc(crs = ortho)

# create the graticule
grat <- sf::st_graticule(lon=seq(-180,180, 30),
                         lat = seq(-90,90, 30),
                         ndiscr = 5000)
grat2 = s2_intersection(b, grat) # visible graticulates

# world map in base R
plot(st_transform(st_as_sfc(i), paste0("+proj=ortho +lat_0=", lat, " +lon_0=", lon)), col = 'aliceblue')
plot(st_transform(st_as_sfc(grat2), paste0("+proj=ortho +lat_0=", lat, " +lon_0=", lon)), col = 'black', add = T)
plot(st_transform(st_as_sfc(i2), paste0("+proj=ortho +lat_0=", lat, " +lon_0=", lon)), col = 'gray', add = T)
plot(st_transform(st_as_sfc(cty), paste0("+proj=ortho +lat_0=", lat, " +lon_0=", lon)), col = 'darkgreen', add = T)

# world map in ggplot language
ggplot() +
  geom_sf(data=st_as_sfc(grat2), color = 'black') +
  geom_sf(data = circle, fill = 'aliceblue', alpha=0.5)+
  geom_sf(data=st_as_sfc(i2), fill='gray80', color = 'black') +
  geom_sf(data=st_as_sfc(cty), fill='darkgreen', color = 'black') +
  coord_sf(crs = ortho) +
  theme(panel.grid.major = element_blank(),
        panel.background = element_rect(fill = NA))
