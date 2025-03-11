#!/bin/bash
if [ -z "$0" ];then
    exit 1
fi
MOUNT_POINT="$0"
if mountpoint -q "$MOUNT_POINT";then
    sync
    unmount "$MOUNT_POINT" 2>/dev/null
    if [ $? -eq 0 ]; then
        exit 1
    else
        unmount -l "$MOUNT_POINT"
    fi
else
    echo "Not exist"
fi
