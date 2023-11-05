library(ggplot2)
library(sf)

# Read lines from GeoJSON files
sf_neighborhood <- st_read("/Users/champ/Documents/Github/map30_2023/day_2_3_polygons_lines/Neighborhoods_Philadelphia.geojson")
sf_bike_network <- st_read("/Users/champ/Documents/Github/map30_2023/day_2_3_polygons_lines/phl_bike_network.geojson")

# Plotting
gg <- ggplot() +
  # Plot neighborhoods with monotone color ramp
  geom_sf(data = sf_neighborhood, aes(fill = as.numeric(row.names(sf_neighborhood))), show.legend = FALSE) + 
  scale_fill_gradient(low = "white", high = "black") +
  
  # Plot bike network in black
  geom_sf(data = sf_bike_network, color = "violet", size = 0.5) +
  theme_minimal() +
  theme(legend.position = "none", 
        axis.title = element_blank()) +
  scale_x_continuous(labels = scales::number_format(accuracy = 0.01)) + 
  scale_y_continuous(labels = scales::number_format(accuracy = 0.01))

gg <- gg + 
  labs(title = "Philadelphia Bike Network", 
       subtitle = "Source: Open Data Philly, 2023")

print(gg)


print(gg)