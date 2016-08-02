FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
	file://power-management-mei.rules \
	file://persistent-mei.rules \
	file://pci_pm.rules \
"

do_install_append() {
	# Install runtime pm and mei persistent naming
	install -m 0644 ${WORKDIR}/power-management-mei.rules	${D}${sysconfdir}/udev/rules.d/power-management-mei.rules
	install -m 0644 ${WORKDIR}/persistent-mei.rules	${D}${sysconfdir}/udev/rules.d/persistent-mei.rules

	# Install udev rule to enable s0ix support
	install -m 0644 ${WORKDIR}/pci_pm.rules         ${D}${sysconfdir}/udev/rules.d/pci_pm.rules
}
