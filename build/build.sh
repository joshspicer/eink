#!/bin/bash

TEX_SOURCE_DIR="${1:-/workspaces/eink/examples/newspaper}"

mkdir -p /tmp/build-newspaper
cp -r $TEX_SOURCE_DIR tmp/build-newspaper

pdflatex -interaction=nonstopmode /tmp/template.tex -output-directory /tmp/compiled.pdf
docker run --rm -v /workspaces/eink/examples/newspaper/:/imgs dpokidov/imagemagick /imgs/newspaperExample.pdf  -depth 1 -monochrome -resize 1200x  BMP3:/imgs/output.bmp