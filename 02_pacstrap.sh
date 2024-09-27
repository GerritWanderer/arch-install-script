#!/usr/bin/env bash

set -x #echo on

set -eo pipefail

echo -ne "
pacstrap
"

pacstrap /mnt base base-devel linux linux-firmware

echo -ne "
Generating fstab
"

genfstab -U /mnt >>/mnt/etc/fstab

# remove subvolid to avoid problems with restoring snapper snapshots
sed -i 's/subvolid=.*,//' /mnt/etc/fstab

echo -ne "
Showing fstab
"

cat /mnt/etc/fstab
