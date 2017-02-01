FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
             file://0001-dri2-Sync-i915_pci_ids.h-and-i965_pci_ids.h-from-mes.patch \
             file://0001-dri2-Sync-i965_pci_ids.h-from-mesa.patch \
             "

PACKAGECONFIG_append = " xshmfence dri3 glamor"
PACKAGECONFIG[glamor] = "--enable-glamor,--disable-glamor,libepoxy,libegl"
