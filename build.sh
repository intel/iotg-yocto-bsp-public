#!/bin/bash
########################################################################
# Configuration
########################################################################

# Yocto Project Poky based Linux
KVER="4.1"

########################################################################
# End of configuration
########################################################################

apply_kernel_patch () {
	cur_dir=$(pwd)

	# This is to apply MR1 patches on top of Gold Release base.
	echo "Untar kernel tarball to obtain patches ..."

	cd setup/patchset

	case $tarball in
		LEGACY)
			echo -e "Extracting kernel patches with legacy HD Audio driver \n"
			tar xvjf auto_nightly_integrator-linux-nossp-*.tar.bz2
			;;
		CAVS)
			echo -e "Extracting kernel patches with IoTG SSP Audio driver \n"
			tar xvjf auto_nightly_integrator-linux-2*.tar.bz2
			;;
	esac

	cd ${cur_dir}
	cd meta-intel-leafhill/recipes-kernel/linux/linux-yocto

	# Move the patches over into meta-intel.
	mv $cur_dir/setup/patchset/patches/* .
	rm -rf  $cur_dir/setup/patchset/patches

	git add --all .
	git commit -s -m "meta-intel: linux-yocto_4.1: update kernel patch for Apollo Lake BSP"

	cd ${cur_dir}
}

apply_combined_repo_commit () {
	echo   "Initial Repo Population: Apollo Lake BSP for linux-yocto ver-${KVER}" > VERSION.txt
	printf "\nCombo-layer configuration:\n" >> VERSION.txt
	cat setup/combolayer.conf >> VERSION.txt
	cat VERSION.txt
	git commit -F VERSION.txt
}

apply_machine_local_conf () {
	cur_dir=$(pwd)

	case $machine in
		CAVS-SSP)
			# Need to turn on AUDIO_FEATURES = "ssp"
			echo "AUDIO_FEATURES = \"ssp\"" >> conf/local.conf
			;;
		*)
			# Default settings.
			# Do nothing.
			;;
	esac

	cd ${cur_dir}
}

build_sato_image () {
	cur_dir=$(pwd)

	source oe-init-build-env
	apply_machine_local_conf

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
			echo "- core-image-sato										"
			echo "- core-image-sato-sdk									"
			echo "=========================================================================================="
			exit 0
			;;
		sato-sdk)
			bitbake core-image-sato-sdk
			;;
		*)
			bitbake core-image-sato
			;;
	esac

	cd ${cur_dir}
}

build_bzImage () {
	cur_dir=$(pwd)

	source oe-init-build-env
	apply_machine_local_conf

	echo "Start baking ..."
	sleep 3
	bitbake linux-yocto

	cd ${cur_dir}
}

build_bsp () {
	cur_dir=$(pwd)

	echo "Fetching in Apollo Lake BSP ingredient now"
	sleep 3
	setup/combo-layer -c setup/combolayer.conf init
	apply_combined_repo_commit

	echo "========================================================================="
	echo "By default, this setup script will create a brand new repo which combines"
	echo "meta-intel BSP layer and Yocto Project poky distro.                      "
	echo "If you don't need git tracking, please 'rm -rf .git' now                 "
	echo "========================================================================="
	sleep 3

	build_sato_image

	cd ${cur_dir}
}

build_kernel () {
	cur_dir=$(pwd)

	echo "Fetching in Apollo Lake BSP ingredient now"
	sleep 3
	setup/combo-layer -c setup/combolayer.conf init
	apply_combined_repo_commit

	echo "========================================================================="
	echo "By default, this setup script will create a brand new repo which combines"
	echo "meta-intel BSP layer and Yocto Project poky distro.                      "
	echo "If you don't need git tracking, please 'rm -rf .git' now                 "
	echo "========================================================================="
	sleep 3

	build_bzImage

	cd ${cur_dir}
}

target=$1
tarball=$2
machine=$3

case $1 in
	kernel)		build_kernel;;
	*)		build_bsp;;
esac

exit 0
