#!/bin/bash
########################################################################
# Configuration
########################################################################

# Linux-stable
KVER="4.1"
KTAG="4.1.22"
LOCAL_LINUX_BRANCH="linux-4.1.y"

LINUX_GIT='git://git.yoctoproject.org/linux-yocto-4.1'
SRC_REV='d03753ddb28a1141e550a67c99ac95789a424fc5'

########################################################################
# End of configuration
########################################################################

apply_bsp_meta_patch () {
	cur_dir=$(pwd)

	echo "Patching BSP meta layer ..."
	sleep 3

	git am $cur_dir/setup/patchset/bsp-meta/*.patch
	git am $cur_dir/setup/patchset/oe-meta/*.patch

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
	cd ../..

	case $machine in
		CAVS-HDA)
			echo -e "\nlocal.conf: machine: CAVS HD-Audio -- intel-corei7-64-cavs-hda \n"
			# MACHINE set to intel-corei7-64-cavs-hda by default.
			# Do nothing.
			;;
		CAVS-SSP)
			echo -e "\nlocal.conf: machine: CAVS SSP -- intel-corei7-64-cavs-ssp \n"
			# Remove default MACHINE -- intel-corei7-64-cavs-hda
			sed -i -e "/$MACHINE\ \?\?\=\ \"intel\-corei7\-64\-cavs\-hda\"/d" yocto_build/build/conf/local.conf
			# Replace with MACHINE specify for SSP Audio
			sed -i '1i MACHINE ??= \"intel-corei7-64-cavs-ssp\"' yocto_build/build/conf/local.conf
			;;
		HDA)
			echo -e "\nlocal.conf: machine: Legacy HD-Audio -- intel-corei7-64 \n"
			# Remove default MACHINE -- intel-corei7-64-cavs-hda
			sed -i -e "/$MACHINE\ \?\?\=\ \"intel\-corei7\-64\-cavs\-hda\"/d" yocto_build/build/conf/local.conf
			# Replace with MACHINE specify for Legacy Audio
			sed -i '1i MACHINE ??= \"intel-corei7-64\"' yocto_build/build/conf/local.conf
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
	apply_bsp_meta_patch

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
	apply_bsp_meta_patch

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
