#!/bin/sh

XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker_shigenaka.xauth
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

KITTI_ROOT_DIR="/mnt/hdd1/dataset/kitti/object"
NUSCENES_ROOT_DIR="/mnt/hdd2/dataset/nuscenes/v1.0/trainval"
LYFT_ROOT_DIR="/mnt/hdd2/dataset/lyft/kaggle2019/trainval"

docker run --gpus all -it --rm --shm-size 2g --name=pcdet \
    --volume=$XSOCK:$XSOCK:rw \
    --volume=$XAUTH:$XAUTH:rw \
    --volume="/home/shigenaka:/home/shigenaka:rw" \
    --volume="/mnt/hdd1:/mnt/hdd1:rw" \
    --volume="/mnt/hdd2:/mnt/hdd2:rw" \
    --volume="${KITTI_ROOT_DIR}:/data/Datasets/KITTI/Kitti/object:rw" \
    --volume="${NUSCENES_ROOT_DIR}:/data/Datasets/nuScenes:rw" \
    --volume="${LYFT_ROOT_DIR}:/data/Datasets/LYFT/trainval:rw" \
    --env="PYTHONPATH=$PYTHONPATH:`pwd`/.." \
    --env="XAUTHORITY=${XAUTH}" \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --env="TZ=Asia/Tokyo" \
    --user="shigenaka" \
    u16_cuda10.0_cudnn7_pytorch1.1.0:pcdet /bin/bash
