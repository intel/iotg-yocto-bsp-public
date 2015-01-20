FILESEXTRAPATHS_append := "${THISDIR}/${PN}"

SRC_URI_append = "file://weston.ini"

do_install_append() {
	# Install weston.ini file into image rootfs
	install -d ${D}/home/root/.config/
	install -m 0755 ${WORKDIR}/weston.ini ${D}/home/root/.config/
}

FILES_${PN} += "/home/root/.config/weston.ini"
