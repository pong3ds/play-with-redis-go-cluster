#!/bin/bash

docker-compose -f docker-compose-cluster.yml up -d --scale sentinel1=3 --scale slave1=2 --scale sentinel2=3 --scale slave2=2