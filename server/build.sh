#!/bin/bash

set -e

FLAG="$1"

if [ -z "$FLAG" ]; then
    echo "No flag provided"
    exit 1
fi

if [ "$FLAG" == "newspaper" ]; then
    # Do whatever replacements in 'template.tex' to add content
    # ...
    # ...

    cd /build
    pdflatex -interaction=nonstopmode /build/template.tex
    cp /build/template.pdf /output/output.pdf
    convert /output/output.pdf  -quality 100 -rotate -90 -depth 1 /output/output.bmp

    cp /output/output.bmp /usr/src/app/static/newspaper.bmp
fi
