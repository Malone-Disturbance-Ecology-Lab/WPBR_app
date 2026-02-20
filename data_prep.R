library(terra)
library(dplyr)

# est <- terra::rast("Ensemble_1980-2023_EST.tif") %>%
#   terra::project("epsg:4326")
# 
# inv <- terra::rast("Ensemble_1980-2023_INV.tif") %>%
#   terra::project("epsg:4326")
# 
# writeRaster(est, "Ensemble_1980-2023_EST_epsg_4326.tif")
# writeRaster(inv, "Ensemble_1980-2023_INV_epsg_4326.tif")

# Now grab 1980-2099 for est
# Read in raster and project
est <- terra::rast("Ensemble_1980-2099_EST.tif") %>%
  terra::project("epsg:4326")

# Create empty templates
est_template_2024_2029 <- terra::rast(est[[1:6]])

# Set names
names(est_template_2024_2029) <- c("est-2024", "est-2025", "est-2026", "est-2027", "est-2028", "est-2029")
# Set the years to 2024-2029
time(est_template_2024_2029) <- c(2024:2029)

# Combine 1980-2023, 2024-2029, 2030-2099
est_1980_2099 <- c(est, est_template_2024_2029)
# Reorder rasters
est_1980_2099_sorted <- terra::subset(est_1980_2099, order(names(est_1980_2099)))
# Fix times
time(est_1980_2099_sorted) <- as.numeric(stringr::str_extract(names(est_1980_2099_sorted), "[:digit:]{4}"))

# ------------------------------------------------------

# Now grab 1980-2099 for inv
inv <- terra::rast("Ensemble_1980-2099_INV.tif") %>%
  terra::project("epsg:4326")

# Create empty templates
inv_template_2024_2029 <- terra::rast(inv[[1:6]])

# Set names
names(inv_template_2024_2029) <- c("inv-2024", "inv-2025", "inv-2026", "inv-2027", "inv-2028", "inv-2029")
# Set the years to 2024-2029
time(inv_template_2024_2029) <- c(2024:2029)

# Combine 1980-2023, 2024-2029, 2030-2099
inv_1980_2099 <- c(inv, inv_template_2024_2029)
# Reorder rasters
inv_1980_2099_sorted <- terra::subset(inv_1980_2099, order(names(inv_1980_2099)))
# Fix times
time(inv_1980_2099_sorted) <- as.numeric(stringr::str_extract(names(inv_1980_2099_sorted), "[:digit:]{4}"))

writeRaster(est_1980_2099_sorted, "Ensemble_1980-2099_EST_epsg_4326.tif", overwrite = TRUE)
writeRaster(inv_1980_2099_sorted, "Ensemble_1980-2099_INV_epsg_4326.tif", overwrite = TRUE)




