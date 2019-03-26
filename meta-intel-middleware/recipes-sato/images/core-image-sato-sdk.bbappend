DESCRIPTION = "Custom list of packages for build essentials, graphics and audio"

require ${COREBASE}/meta-intel-middleware/recipes-core/images/core-image-essential.inc

IMAGE_INSTALL_append = " \
    openssl \
    packagegroup-core-devtools \
"
