FROM dpokidov/imagemagick:latest-bullseye

# docker run --rm -v /workspaces/eink/examples/newspaper:/docs sphinxdoc/sphinx-latexpdf pdflatex  -interaction=nonstopmode template.tex
# docker run -v /workspaces/eink/examples/newspaper/:/imgs dpokidov/imagemagick /imgs/template.pdf  -density 300 -depth 1 -monochrome -resize 1200x  /imgs/output.bmp

WORKDIR /build

# Modified from https://github.com/sphinx-doc/sphinx-docker-images/blob/master/latexpdf/Dockerfile
RUN apt-get update \
 && apt-get install --no-install-recommends -y \
      graphviz \
      imagemagick \
      make \
      \
      latexmk \
      lmodern \
      fonts-freefont-otf \
      texlive-latex-recommended \
      texlive-latex-extra \
      texlive-fonts-recommended \
      texlive-fonts-extra \
      texlive-lang-cjk \
      texlive-lang-chinese \
      texlive-lang-japanese \
      texlive-luatex \
      texlive-xetex \
      xindy \
      tex-gyre \
      python3-dev \
      python3-pip \
 && apt-get autoremove \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install --no-cache-dir -U pip
RUN python3 -m pip install --no-cache-dir Sphinx==5.3.0 Pillow

# Copy newspaper template over to workdir
ADD template .

COPY build.sh /opt/build.sh
RUN chmod +x /opt/build.sh

ENTRYPOINT ["/opt/build.sh"]

