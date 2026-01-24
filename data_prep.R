library(terra)
library(dplyr)

est <- terra::rast("Ensemble_1980-2023_EST.tif") %>%
  terra::project("epsg:4326")

inv <- terra::rast("Ensemble_1980-2023_INV.tif") %>%
  terra::project("epsg:4326")

writeRaster(est, "Ensemble_1980-2023_EST_epsg_4326.tif")
writeRaster(inv, "Ensemble_1980-2023_INV_epsg_4326.tif")