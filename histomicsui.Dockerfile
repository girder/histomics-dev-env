FROM ubuntu:22.04
LABEL maintainer="Kitware, Inc. <kitware@kitware.com>"

ENV DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LC_ALL=C.UTF-8

RUN apt-get update && apt-get install -qy \
    gcc \
    libpython3-dev \
    git \
    libldap2-dev \
    libsasl2-dev \
    python3-pip \
    curl \
&& apt-get clean && rm -rf /var/lib/apt/lists/* \
&& python3 -m pip install --upgrade --no-cache-dir \
    pip \
    setuptools \
    setuptools_scm \
    wheel

RUN curl -sL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -qy nodejs

RUN cd /opt && \
    git clone https://github.com/girder/girder_worker && \
    cd /opt/girder_worker && \
    git checkout girder-5 && \
    cd ./girder_worker/girder_plugin/web_client && npm i && npm run build && cd ../../.. && \
    pip install --no-cache-dir -e .

RUN cd /opt && \
    git clone https://github.com/girder/slicer_cli_web && \
    cd /opt/slicer_cli_web && \
    git checkout girder-5 && \
    cd ./slicer_cli_web/web_client && npm i && npm run build && cd ../.. && \
    pip install --no-cache-dir -e .[girder]

RUN cd /opt && \
    git clone https://github.com/girder/large_image.git && \
    cd /opt/large_image && \
    git checkout girder-5 && \
    pip install -e .[sources] --no-cache-dir --find-links https://girder.github.io/large_image_wheels && \
    cd ./girder_annotation/girder_large_image_annotation/web_client && npm i && npm run build && cd ../../.. && \
    pip install -e ./girder_annotation && \
    cd ./girder/girder_large_image/web_client && npm i && npm run build && cd ../../.. && \
    pip install -e ./girder

RUN cd /opt && \
    git clone https://github.com/DigitalSlideArchive/HistomicsUI && \
    cd /opt/HistomicsUI && \
    git checkout girder-5 && \
    cd ./histomicsui/web_client && npm i && npm run build && cd /opt/HistomicsUI && \
    pip install --no-cache-dir -e .[analysis]

RUN pip install gunicorn 'girder>=5.0.0a4' 'girder-sentry>=5.0.0a4'

WORKDIR /opt/
