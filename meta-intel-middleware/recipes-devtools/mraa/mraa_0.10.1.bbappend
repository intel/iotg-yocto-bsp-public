# This will remove java support for mraa
PACKAGES_remove = "${PN}-java"
PACKAGECONFIG_remove = "java"

SRC_URI += "file://0001-mraa-point-to-correct-install-paths.patch"
