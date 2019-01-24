SUMMARY = "Open source implementation of OPC UA aka IEC 62541"
HOMEPAGE = "http://open62541.org"
AUTHOR = "Hii, Roland King Guan"
LICENSE = "LGPLv3"
LIC_FILES_CHKSUM = "\
                    file://LICENSE;md5=815ca599c9df247a0c7f619bab123dad \
                   "

SRC_URI = "\
        gitsm://github.com/open62541/open62541.git;branch=master \
        file://0001-Modify-UA_Timer_addRepeatedCallback-to-accept-sub-mi.patch \
        file://0002-PubSub-Fixes-for-amalgamation-compilations.patch \
        file://0003-PubSub-Enable-publishing-using-SO_TXTIME-on-TAPRIO-E.patch \
        file://0004-PubSub-Workaround-to-enable-subscription-on-amalgama.patch"

SRCREV = "5a06ca2471fa973cddbac90553cd516db0809f04"
PV = "1.0-git${SRCPV}"
PR = "r0"

S = "${WORKDIR}/git"

inherit cmake pythonnative

DEPENDS = "python-six-native"

EXTRA_OECMAKE = "-DBUILD_SHARED_LIBS=ON -DUA_ENABLE_PUBSUB=ON \
                -DUA_ENABLE_PUBSUB_ETH_UADP=ON -DUA_ENABLE_SUBSCRIPTIONS=ON \
                -DUA_ENABLE_PUBSUB_SOTXTIME=ON -DUA_ENABLE_PUBSUB_SUBSCRIBER_AMALGAMATION=ON"

do_install_append(){
        install -m 644 open62541.h ${D}${includedir}/
}

