#!/bin/bash
########################################################################
# Configuration
########################################################################

# Production Kernel based Linux
KVER="4.14"
IMG_BASE="core-image-rt-tsn"

########################################################################
# End of configuration
########################################################################

apply_combined_repo_commit () {
	echo   "Initial Repo Population: Apollo Lake BSP for linux-yocto ver-${KVER}" > VERSION.txt
	printf "\nCombo-layer configuration:\n" >> VERSION.txt
	cat setup/combolayer.conf >> VERSION.txt
	cat VERSION.txt
	git commit -F VERSION.txt
}

build_rt_image () {
	cur_dir=$(pwd)

	source oe-init-build-env

	# If there's no change in kernel srcrev/patch name, devsrc/kernel modules fail to detect that
	# linux-yocto build has changed that results in an old copy of kernel-devsrc from sstate. The
	# modules may also not get compiled again.
	# Make sure that we clean sstate before building any image.
	bitbake -c cleansstate virtual/kernel

	case $target in
		custom)
			echo "=========================================================================================="
			echo "At this point, you can change/add a custom configuration to local.conf if required.	"
			echo "local.conf file for this build is present at:						"
			echo $(pwd)"/conf										"
			echo "												"
			echo "When you're done, go to "$(pwd)" and run from this terminal:				"
			echo "$ bitbake <image_type>									"
			echo "												"
			echo "Supported image type:									"
			echo "- ${IMG_BASE}										"
			echo "- ${IMG_BASE}-sdk									"
			echo "=========================================================================================="
			exit 0
			;;
		rt-sdk)
			bitbake ${IMG_BASE}-sdk
			;;
		*)
			bitbake ${IMG_BASE}
			;;
	esac

	cd ${cur_dir}
}

build_bzImage () {
	cur_dir=$(pwd)

	source oe-init-build-env

	echo "Start baking ..."
	bitbake virtual/kernel

	cd ${cur_dir}
}

build_bsp () {
	cur_dir=$(pwd)

	echo "Fetching in Apollo Lake BSP ingredient now"
	setup/combo-layer -c setup/combolayer.conf init
	apply_combined_repo_commit

	echo "========================================================================="
	echo "By default, this setup script will create a brand new repo which combines"
	echo "meta-intel BSP layer and Yocto Project poky distro.                      "
	echo "If you don't need git tracking, please 'rm -rf .git' now                 "
	echo "========================================================================="

	build_rt_image

	cd ${cur_dir}
}

build_kernel () {
	cur_dir=$(pwd)

	echo "Fetching in Apollo Lake BSP ingredient now"
	setup/combo-layer -c setup/combolayer.conf init
	apply_combined_repo_commit

	echo "========================================================================="
	echo "By default, this setup script will create a brand new repo which combines"
	echo "meta-intel BSP layer and Yocto Project poky distro.                      "
	echo "If you don't need git tracking, please 'rm -rf .git' now                 "
	echo "========================================================================="

	build_bzImage

	cd ${cur_dir}
}

target=$1

case $1 in
	kernel)
		build_kernel;;
	*)
		build_bsp;;
esac

exit 0
