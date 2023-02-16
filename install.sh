#!/bin/bash
set -ex
if ! grep -q "${ROCM_VERSION}" "/.installed"; then
    wget https://repo.radeon.com/rocm/apt/${ROCM_VERSION}/dists/ubuntu/main/binary-amd64/Packages ||
    wget https://repo.radeon.com/rocm/apt/${ROCM_VERSION}/dists/$(lsb_release -cs)/main/binary-amd64/Packages
    curl -fsSL http://repo.radeon.com/rocm/rocm.gpg.key | gpg --dearmor -o /usr/share/keyrings/rocm-archive-keyring.gpg &&
    ROCM_REPO=https://repo.radeon.com/rocm/apt/${ROCM_VERSION}/ \
    sh -c 'echo deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/rocm-archive-keyring.gpg] $ROCM_REPO ubuntu main > /etc/apt/sources.list.d/rocm.list' &&
    apt update &&
    apt install -y --no-install-recommends \
        $(cat Packages | grep "Package: " | sed "s/Package: //g" | sed -e "s/^mi.*//g" | sed -e "s/${ROCM_VERSION}$//g" | sed "s/.*nvidia.*//g" | sed "s/.*sharp.*//g" | sed "s/rocm-dkms//g" | sort | uniq | xargs) &&
    echo "${ROCM_VERSION}" >>/.installed
fi

