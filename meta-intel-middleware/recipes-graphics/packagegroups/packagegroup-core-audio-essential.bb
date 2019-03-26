SUMMARY = "All audio packages for enabling audio test"
LICENSE = "MIT"
PR = "r1"

PACKAGE_ARCH = "${MACHINE_ARCH}"
inherit packagegroup

PACKAGES = "packagegroup-core-audio-essential"

RDEPENDS_packagegroup-core-audio-essential = "\
    alsa-tools \
    alsa-oss \
    faad2 \
    libsndfile1 \
    libpcap \
    pulseaudio-server \
    wavpack \
    "
