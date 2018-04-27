SUMMARY = "lib64 -> lib symlink compatibility package"
DESCRIPTION = "Runtime linker compatibility package for prebuilt binary"
LICENSE = "MIT"

do_configure[noexec] = "1"
do_compile[noexec] = "1"

FILES_${PN} = "/lib64"
ALLOW_EMPTY_${PN} = "1"

do_install () {
	if [ "${BASELIB}" = "lib" ]; then
		ln -s "${BASELIB}" ${D}/lib64
	fi
}
