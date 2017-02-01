do_install_append() {
        echo "#" >> ${D}${sysconfdir}/sysctl.conf
        echo "# watchdog_thresh timing settings" >> ${D}${sysconfdir}/sysctl.conf
        echo "kernel.watchdog_thresh=60" >> ${D}${sysconfdir}/sysctl.conf
}
