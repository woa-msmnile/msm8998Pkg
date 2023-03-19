#!/bin/bash

cd "$(dirname "$0")"

while getopts  ":d:" opt; do
    case ${opt} in
        d) TARGET_DEVICE=${OPTARG};;
    esac
done


# Check arguments.
if [ -z ${TARGET_DEVICE} ]; then
    echo "Usage: build_uefi.sh -d <target_device>"
    echo ""
    echo "Available devices:"
    for i in $(ls Platforms/Msm8998Pkg/Device); do
        # skip if the directory is empty

        if [ -z "$(ls Platforms/Msm8998Pkg/Device/${i})" ]; then
            continue
        fi

        echo "    $(basename ${i})"
    done
    echo ""
    exit 1
fi

# Start the actual build:
if [ ${TARGET_DEVICE} = 'all' ]; then
    for i in $(ls Platforms/Msm8998Pkg/Device); do
        # skip if the directory is empty

        if [ -z "$(ls Platforms/Msm8998Pkg/Device/${i})" ]; then
            continue
        fi

        TARGET_DEVICE=$(basename ${i})
        # Update Configuration Map for each Device.
        rm Build/Msm8998-AARCH64/DEBUG_CLANG38/AARCH64/QcomPkg/PlatformPei/ -rf
        cp Platforms/Msm8998Pkg/Device/${TARGET_DEVICE}/Include/Configuration/DeviceConfigurationMap.h Silicon/QC/Msm8998/QcomPkg/Include/Configuration/DeviceConfigurationMap.h
        stuart_build -c Platforms/Msm8998Pkg/PlatformBuild.py TOOL_CHAIN_TAG=CLANG38 "TARGET_DEVICE=${TARGET_DEVICE}"
    done
else
    # Update Configuration Map.
    rm Build/Msm8998-AARCH64/DEBUG_CLANG38/AARCH64/QcomPkg/PlatformPei/ -rf
    cp Platforms/Msm8998Pkg/Device/${TARGET_DEVICE}/Include/Configuration/DeviceConfigurationMap.h Silicon/QC/Msm8998/QcomPkg/Include/Configuration/DeviceConfigurationMap.h
    stuart_build -c Platforms/Msm8998Pkg/PlatformBuild.py TOOL_CHAIN_TAG=CLANG38 "TARGET_DEVICE=${TARGET_DEVICE}"
fi
