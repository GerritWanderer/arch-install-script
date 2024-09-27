#!/usr/bin/env bash

set -x #echo on

set -eo pipefail

# This is meant to be executed with arch-chroot /mnt
# and it has to be copied inside /mnt first
# example, after copying it to /mnt/root
# arch-chroot /mnt /root/04_configuration.sh

ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
hwclock --systohc

echo en_US.UTF-8 UTF-8 >>/etc/locale.gen
echo de_DE.UTF-8 UTF-8 >>/etc/locale.gen

locale-gen

cat >>/etc/locale.conf <<EOF
LANG=en_US.UTF-8
LC_ADDRESS=de_DE.UTF-8
LC_IDENTIFICATION=de_DE.UTF-8
LC_MEASUREMENT=de_DE.UTF-8
LC_MONETARY=de_DE.UTF-8
LC_NAME=de_DE.UTF-8
LC_NUMERIC=de_DE.UTF-8
LC_PAPER=de_DE.UTF-8
LC_TELEPHONE=de_DE.UTF-8
LC_TIME=de_DE.UTF-8
EOF

echo KEYMAP=us >>/etc/vconsole.conf

echo ${INST_HOSTNAME} >>/etc/hostname
