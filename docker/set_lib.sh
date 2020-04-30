#!/bin/bash

BUILD_DIR="/opt/PCDet/build/lib.linux-x86_64-3.6/pcdet/ops"
STORE_DIR="../pcdet/ops"

cp "${BUILD_DIR}/iou3d_nms/iou3d_nms_cuda.cpython-36m-x86_64-linux-gnu.so" "${STORE_DIR}/iou3d_nms/"
cp "${BUILD_DIR}/roiaware_pool3d/roiaware_pool3d_cuda.cpython-36m-x86_64-linux-gnu.so" "${STORE_DIR}/roiaware_pool3d/"
echo "Done."