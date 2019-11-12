DESCRIPTION = "Custom list of packages for build essentials, graphics and audio"

require ../../recipes-core/images/core-image-essential.inc

IMAGE_INSTALL_append = " \
    openssl \
    openssl-bin \
    packagegroup-core-devtools \
"
