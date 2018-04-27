# Manual clean up to prevent QA errors, does not seemed to be cleaned properly otherwise.
do_install_append() {
    oe_runmake -C ${kerneldir}/tools/objtool clean -i
}
