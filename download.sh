#!/bin/bash

## This script downloads and generates a suitable ext4 image from existing cloud
## images. For simplicity it currently only downloads from Ubuntu images, but it
## should not be a big effort to adapt to other cloud images.

function download() {
	echo "Downloading $2 and saving to $1..."

	curl -s -o $1 $2
}

function download_if_not_present() {
	[ -f $1 ] || download $1 $2
}


UBUNTU_VERSION=$1

if [ -z "$UBUNTU_VERSION" ]
then
	echo "You supply the ubuntu version as the first argument"
	exit 1
fi

mkdir -p out

kernel=$UBUNTU_VERSION-server-cloudimg-amd64-vmlinuz-generic
download_if_not_present \
	out/vmlinuz \
	https://cloud-images.ubuntu.com/$UBUNTU_VERSION/current/unpacked/$kernel

initrd=$UBUNTU_VERSION-server-cloudimg-amd64-initrd-generic
download_if_not_present \
	out/initrd-generic \
	https://cloud-images.ubuntu.com/$UBUNTU_VERSION/current/unpacked/$initrd


./extract-vmlinux.sh out/vmlinuz > out/vmlinux