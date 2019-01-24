#!/bin/bash
#
# Description:
# A series of system check to ensure that users have setup a
# proper build environment for Yocto BSP build.
#

# Configuration
IMAGE=( rt rt-sdk kernel custom )
IMG_BASE="core-image-rt-tsn"

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
        ver_fail=1

        case $distro in
                Ubuntu)
                        if [ $version == "14.04" ]; then
                                ver_fail=0
                        elif [ $version == "16.04" ]; then
                                ver_fail=0
                        fi
                        ;;

                Fedora)
                        if [ $version == "21" ]; then
                                ver_fail=0
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
		warn_and_exit "Please use software package manager like apt-get or yum to install it"
	fi
}

test_network_fetching () {
	# Checking if you are not behind corporate proxy and have not setup
	# your proxy correctly
	HTTP_PATH='https://raw.githubusercontent.com/openembedded/openembedded-core/master/meta/conf'
	TEST_FILE="layer.conf"

	wget -T 10 $HTTP_PATH/${TEST_FILE}

	if [ ! -f ${TEST_FILE} ]
	then
		network_proxy_error
		exit 1
	else
		echo "SUCCESS: wget test is healthy."
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
		mkdir yocto_build
	else
		echo "Build directory yocto_build already exists"
		# Clean Up
		cd yocto_build
		rm -rf d* L* m* o* s* V* build/cache build/conf build/tmp build/bitbake.lock bitbake build.sh
		rm -rf .git*
		rm -rf .templateconf
	fi

	cd ${cur_dir}
}

bsp_ingredient_update () {
	cur_dir=$(pwd)

	echo "Proceed to update ingredients ..."

	cd ..

	cp -rf ${cur_dir}/* yocto_build
	cp -rf ${cur_dir}/.gitignore yocto_build/.
	cp -rf ${cur_dir}/.templateconf yocto_build/.

	cd yocto_build
	rm -rf .git

	# We don't want this to be installed in the yocto_build directory.
	rm setup.sh

	cd ${cur_dir}
}

rebuild_message () {
	cur_dir=$(pwd)

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
	echo "To build a common RT image [without dev tools],				"
	echo "$ bitbake ${IMG_BASE}							"
	echo -e "									"
	echo "To build a Full RT image [with dev tools, build-essentials, etc],	"
	echo "$ bitbake ${IMG_BASE}-sdk						"
	echo -e "									"
	echo "To compile kernel bzImage only,						"
	echo "$ bitbake linux-intel-rt							"
	echo "=========================================================================="

	cd ${cur_dir}
}

bsp_build () {
	cur_dir=$(pwd)

	cd ../yocto_build/

	if [ "$image" = "custom" ]; then
		echo "Building BSP with custom image ..."
		./build.sh custom
	elif [ "$image" = "rt" ]; then
		echo "Building BSP with ${IMG_BASE} image ..."
		./build.sh rt
	elif [ "$image" = "rt-sdk" ]; then
		echo "Building BSP with ${IMG_BASE}-sdk image ..."
		./build.sh rt-sdk
	elif [ "$image" = "kernel" ]; then
		echo "Building kernel image only ..."
		./build.sh kernel
	else
		echo "Building BSP with ${IMG_BASE}-rt image ..."
		./build.sh rt-sdk
	fi

	cd ${cur_dir}
}

build_bsp_rt () {
	cur_dir=$(pwd)

	prepare_env

	# Start preparing for bitbake build
	bsp_build

	echo "Entering build status checker ..."

	cd ../yocto_build/build/tmp/deploy/images/intel-corei7-64/

	if [ ! -f ${IMG_BASE}*.hddimg ]
	then
		echo "BSP Build: FAILED!!!"
		echo "HDDIMG was not generated!"
		echo "Please check the build log for detailed failure."
		exit 1
	else
		echo "BSP Build: PASSED!!!"
		rebuild_message
	fi

	cd ${cur_dir}
}

build_bsp_rt_sdk () {
	cur_dir=$(pwd)

	prepare_env

	# Start preparing for bitbake build
	bsp_build

	echo "Entering build status checker ..."

	cd ../yocto_build/build/tmp/deploy/images/intel-corei7-64/

	if [ ! -f ${IMG_BASE}-sdk-*.hddimg ]
	then
		echo "BSP Build: FAILED!!!"
		echo "HDDIMG was not generated!"
		echo "Please check the build log for detailed failure."
		exit 1
	else
		echo "BSP Build: PASSED!!!"
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

	cd ../yocto_build/build/tmp/deploy/images/intel-corei7-64/

	if [ ! -f bzImage ]
	then
		echo "Kernel Build: FAILED!!!"
		echo "bzImage was not generated."
		echo "Please check the build log for detailed failure."
		exit 1
	else
		echo "Kernel Build: PASSED!!!"
		rebuild_message
	fi

	cd ${cur_dir}
}

show_help (){
    echo "Usage		: ./setup.sh [option 1] [option 2] [option 3]...
Valid Arguments	:

    OPTIONAL
    --------
    -i <image name>	Image to be 'bitbake'
                        Valid image: ${IMAGE[@]}

    -h			Display information.
"
}

# Get arguments
while getopts "i:h" OPTION
do
    case $OPTION in
        i)
            image_name=$OPTARG
            ;;
        h)
            show_help
            exit
            ;;
        \?)
            echo -e "Unrecognized option(s)!!! Try 'setup.sh -h' for more options"
            exit
            ;;
    esac
done

if [ -z "${image_name}" ]; then
	echo -e "\nSelect an option: \n1. ${IMG_BASE}-sdk (Default)\n2. ${IMG_BASE}\n3. linux-kernel\n4. custom"
	echo -e "Default build target is core-image-rt-sdk. If no input is received within 20 secs, default target will be built."
	read -t 20 -p "" ans
else
	case ${image_name} in
		rt-sdk)
			ans="1";;
		rt)
			ans="2";;
		kernel)
			ans="3";;
		custom)
			ans="4";;
		*)
			ans="1";;
	esac
fi
case $ans in
	1)
		image="rt-sdk"
		build_bsp_rt_sdk
		;;
	2)
		image="rt"
		build_bsp_rt
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
		image="rt-sdk"
		build_bsp_rt_sdk
		;;
esac

exit 0
