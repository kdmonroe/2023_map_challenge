# install.packages(c("sf", "ggplot2"))
library(sf)
library(ggplot2)


geojson_data <- st_read("/Users/champ/Documents/Github/map30_2023/day_1_points/phl_schools.geojson")

# p <- ggplot(data = geojson_data) +
#   geom_sf() +
#   theme_minimal()
# 
# p <- ggplot(data = geojson_data) +
#   geom_sf(aes(color = "GRADE_ORG")) +  # Replace with your column name
#   theme_minimal()
# print(p)

# Create the plot and assign to a variable
my_plot <- ggplot(data = geojson_data) +
  geom_sf(aes(color = GRADE_ORG)) +  # Visualize GRADE_ORG using different colors
  geom_sf_text(aes(label = GRADE_ORG), check_overlap = TRUE) +  # Add labels for GRADE_ORG
  theme_minimal() +
  labs(color = "GRADE_ORG")  # Add a legend title

# Display the plot
print(my_plot)

# print ggplot to file
# ggsave("phl_schools.png", width = 6, height = 6, dpi = 300)

