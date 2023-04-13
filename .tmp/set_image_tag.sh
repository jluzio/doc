#!/bin/bash
export imageTag="--args '--set-string global.app.image.tag=$1'"
export imageTag2='--args "--set-string global.app.image.tag=$1"'
echo --args '--set-string global.app.image.tag=test'
echo 
