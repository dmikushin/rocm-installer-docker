#!/bin/bash
set -ex
if [ "$#" -ne 1 ]; then
	echo "Usage: $0 <ROCM_VERSION>"
	echo "Example: $0 5.3.3"
	exit 1
fi
ROCM_VERSION=$1
docker build -t rocm-${ROCM_VERSION} .
docker run --rm -it \
	-e ROCM_VERSION=${ROCM_VERSION} \
	-v /opt/rocm-${ROCM_VERSION}:/opt/rocm-${ROCM_VERSION} \
	-v $(pwd)/.installed:/.installed \
	rocm-${ROCM_VERSION} \
	bash /install.sh

