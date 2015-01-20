SUMMARY = "Include .xinitrc to /home/root"
DESCRIPTION = "Add GFX configuration to Yocto OS to different compositors"
AUTHOR = "Azril Ahmad <mohd.azril.ahmad@intel.com>"
SECTION = "examples"
LICENSE = "MIT"

LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

PR = "r0"

SRC_URI = "file://xinitrc"

S = "${WORKDIR}"

do_install() {
	install -d 0755 ${D}/home/root
	install -m 0755 ${S}/xinitrc ${D}/home/root/.xinitrc
}

FILES_${PN} += "/home/root/.xinitrc"
