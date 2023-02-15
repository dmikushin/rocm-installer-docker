#!/bin/bash
set -ex
if [ "1" != "$(cat /.installed)" ]; then
    curl -fsSL http://repo.radeon.com/rocm/rocm.gpg.key | gpg --dearmor -o /usr/share/keyrings/rocm-archive-keyring.gpg &&
    ROCM_REPO=https://repo.radeon.com/rocm/apt/${ROCM_VERSION}/ \
    sh -c 'echo deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/rocm-archive-keyring.gpg] $ROCM_REPO ubuntu main > /etc/apt/sources.list.d/rocm.list' &&
    apt update &&
    wget https://repo.radeon.com/rocm/apt/${ROCM_VERSION}/dists/focal/main/binary-amd64/Packages &&
    apt install -y --no-install-recommends \
        $(cat Packages | grep "Package: " | sed "s/Package: //g" | sed "s/^mi.*//g" | sed "s/.*nvidia.*//g" | sed "s/.*sharp.*//g" | sed "s/rocm-dkms//g" | xargs) &&
    echo 1 >/.installed
fi

