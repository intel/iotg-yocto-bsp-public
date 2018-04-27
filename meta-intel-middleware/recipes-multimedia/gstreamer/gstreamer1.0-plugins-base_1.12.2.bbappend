FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
    file://0001-audiodecoder-fix-buffer-leak-in-error-code-path.patch \
    file://0001-playbin-Don-t-ref_sink-the-sinks-twice.patch \
    file://0001-ssaparse-Fix-buffer-leak-in-error-case.patch \
"
