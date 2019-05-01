# to make a new folder from R
dir.create("scripts")

library(raster)
library(ggplot2)
library(sf)
rgb_band1_harv <- raster("NEON-DS-Airborne-Remote-Sensing/HARV/RGB_Imagery/HARV_RGB_Ortho.tif")

file_path <- "NEON-DS-Airborne-Remote-Sensing/HARV/RGB_Imagery/HARV_RGB_Ortho.tif"


class(rgb_band1_harv)

rgb_band1_harv_df <- as.data.frame(rgb_band1_harv, xy = TRUE)




ggplot()+
  geom_raster(data = rgb_band1_harv_df,
              aes(x = x, y = y, alpha = HARV_RGB_Ortho)) +
              coord_quickmap()
  
  
rgb_stack_harv <- stack(file_path)
rgb_stack_harv@layers
plotRGB(rgb_stack_harv, r = 1, g=2, b=3)



rgb_brick_harv <- brick(rgb_stack_harv)
plotRGB(rgb_brick_harv)


#something new!! cropping rasters

chm_path <- "NEON-DS-Airborne-Remote-Sensing/HARV/CHM/HARV_chmCrop.tif"

  boundry_paht <- "NEON-DS-Site-Layout-Files/HARV/HarClip_UTMZ18.shp"

chm_harv <- raster(chm_path)

chm_harv_df <- as.data.frame(chm_harv, xy = TRUE)
boundry_harv <- read_sf(boundry_paht)

ggplot()+
  geom_raster(data = chm_harv_df, aes(x = x, y = y, fill = HARV_chmCrop))+
  scale_fill_gradientn(colors = terrain.colors(10))+
  geom_sf(data = boundry_harv, fill = NA)

chm_crop <- crop(chm_harv, as(boundry_harv, "Spatial"))

boundry_sp <- as(boundry_harv, "Spatial")

chm_crop_df <- as.data.frame(chm_crop, xy = TRUE)

ggplot()+
  geom_raster(data = chm_crop_df, aes(x = x, y=y, fill = HARV_chmCrop))+  scale_fill_gradientn(colors = terrain.colors(10))
  geom_sf(data = boundry_sp, fill = NA)+
 
  



