#load libraries 
library(sf)
library(ggplot2)
library(dplyr)


#import with sf

ward86 <- read_sf("data/ward1986.shp")



#project 
st_crs(ward86)
st_area(ward86)
st_buffer(ward86) #does not work with unprojected data

ward86 <- st_transform(ward86, 32616)
st_crs(ward86)


#calculate centroids
#plot with ggplot2
ggplot()+
  geom_sf(data = ward86)

centroids <- st_centroid(ward86)

ggplot()+
  geom_sf(data = ward86) + 
  geom_sf(data = centroids)

st_buffer(centroids, 1000)
st_crs(centroids)

centroids_buffer <- st_buffer(centroids, 1000)
st_crs(centroids)


ggplot()+
  geom_sf(data = ward86) + 
  geom_sf(data = centroids_buffer) +
  geom_sf(data = centroids) 

water <- read_sf("data/Waterways.geojson")

st_crs(water)
water <- st_transform(water, 32616)

ggplot()+
  geom_sf(data = water)

water <- filter(water, name != "LAKE MICHIGAN")

ggplot()+
  geom_sf(data = water)

ggplot()+
  geom_sf(data = ward86)+
  geom_sf(data = water, col = "blue")

####Spatial Intersection (Important!!!)

intersects <- st_intersects(ward86, water)

#st_intersection(ward86, water)

water_wards <- filter(ward86, lengths(intersects) > 0)

ggplot()+
  geom_sf(data = ward86)+
  geom_sf(data = water_wards)+
  geom_sf(data = water)


ggplot()+
  geom_sf(data = ward86)+
  geom_sf(data = water_wards, fill = "pink")+
  geom_sf(data = water, col = "blue")

