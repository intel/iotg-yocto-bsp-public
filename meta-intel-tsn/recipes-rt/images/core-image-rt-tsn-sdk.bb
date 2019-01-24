require recipes-core/images/core-image-minimal.bb

# Skip processing of this recipe if linux-intel-rt is not explicitly specified as the
# PREFERRED_PROVIDER for virtual/kernel. This avoids errors when trying
# to build multiple virtual/kernel providers.
python () {
    if d.getVar("PREFERRED_PROVIDER_virtual/kernel") != "linux-intel-rt":
        raise bb.parse.SkipPackage("Set PREFERRED_PROVIDER_virtual/kernel to linux-intel-rt to enable it")
}

DESCRIPTION = "Small image capable of booting a device with a test suite and \
tools for real-time use. It includes the full meta-toolchain, development \
headers, XFCE Window Manager, Time Sensitive Network (TSN) features and related libraries to form a standalone SDK."
DEPENDS += "linux-intel-rt"

IMAGE_FEATURES += "dev-pkgs tools-sdk tools-debug eclipse-debug tools-profile tools-testapps debug-tweaks splash package-management x11-base ssh-server-openssh ssh-server-dropbear hwcodecs"

inherit distro_features_check
REQUIRED_DISTRO_FEATURES = "x11"
require tsn-ref-sw.inc
require ${COREBASE}/meta-intel-middleware/recipes-core/images/core-image-essential.inc

IMAGE_INSTALL_append = " \
		packagegroup-base \
		 packagegroup-core-devtools \
		 packagegroup-core-x11 \
		 packagegroup-xfce-base \
		 kernel-modules \
		 rt-tests \
		 hwlatdetect \
		 kernel-dev \
		 kernel-devsrc \
		 ristretto \
"

TOOLCHAIN_HOST_TASK_append = " nativesdk-intltool nativesdk-glib-2.0 nativesdk-cmake nativesdk-cmake-dev"
TOOLCHAIN_HOST_TASK_remove_task-populate-sdk-ext = " nativesdk-intltool nativesdk-glib-2.0"
