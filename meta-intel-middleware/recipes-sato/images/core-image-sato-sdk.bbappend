DESCRIPTION = "Custom list of packages for build essentials, graphics and audio"

IMAGE_INSTALL_append = " packagegroup-core-buildessential-extended"
IMAGE_INSTALL_append = " packagegroup-core-graphics-essential"
IMAGE_INSTALL_append = " packagegroup-core-audio-essential"
IMAGE_INSTALL_append = " packagegroup-core-devtools"

# Extra packages to install into image
IMAGE_INSTALL_append = " openssl"

# Remove linux-firmware-usb8897_uapsta.bin
ROOTFS_POSTPROCESS_COMMAND += "my_rootfs ;"

my_rootfs(){
	cd ${IMAGE_ROOTFS}/lib/firmware/mrvl/; rm -f usb8897_uapsta.bin
}
