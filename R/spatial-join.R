library(sf)

libraries <- read_sf("https://data.cityofchicago.org/resource/psqp-6rmg.geojson")

#alt - gives you <- 
#project the data
st_crs(libraries)
libraries <- st_transform(libraries, 32616)

areas <- read_sf("https://data.cityofchicago.org/resource/igwz-8jzy.geojson")

st_intersects(areas, libraries)


#project the data
st_crs(areas)
areas <- st_transform(areas, 32616)

library(ggplot2)

#make a map of both

ggplot()+
  geom_sf(data = areas)+
  geom_sf(data = libraries)


library(dplyr)

intersects <- st_intersects(areas, libraries)
filter(areas, lengths(intersects) == 0)
filter(areas, lengths(intersects) != 0)  #or (>0)

no_libraries_areas <- filter(areas, lengths (intersects) == 0)


#map places in chicago without libraries
ggplot()+
  geom_sf(data= areas)+
  geom_sf(data = no_libraries_areas, fill = "pink")

#try making a map of areas in chicago with more than 1 library

many_libraries <- filter(areas, lengths (intersects) > 1)
ggplot()+
  geom_sf(data= areas)+
  geom_sf(data = many_libraries, fill = "blue")

ggplot()+
  geom_sf(data= areas)+
  geom_sf(data = no_libraries_areas, fill = "red")+
  geom_sf(data = many_libraries, fill = "blue")

ggsave("doc/fig1.png", width = 5)

#Spatial Join

#count how many areas in each area
libraries_with_areas <- st_join(libraries, areas)

count(libraries_with_areas, community)

#use the pipe to do it in one line
st_join(libraries, areas) %>% count(community)

