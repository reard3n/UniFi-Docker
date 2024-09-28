#!/bin/bash

# do not run this twice. this is the script that creates the permanent storage locations for the containers we're using
lvcreate -L 100G -n docker.mongo ubuntu-vg
lvcreate -L 100G -n docker.unifi ubuntu-vg
lvcreate -L 10G -n docker.bind ubuntu-vg

mkfs -t xfs /dev/mapper/ubuntu--vg-docker.unifi
mkfs -t xfs /dev/mapper/ubuntu--vg-docker.mongo
mkfs -t xfs /dev/mapper/ubuntu--vg-docker.bind


echo "# docker storage mounts for unifi and mongo" >> /etc/fstab
echo "/dev/disk/by-uuid/7b122cae-bd63-4720-86c6-ba21a0e4c60c          /mnt/docker.mongo       xfs defaults 0 1" >> /etc/fstab
echo "/dev/disk/by-uuid/8660febf-c7af-489d-adca-f1daa50a43bd          /mnt/docker.unifi       xfs defaults 0 1" >> /etc/fstab
echo "/dev/disk/by-uuid/775aa627-52e1-48ba-8447-f6f7fb8de9cb          /mnt/docker.bind        xfs defaults 0 1" >> /etc/fstab
