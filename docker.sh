#!/bin/bash

# Makes data dir
mkdir nominatim-data

# Build the Docker image
docker build -t nominatim .

# Initialize the Nominatim database
docker run -it --rm \
    -e PBF_URL=https://ftp5.gwdg.de/pub/misc/openstreetmap/planet.openstreetmap.org/pbf/planet-221226.osm.pbf.torrent \
    -e REPLICATION_URL=https://ftp5.gwdg.de/pub/misc/openstreetmap/planet.openstreetmap.org/pbf/planet-latest.osm.pbf \
    -e NOMINATIM_PASSWORD=very_secure_password \
    -v nominatim-data:/var/lib/postgresql/14/main \
    -p 8080:8080 \
    --name nominatim \
    nominatim \
    ./init.sh

# Run the Docker container
docker-compose -f ./contrib/docker-compose.yml up