#!/bin/bash
set -ex
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <ROCM_VERSION>"
    echo "Example: $0 5.3.3"
    exit 1
fi
ROCM_VERSION=$1
echo "ROCM_VERSION=${ROCM_VERSION}" >.env
docker build -t rocm-${ROCM_VERSION} .
sed "s/\${ROCM_VERSION}/${ROCM_VERSION}/g" docker-compose.yml.in >docker-compose.yml
docker-compose up -d
docker-compose run rocm-${ROCM_VERSION} /install.sh
docker-compose down
