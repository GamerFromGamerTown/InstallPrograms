#!/bin/bash

# Disk device
disk="/dev/vda"

# Partition sizes
size_vda1="1G"
size_vda2="8G"

# Create partitions
echo -e "o\nn\np\n1\n\n+${size_vda1}\nn\np\n2\n\n+${size_vda2}\nn\np\n3\n\n\nw" | fdisk "${disk}"

# Inform the kernel about the partition table changes
partprobe

# Format partitions
mkfs.vfat -F 32 "${disk}1"
mkswap "${disk}2"
mkfs.btrfs "${disk}3"

# Display partition information
echo "Partition information:"
lsblk "${disk}"

mount /dev/vda3 /mnt/gentoo/
mkdir -p /mnt/gentoo/boot/efi
mount /dev/gentoo/boot/efi
swapon /dev/vda2
chronyd -q
wget https://distfiles.gentoo.org/releases/amd64/autobuilds/20231001T170148Z/stage3-amd64-openrc-20231001T170148Z.tar.xz
mv stage3-*.tar.xz /mnt/gentoo
tar xpvf stage3-*.tar.xz --xattrs-include='*.*' --numeric-owner
nano /mnt/gentoo/etc/portage/make.conf
