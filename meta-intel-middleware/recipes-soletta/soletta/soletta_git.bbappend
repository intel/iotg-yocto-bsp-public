FILESEXTRAPATHS_append := "${THISDIR}/files/"

SRC_URI += "file://0001-mqtt-fix-connect-to-broker-failed.patch \
            file://0002-IIO-activate-firmware-hardware-feature-before-read-o.patch \
            file://0004-iio-Add-support-for-iio-mount-matrix.patch \
            file://0005-samples-add-iio-network-samples-to-build.patch \
            file://0006-IIO-Network-add-c-code-sample-to-iio-network.patch \
            file://0009-samples-flow-c-api-add-iio-light-sensor.patch \
            file://0010-samples-flow-iio-network-add-iio-pressure-sensor-wit.patch \
            file://0011-samples-flow-iio-add-iio-hid-sensors-json-file.patch \
            file://0012-IIO-Network-fix-IIO-gyroscope-c-code-sample-klocwork.patch \
            file://0014-samples-flow-add-tilt-angle-sensor.patch \
"

RDEPENDS_${PN}-ptest_append = " bash"
RDEPENDS_${PN}-samples = "${PN} ${PN}-dev"

# soletta packages .so files in -dev package, so ignore this warning
INSANE_SKIP_${PN}-samples = "dev-deps"

INHIBIT_PACKAGE_STRIP = "1"
INHIBIT_DEFAULT_DEPS = "1"

RDEPENDS_${PN} += "\
    git-perltools \
    mosquitto-clients \
    python-dev \
    python-numpy \
    python-argparse \
    python-subprocess \
    python3-modules \
    python3-jsonschema \
"

RRECOMMENDS_${PN} += "${PN}-samples"

do_configure_append() {
   sed -i -e 's/^ *FLOW_SAMPLES=.*/# FLOW_SAMPLES is not set/g' ${S}/.config
}

do_compile_append() {
    oe_runmake TARGETCC="${CC}" TARGETAR="${AR}" samples
}

do_install_append() {
    mv ${D}${datadir}/gdb/auto-load/libsoletta.so.1.0.0-gdb.py ${D}${datadir}/gdb/auto-load/soletta-gdb.py
    install -d ${D}/opt/soletta/samples/iio+network
    install -m 0750 ${S}/build/stage/samples/iio+network/iio-gyroscope-console-and-mqtt-publish ${D}/opt/soletta/samples/iio+network
    install -d ${D}/opt/soletta/samples/flow/c-api
    install -m 0750 ${S}/build/stage/samples/flow/c-api/highlevel-iio-light ${D}/opt/soletta/samples/flow/c-api
    install -m 0640 ${S}/src/samples/flow/c-api/sol-flow-iio.json ${D}/opt/soletta/samples/flow/c-api
    install -d ${D}/opt/soletta/samples/flow/iio+network
    install -m 0750 ${S}/src/samples/flow/iio+network/pressure.fbp ${D}/opt/soletta/samples/flow/iio+network
    install -m 0750 ${S}/src/samples/flow/iio+network/pressure-console.fbp ${D}/opt/soletta/samples/flow/iio+network
    install -m 0750 ${S}/src/samples/flow/iio+network/pressure-mqtt.fbp ${D}/opt/soletta/samples/flow/iio+network
    install -m 0640 ${S}/src/samples/flow/iio+network/sol-flow-hid.json ${D}/opt/soletta/samples/flow/iio+network
    install -d ${D}/opt/soletta/samples/flow/iio
    install -m 0750 ${S}/src/samples/flow/iio/accelerate.fbp ${D}/opt/soletta/samples/flow/iio
    install -m 0640 ${S}/src/samples/flow/iio/sol-flow-hid.json ${D}/opt/soletta/samples/flow/iio
    install -d ${D}/opt/soletta/samples/flow/tilt-angle
    install -m 0750 ${S}/src/samples/flow/tilt-angle/tilt_angle.fbp ${D}/opt/soletta/samples/flow/tilt-angle
    install -m 0640 ${S}/src/samples/flow/tilt-angle/Makefile ${D}/opt/soletta/samples/flow/tilt-angle
    install -m 0640 ${S}/src/samples/flow/tilt-angle/README ${D}/opt/soletta/samples/flow/tilt-angle
    install -m 0640 ${S}/src/samples/flow/tilt-angle/arctan-spec.json ${D}/opt/soletta/samples/flow/tilt-angle
    install -m 0640 ${S}/src/samples/flow/tilt-angle/arctan-node.c ${D}/opt/soletta/samples/flow/tilt-angle
}

PACKAGES_prepend = " ${PN}-samples"

FILES_${PN}-samples = "/opt/soletta/samples/*"
