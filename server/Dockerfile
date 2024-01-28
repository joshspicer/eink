FROM dpokidov/imagemagick:latest-bullseye

WORKDIR /templates

# Modified from https://github.com/sphinx-doc/sphinx-docker-images/blob/master/latexpdf/Dockerfile
RUN apt-get update -y \
 && apt-get install --no-install-recommends -y \
      graphviz \
      imagemagick \
      make \
      curl \
      wget \
      vim  \
      jq   \
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
      python3-pip

RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get update -y \
    && apt-get install -y nodejs

RUN apt-get autoremove \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install --no-cache-dir -U pip
RUN python3 -m pip install --no-cache-dir Sphinx==5.3.0 Pillow

# Copy newspaper template over to workdir
RUN rm -rf ./templates
ADD templates .

RUN mkdir /output

WORKDIR /usr/src/app
COPY package*.json ./
RUN mkdir ./static
RUN npm install
COPY . .
EXPOSE 3000

COPY build.sh /opt/build.sh
RUN chmod +x /opt/build.sh

ENTRYPOINT [ "node" ]
CMD ["server.js"]