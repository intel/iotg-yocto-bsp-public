SUMMARY = "IOTG TSN Reference Software"
HOMEPAGE = "https://github.com/intel/iotg_tsn_ref_sw"
AUTHOR = "Abdul Muttalib, Abdul Arif"
LICENSE = "BSD-3-Clause"
LIC_FILES_CHKSUM = "\
	file://LICENSE.txt;md5=3f809c79d03d707b90fb032c7f82350a \
	"
RDEPENDS_${PN} = "openavnu open62541 bash"
DEPENDS = "openavnu open62541 cmake-native"

inherit useradd

USERADD_PACKAGES = "${PN}"
GROUPADD_PARAM_${PN} = "ptp"

SRC_URI = "\
	git://github.com/intel/iotg_tsn_ref_sw/;protocol=https;nobranch=1;name=src \
	git://github.com/AVnu/OpenAvnu/;protocol=https;nobranch=1;name=openavnu;destsuffix=git/openavnu \
	"

SRCREV_src = "eb61b3f86c1044cf6dbc580f690d33ecc89bdd71"
SRCREV_openavnu = "c253bd9204ed0fe85619266c0da1a47fbfdaab0a"

PV = "1.2-git${SRCREV_src}"

SECURITY_CFLAGS_pn-${PN} = "${SECURITY_NO_PIE_CFLAGS}"
S = "${WORKDIR}/git"

FILES_${PN} += "${bindir} ${libdir} /opt/intel/iotg_tsn_ref_sw/*"
TARGET_CC_ARCH += "${LDFLAGS}"
EXTRA_OEMAKE = "OPENAVNU_DIR=${WORKDIR}/git/openavnu"

# Force staticdev (*.a) to be in ${PN} and not ${PN}-staticdev
FILES_${PN}-staticdev = ""
INSANE_SKIP_${PN} = "staticdev"

do_compile() {
	# compile for sample-app-taprio
	cd sample-app-taprio
	oe_runmake
	cd ..

	# compile for simple-talker-cmsg
	cd simple-talker-cmsg
	oe_runmake
	cd ..

	# compile for sample-app-1
	cd sample-app-1
	oe_runmake
	cd ..

	# compile for sample-app-opcua-pubsub
	compile_opcua
}

compile_opcua() {
	# compile sample-app-opcua-pubsub
	cd sample-app-opcua-pubsub
	mkdir -p build
	cd build
	cmake	-DOVERRIDE_CMAKE_ROOT_DIR_HOST=${STAGING_DIR_HOST} \
		-DOVERRIDE_CMAKE_ROOT_DIR_NATIVE=${STAGING_DIR_NATIVE} \
		-DOVERRIDE_CMAKE_ROOT_CROSS_DIR=${CROSS_DIR} \
		-DOVERRIDE_CMAKE_MODULE=${STAGING_DATADIR}/cmake/Modules/ \
		-DCROSS_COMPILE=1 \
		..
	oe_runmake
	cp tutorial_pubsub_* ..
	cd ..
	rm -rf build
}

do_install() {
	install -d ${D}${base_prefix}/opt/intel/iotg_tsn_ref_sw
	rm -rf ./open62541
	rm -rf ./openavnu
	rm -rf ./.git
	rm -rf ./patches
	rm -rf ./.pc
	cp -r . ${D}${base_prefix}/opt/intel/iotg_tsn_ref_sw
}

