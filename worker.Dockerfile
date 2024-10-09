FROM python:3.10

RUN curl -sSL https://get.docker.com/ | sh

RUN git clone -b girder-5 https://github.com/girder/girder_worker && \
    pip install --no-cache-dir -e ./girder_worker

RUN git clone -b girder-5 https://github.com/girder/slicer_cli_web && \
    pip install --no-cache-dir -e ./slicer_cli_web[worker]

# TODO this can be removed once a fixed large-image-source-zarr is published
# https://github.com/girder/large_image/commit/6f9c0de4b2533793e5dbfce4ba574bb29e6c0dff
RUN pip install numcodecs imagecodecs
RUN git clone -b girder-5 https://github.com/girder/large_image.git && \
    pip install -e ./large_image[sources] --no-cache-dir --find-links https://girder.github.io/large_image_wheels && \
    pip install -e ./large_image/girder_annotation && \
    pip install -e ./large_image/girder

RUN git clone -b girder-5 https://github.com/DigitalSlideArchive/HistomicsUI && \
    pip install --no-cache-dir -e ./HistomicsUI

ENV C_FORCE_ROOT=true
