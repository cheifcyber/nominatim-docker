#!/bin/bash

# Build the Docker image
docker build -t nominatim .

# Initialize the Nominatim database
docker run -it --rm \
    -e PBF_URL=https://download.geofabrik.de/europe/monaco-latest.osm.pbf \
    -e REPLICATION_URL=https://download.geofabrik.de/europe/monaco-updates/ \
    -e NOMINATIM_PASSWORD=very_secure_password \
    -v nominatim-data:/var/lib/postgresql/14/main \
    -p 8080:8080 \
    --name nominatim \
    nominatim \
    ./init.sh

# Run the Docker container
docker-compose -f ./contrib/docker-compose.yml up