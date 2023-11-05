import datapackage
import pandas as pd
import plotly.express as px

# Load the data
data_url = 'https://datahub.io/core/corruption-perceptions-index/datapackage.json'
package = datapackage.Package(data_url)
resources = package.resources
for resource in resources:
    if resource.tabular:
        data = pd.read_csv(resource.descriptor['path'])
        break  # Exit the loop once the tabular data is found

# Check the data to ensure it has the necessary columns
print(data.head())

# Create the map
fig = px.choropleth(
    data,
    locations='Country_Code',  # Column with country codes
    color='Score',  # Column with the data values
    hover_name='Country',  # Column with country names
    color_continuous_scale=px.colors.sequential.Plasma,
    title='Corruption Perceptions Index'
)

# Show the map
fig.show()
