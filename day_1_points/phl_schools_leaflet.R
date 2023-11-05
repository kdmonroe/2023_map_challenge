library(sf)
library(leaflet)
library(dplyr)  # for the filter function
library(htmlwidgets)
library(webshot)

geojson_filepath <- "/Users/champ/Documents/Github/map30_2023/day_1_points/phl_schools.geojson"
geojson_data <- st_read(geojson_filepath) %>%
  filter(GRADE_LEVEL != "UNGRADED")  # filter out schools with GRADE_LEVEL as "UNGRADED"
dir_gjson <- dirname(geojson_filepath)

# Sort GRADE_LEVEL in descending order for the legend
sorted_levels <- sort(unique(geojson_data$GRADE_LEVEL), decreasing = TRUE)

# Define a color palette based on GRADE_LEVEL categories
pal <- colorFactor(palette = "Dark2", domain = sorted_levels)

# Calculate the total number of schools
total_schools <- nrow(geojson_data)

map <- leaflet(geojson_data) %>%
  addTiles() %>%
  addCircleMarkers(
    color = ~pal(GRADE_LEVEL),  # Use the color palette
    fillOpacity = 0.8,
    radius = 5,
    popup = ~paste("School Name:", SCHOOL_NAME_LABEL, "<br>", "Type:", GRADE_LEVEL)
  ) %>%
  addLegend(pal = pal, values = ~GRADE_LEVEL, title = "School Type", position = "bottomright") %>%
  addControl(html = "<h2>Types of Schools In Philadelphia</h2>", position = "topright") %>%
  addControl(html = paste("Total Schools:", total_schools), position = "bottomleft")

print(map)

# Define the save paths
html_save_path <- file.path(dir_gjson, "map.html")
png_save_path <- file.path(dir_gjson, "map.png")

# # Save the map as an HTML file
saveWidget(map, file = html_save_path, selfcontained = FALSE)

# Convert the HTML to PNG
webshot(url = html_save_path, file = png_save_path)

print(paste("Map saved as:", html_save_path))
print(paste("Map saved as:", png_save_path))