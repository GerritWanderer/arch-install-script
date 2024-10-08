#!/usr/bin/env bash

set -x #echo on

set -eo pipefail

echo -ne "
Enabling swap on ${SWAP_PARTITION}
"

swapon ${SWAP_PARTITION}

echo -ne "
BTRFS subvolumes on ${ROOT_PARTITION}
"

mount ${ROOT_PARTITION} /mnt
btrfs su cr /mnt/@
btrfs su cr /mnt/@home
btrfs su cr /mnt/@log
umount /mnt

echo -ne "
Mounting all partitions
"

mount -o subvol=/@,defaults,nodiscard,noatime,compress=zstd ${ROOT_PARTITION} /mnt
mount -o subvol=/@home,defaults,nodiscard,noatime,compress=zstd -m ${ROOT_PARTITION} /mnt/home
mount -o subvol=/@log,defaults,nodiscard,noatime,compress=zstd -m ${ROOT_PARTITION} /mnt/var/log

mount -o defaults,noatime -m ${EFI_PARTITION} /mnt/boot

# Create /var/lib/machines and /var/lib/portables
# So that systemd will not create them as nested subvolumes
mkdir -p /mnt/var/lib/machines
mkdir -p /mnt/var/lib/portables
