DESCRIPTION = "Extra packages for Apollo-Lake"
LICENSE = "MIT"
PR = "r1"

inherit packagegroup

PACKAGES = "packagegroup-core-apl-extra"

RDEPENDS_packagegroup-core-apl-extra = "\
    piglit \
    ltp \
    mesa-demos \
    "
