FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://xdg-runtime-dir.sh \
	    file://usb-otg-mux.sh"

do_install_append() {
	# Install script at profile.d to load automatically upon boot up
	install -d ${D}${sysconfdir}/profile.d/
	install -m 0755 ${WORKDIR}/xdg-runtime-dir.sh ${D}${sysconfdir}/profile.d/
	install -m 0755 ${WORKDIR}/usb-otg-mux.sh ${D}${sysconfdir}/profile.d/
}

FILES_${PN} += "${sysconfdir}/profile.d/*"
