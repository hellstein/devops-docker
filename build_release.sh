#! /bin/bash
zip -x '*.git/*' -x build_release.sh -x '*.zip' -r docker-example.zip .
