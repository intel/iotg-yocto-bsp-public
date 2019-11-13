SUMMARY  = "Intel(R) unified HDCP SDK"
DESCRIPTION = "This is a user space implementation to prevent copying of \
digital audio & video content across digital display interfaces. It provides \
Linux user space implementation to enable the HDCP1.4 and HDCP2.2 protection \
for external digital display interface"
LICENSE  = "BSD-3-Clause"
LIC_FILES_CHKSUM = "file://LICENSE.md;md5=c50969be4feb8b99c6baa3795ede4dce"
SECTION = "lib"

inherit pkgconfig cmake useradd systemd distro_features_check

SRC_URI = "git://github.com/intel/hdcp.git \
        file://0001-main-fix-hdcpd-service-failure.patch \
"
SRCREV = "8543db04594d7a46ebc5a5fa14d5818bb1eb6327"
S = "${WORKDIR}/git"

REQUIRED_DISTRO_FEATURES = "systemd"

DEPENDS = "libdrm virtual/mesa systemd"

USERADD_PACKAGES = "${PN}"
USERADD_PARAM_${PN} = "--system --no-create-home --shell /bin/false --gid nogroup media"

SYSTEMD_SERVICE_${PN} = "hdcpd.service"
SYSTEMD_AUTO_ENABLE = "disable"
