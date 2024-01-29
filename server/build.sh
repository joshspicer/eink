#!/bin/bash

set -ex

FLAG="$1"
JSON_DATA="$2" # Optional

BASE_DESINATION_PATH='/usr/src/app/static'
BMP_DESTINATION_PATH="${BASE_DESINATION_PATH}/image.bmp"
INKPLATE_WIDTH=825
INKPLATE_HEIGHT=1200

if [ -z "$FLAG" ]; then
    echo "ERR: No flag provided"
    exit 1
fi

if [ -z "$JSON_DATA" ]; then
    echo "WARN: No JSON data provided"
fi

set +e
rm -rf /output
mkdir /output 
set -e

cd /output

if [ "$FLAG" == "newspaper" ]; then
    cp -r /templates/newspaper/* /output
    
    # Loop through all the headers and replace the markers
    for i in {1..3}
    do
        header=$(echo "$JSON_DATA" | jq -r ".header$i")
        marker="%%%%<header$i>%%%%"
        sed -i "s/$marker/$header/g" /output/template.tex
    done

    # Loop through all the data and replace the markers
    for i in {1..3}
    do
        data=$(echo "$JSON_DATA" | jq -r ".data$i")
        marker="%%%%<data$i>%%%%"
        sed -i "s/$marker/$data/g" /output/template.tex
    done

    # Update other variables
    fontsize=$(echo "$JSON_DATA" | jq -r ".fontsize")
    sed -i "s/%%%%<fontsize>%%%%/$fontsize/g" /output/template.tex

    pdflatex -interaction=nonstopmode /output/template.tex
    convert /output/template.pdf  -quality 100 -rotate -90 -depth 1 /output/output.bmp
    cp /output/output.bmp $BMP_DESTINATION_PATH
fi

if [ "$FLAG" == "recipe" ]; then
    cp -r /templates/recipe/* /output
    
    RECIPE_NAME=$(echo "$JSON_DATA" | jq -r '.mealQuery')

    if [ -z "$RECIPE_NAME" ]; then
        echo "ERR: No recipe name provided as mealQuery"
        exit 1
    fi

    /output/queryAndReplace.sh "$RECIPE_NAME"

    pdflatex -interaction=nonstopmode /output/template.tex

    # Png
    convert /output/template.pdf -colorspace RGB -trim -quality 100  /output/output.png
    cp /output/output.png "${BASE_DESINATION_PATH}/image-trimmed.png"

    convert /output/template.pdf -colorspace RGB -quality 100 /output/output.png
    cp /output/output.png "${BASE_DESINATION_PATH}/image.png"

    # Jpg
    convert /output/template.pdf -trim -quality 100 /output/output.jpg
    cp /output/output.jpg "${BASE_DESINATION_PATH}/image-trimmed.jpg"

    # Native resolution
    convert /output/template.pdf -quality 100 /output/output.jpg
    cp /output/output.jpg "${BASE_DESINATION_PATH}/image.jpg"
    # Resize to inkplate's dimensions
    convert /output/output.jpg -resize "${INKPLATE_WIDTH}x${INKPLATE_HEIGHT}" /output/resized.jpg
    cp /output/resized.jpg "${BASE_DESINATION_PATH}/image-resized.jpg"

    # Bmp
    convert /output/template.pdf -trim -quality 100 -depth 1 /output/output_4.bmp
    cp /output/output_4.bmp "${BASE_DESINATION_PATH}/image-trimmed.bmp"

    convert /output/template.pdf  -quality 100 -depth 1 /output/output_5.bmp
    cp /output/output_5.bmp $BMP_DESTINATION_PATH
fi

if [ "$FLAG" == "web" ]; then
    # Extract image extension from URL

    TARGET_URL=$(echo "$JSON_DATA" | jq -r '.url')

    ext="${TARGET_URL##*.}"

    # Download image from URL temporarily
    wget -O /output/target.$ext $TARGET_URL

    # Convert to bmp
    convert /output/target.$ext -rotate -90 -depth 1 /output/output.bmp

    cp /output/output.bmp $BMP_DESTINATION_PATH
fi