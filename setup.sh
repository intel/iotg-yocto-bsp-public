#!/bin/bash
#
# Description:
# A series of system check to ensure that users have setup a
# proper build environment for Yocto BSP build.
#

network_proxy_error() {
cat << EOF
ERROR: wget fail to fetch $HTTP_PATH/$TEST_FILE
NOTE:
You are either not connected or behind corporate proxy
Please make sure network proxies are setup at /etc/environment or
~/.bashrc :-
http_proxy=<http proxy server path>:<port>
ftp_proxy=<ftp proxy server path>:<port>
https_proxy=<https proxy server path>:<port>
socks_server=<SOCKS server path>:<port>
EOF
}

git_proxy_warn () {
cat << EOF
CAUTION: It seems that you may not have proper git proxy setup.
         Ignore this warning if you are NOT behind network proxy or have setup it properly.

Read more about how you can setup proxy for git from "git config -help
Example of setup is in ~/.gitconfig, under [core] define "gitproxy=<path to bash script>"
Example of bash script:
=============================================
#!/bin/bash
exec socat stdio SOCKS:<proxy IP/DNS>:\$1:\$2
=============================================
EOF
}

warn_and_exit () {
        echo -e $1
        echo "Press any key to exit."
        read -n 1
        exit 1
}

test_git () {
	# Checking if git is installed on system
	GIT_PATH=`whereis git | cut -d' ' -f2`

	if [ ! -f ${GIT_PATH} ]
	then
		echo "git is not installed on your system."
		sleep 3
		warn_and_exit "Please use software package manager like apt-get or yum to install it"
	fi
}

test_git_proxy () {
	GIT_PROXY=`env | grep ^GIT_PROXY_COMMAND | cut -d'=' -f2`
	GIT_CONFIG=`grep gitproxy ~/.gitconfig | cut -d'=' -f2`

	if [ -z "${GIT_CONFIG}" -a -z "${GIT_PROXY}" ]
	then
		git_proxy_warn
	fi
}

check_distro () {
        distro=$(cat /etc/*-release | sed -e "1q;d" | cut -d"=" -f2)
        version=$(cat /etc/*-release | sed -e "2q;d" | cut -d"=" -f2)
        ver_fail=0

        case $distro in
                Ubuntu)
                        if [ $version != "14.04" ]; then
                                ver_fail=1
                        fi
                        ;;

                Fedora)
                        if [ $version != "21" ]; then
                                ver_fail=1
                        fi
                        ;;
                *)
                        ver_fail=1
                        ;;
        esac

        if [ $ver_fail -eq 1 ]; then
                echo -e "The Linux OS of choice for Yocto Project build is Ubuntu 14.04 LTS. \nAll other versions are not supported."
                read -p "Would you still like to continue with the setup (Y/N)" answer
                if [[ $answer =~ [Yy] ]]; then
                        return
                else
                        exit 1
                fi
        fi
}

test_dependencies () {
        # List of packages that we need to check if installed on host machine
        # Works only for Ubuntu
        dependencies="gawk wget git-core diffstat unzip texinfo gcc-multilib build-essential chrpath socat libsdl1.2-dev xterm make xsltproc docbook-utils dblatex xmlto libglib2.0-dev xutils-dev nfs-common"

        if [ $distro == "Ubuntu" ]; then
                missing_deps=$(dpkg -l $dependencies 2>&1 | awk '{if (/^D|^\||^\+/) {next} else if(/^dpkg-query:/) { print $6} else if(!/^[hi]i/) {print $2}}')

                # Show a list of missing packages
                echo $missing_deps

                if [[ ! -z "$missing_deps" ]]; then
                        warn_and_exit "Please install the missing packages listed above before continuing with this setup."
                fi
        else
                echo "This setup needs following packages to be installed on the host machine:"
                echo $dependencies
                read -p "Please make sure that these are installed. Would you like to continue with the setup (Y/N)" answer
                if [[ $answer =~ [Yy] ]]; then
                        return
                else
                        exit 1
                fi
        fi
}

test_python () {
	# Checking if python is installed on system
	PYTHON_PATH=`whereis python | cut -d' ' -f2`

	if [ ! -f $PYTHON_PATH ]
	then
		echo "python is not installed on your system."
		sleep 3
		warn_and_exit "Please use software package manager like apt-get or yum to install it"
	fi
}

test_network_fetching () {
	# Checking if you are not behind corporate proxy and have not setup
	# your proxy correctly
	HTTP_PATH='http://git.yoctoproject.org/cgit/cgit.cgi/meta-jarvis/tree/meta-jarvis'
	TEST_FILE="jarvis.bb"

	wget -T 10 $HTTP_PATH/${TEST_FILE}

	if [ ! -f ${TEST_FILE} ]
	then
		network_proxy_error
		sleep 5
		exit 1
	else
		echo "SUCCESS: wget test is healthy."
		sleep 3
		rm ${TEST_FILE}
	fi
}

test_git_config () {
        username=$(git config --get user.name)
        if [ -z "$username" ]; then
                warn_and_exit "Please set your username for git before continuing with this setup. \nYou may use the command git config --global user.name \"<your_name>\""
        fi

        email=$(git config --get user.email)
        if [ -z "$email" ]; then
                warn_and_exit "Please set your email for git before continuing with this setup. \nYou may use the command git config --global user.email \"<your_email>\""
        fi
}

create_build_area () {
	cur_dir=$(pwd)

	cd ..

	if [ ! -d "yocto_build" ]
	then
		echo "Creating new build directory ..."
		sleep 3
		mkdir yocto_build
	else
		echo "Build directory yocto_build already exists"
		# Clean Up
		cd yocto_build
		rm -rf d* L* m* o* s* V* build/cache build/conf build/tmp build/bitbake.lock bitbake build.sh
		rm -rf .git*
		rm -rf .templateconf
		sleep 3
	fi

	cd ${cur_dir}
}

bsp_ingredient_update () {
	cur_dir=$(pwd)

	echo "Proceed to update ingredients ..."
	sleep 3

	cd ..

	cp -rf ${cur_dir}/* yocto_build
	cp -rf ${cur_dir}/.gitignore yocto_build/.
	cp -rf ${cur_dir}/.templateconf yocto_build/.

	cd yocto_build
	rm -rf .git

	# We don't want these to be installed in the yocto_build directory.
	rm setup.sh unsetup.sh

	cd ${cur_dir}
}

rebuild_message () {
	cur_dir=$(pwd)

	cd ../yocto_build

	echo -e "									"
	echo "=========================================================================="
	echo "Guidelines to rebuild your changes in BSP layers.				"
	echo "--------------------------------------------------------------------------"
	echo "You may do modification on build configurations and recipes layers.	"
	echo "Please make sure that you are doing customizations in yocto_build folder.	"
	echo -e "									"
	echo "When you are done and ready to REBUILD, go back to yocto_build directory.	"
	echo -e "									"
	echo "Then, run									"
	echo "$ source oe-init-build-env 						"
	echo -e "									"
	echo "To build a common Sato image [without dev tools],				"
	echo "$ bitbake core-image-sato							"
	echo -e "									"
	echo "To build a Full Sato image [with dev tools, build-essentials, etc],	"
	echo "$ bitbake core-image-sato-sdk						"
	echo -e "									"
	echo "To compile kernel bzImage only,						"
	echo "$ bitbake linux-yocto							"
	echo "=========================================================================="

	cd ${cur_dir}
	sleep 10
}

bsp_build () {
	cur_dir=$(pwd)

	cd ../yocto_build/

	if [ "$image" = "custom" ]; then
		echo "Building BSP with custom image ..."
		./build.sh custom $tarball $machine
	elif [ "$image" = "sato-sdk" ]; then
		echo "Building BSP with core-image-sato-sdk image ..."
		./build.sh sato-sdk $tarball $machine
	elif [ "$image" = "kernel" ]; then
		echo "Building kernel image only ..."
		./build.sh kernel $tarball $machine
	else
		echo "Building BSP with core-image-sato image ..."
		./build.sh sato $tarball $machine
	fi

	cd ${cur_dir}
}

build_bsp_sato () {
	cur_dir=$(pwd)

	prepare_env

	# Start preparing for bitbake build
	bsp_build

	echo "Entering build status checker ..."
	sleep 3

	if [ $machine == "CAVS-HDA" ]
	then
		cd ../yocto_build/build/tmp/deploy/images/intel-corei7-64-cavs-hda/
	elif [ $machine == "CAVS-SSP" ]
	then
		cd ../yocto_build/build/tmp/deploy/images/intel-corei7-64-cavs-ssp/
	elif [ $machine == "HDA" ]
	then
		cd ../yocto_build/build/tmp/deploy/images/intel-corei7-64/
	fi

	if [ ! -f core-image-sato-*.hddimg ]
	then
		echo "BSP Build: FAILED!!!"
		sleep 3
		echo "HDDIMG was not generated!"
		sleep 3
		echo "Please check the build log for detailed failure."
		sleep 3
		exit 1
	else
		echo "BSP Build: PASSED!!!"
		sleep 3
		rebuild_message
	fi

	cd ${cur_dir}
}

build_bsp_sato_sdk () {
	cur_dir=$(pwd)

	prepare_env

	# Start preparing for bitbake build
	bsp_build

	echo "Entering build status checker ..."
	sleep 3

	if [ $machine == "CAVS-HDA" ]
	then
		cd ../yocto_build/build/tmp/deploy/images/intel-corei7-64-cavs-hda/
	elif [ $machine == "CAVS-SSP" ]
	then
		cd ../yocto_build/build/tmp/deploy/images/intel-corei7-64-cavs-ssp/
	elif [ $machine == "HDA" ]
	then
		cd ../yocto_build/build/tmp/deploy/images/intel-corei7-64/
	fi

	if [ ! -f core-image-sato-sdk-*.hddimg ]
	then
		echo "BSP Build: FAILED!!!"
		sleep 3
		echo "HDDIMG was not generated!"
		sleep 3
		echo "Please check the build log for detailed failure."
		sleep 3
		exit 1
	else
		echo "BSP Build: PASSED!!!"
		sleep 3
		rebuild_message
	fi

	cd ${cur_dir}
}

build_bsp_custom () {
	cur_dir=$(pwd)

	prepare_env

	# Start preparing for bitbake build
	bsp_build

	cd ${cur_dir}
}

prepare_env () {
	cur_dir=$(pwd)

	# Run a series of tests to make sure that we can perform the repo setup
	check_distro
	test_dependencies
	test_python
	test_network_fetching
	test_git
	test_git_proxy
	test_git_config

	# Create a dedicated build area for BSP
	create_build_area

	# Update all ingredients before we start the build
	bsp_ingredient_update
}

build_kernel () {
	cur_dir=$(pwd)

	prepare_env

	# Start preparing for bitbake build
	bsp_build

	echo "Entering build status checker ..."
	sleep 3

	if [ $machine == "CAVS-HDA" ]
	then
		cd ../yocto_build/build/tmp/deploy/images/intel-corei7-64-cavs-hda/
	elif [ $machine == "CAVS-SSP" ]
	then
		cd ../yocto_build/build/tmp/deploy/images/intel-corei7-64-cavs-ssp/
	elif [ $machine == "HDA" ]
	then
		cd ../yocto_build/build/tmp/deploy/images/intel-corei7-64/
	fi

	if [ ! -f bzImage ]
	then
		echo "Kernel Build: FAILED!!!"
		sleep 5
		echo "bzImage was not generated."
		sleep 5
		echo "Please check the build log for detailed failure."
		sleep 5
		exit 1
	else
		echo "Kernel Build: PASSED!!!"
		sleep 3
		rebuild_message
	fi

	cd ${cur_dir}
}

echo -e "\nSelect an option: "
echo -e "1. Build kernel image with CAVS HD Audio driver (Default)\n2. Build kernel image with CAVS SSP Audio driver \n3. Build kernel image with legacy HD Audio driver"
echo -e "Default option is build kernel image with CAVS HD Audio driver. If no input is received within 20 secs, default will be used."
read -t 20 -p "" ans_to_patch

case $ans_to_patch in
	1)
		# CAVS HD Audio
		tarball="CAVS"
		machine="CAVS-HDA"
		;;
	2)
		# CAVS SSP Audio
		tarball="CAVS"
		machine="CAVS-SSP"
		;;
	3)
		# Legacy HD Audio
		tarball="LEGACY"
		machine="HDA"
		;;
	*)
		tarball="CAVS"
		machine="CAVS-HDA"
		;;
esac

echo -e "\nSelect an option: \n1. core-image-sato-sdk (Default)\n2. core-image-sato\n3. linux-kernel\n4. custom"
echo -e "Default build target is core-image-sato-sdk. If no input is received within 20 secs, default target will be built."
read -t 20 -p "" ans

case $ans in
	1)
		image="sato-sdk"
		build_bsp_sato_sdk
		;;
	2)
		image="sato"
		build_bsp_sato
		;;
	3)
		image="kernel"
		build_kernel
		;;
	4)
		image="custom"
		build_bsp_custom
		;;
	*)
		image="sato-sdk"
		build_bsp_sato_sdk
		;;
esac

exit 0
