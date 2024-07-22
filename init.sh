#!/bin/bash

set -ex -o pipefail

git clone -b girder-5 git@github.com:girder/girder_worker.git
git clone -b girder-5 git@github.com:girder/slicer_cli_web.git
git clone -b girder-5 git@github.com:girder/large_image.git
git clone -b girder-5 git@github.com:DigitalSlideArchive/HistomicsUI.git

pushd girder_worker/girder_worker/girder_plugin/web_client
npm i && npm run build
popd

pushd slicer_cli_web/slicer_cli_web/web_client
npm i && npm run build
popd

pushd large_image/girder/girder_large_image/web_client
npm i && npm run build
popd

pushd large_image/girder_annotation/girder_large_image_annotation/web_client
npm i && npm run build
popd

pushd HistomicsUI/histomicsui/web_client
npm i && npm run build
popd

docker-compose build
