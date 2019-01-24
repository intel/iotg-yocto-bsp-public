FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

## Time sync patch
SRC_URI += "\
		file://igb-Fine-tune-driver-offset-for-time-synchronization.patch \
	   "

## Kernel config
SRC_URI += "\
		file://tsn-sw-ref-qdisc.cfg \
	   "
