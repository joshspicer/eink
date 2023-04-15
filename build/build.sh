#!/bin/bash

if [ ! -d /output ]; then
    echo "Output directory does not exist! Bind mount a directory to /output"
    exit 1
fi

# Do whatever replacements in 'template.tex' to add content

pdflatex -interaction=nonstopmode /build/template.tex
convert /build/template.pdf  -depth 1 -monochrome -resize 1200x  BMP3:/output/output.bmp