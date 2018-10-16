#! /bin/bash
version=$1
zip -x '*.git/*' -x build_release.sh -x '*.zip' -r docker-example-$version.zip .
