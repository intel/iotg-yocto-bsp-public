FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://hwclock.service"

SYSTEMD_PACKAGES += "${PN}-hwclock"
SYSTEMD_SERVICE_${PN}-hwclock = "hwclock.service"
PACKAGES =+ "${PN}-hwclock"

do_install_append() {
	# Install hwclock.service to sync hwclock to system clock
	install -m 0644 ${WORKDIR}/hwclock.service ${D}${sysconfdir}/systemd/system/hwclock.service
}

RRECOMMENDS_${PN} += " ${PN}-hwclock"

FILES_${PN}-hwclock += "${sysconfdir}/systemd/system/hwclock.service"
