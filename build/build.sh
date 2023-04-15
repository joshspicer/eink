#!/bin/bash

FLAG="${1:-normal}"

if [ "$FLAG" == "debug" ]; then
    cat /build/template.tex
    exit 0
fi

if [ ! -d /output ]; then
    echo "Output directory does not exist! Bind mount a directory to /output"
    exit 1
fi

# Do whatever replacements in 'template.tex' to add content

pdflatex -interaction=nonstopmode /build/template.tex

cp /build/template.pdf /output/output.pdf

# convert /output/output.pdf -quality 200 -rotate -90 -resize 1200x825 /output/output.png

# -resize x825
convert /output/output.pdf  -quality 100 -rotate -90 -depth 1 /output/output.bmp

# Convert to 1 bit depth
# convert /output/tmp.bmp -depth 1 /output/output.bmp