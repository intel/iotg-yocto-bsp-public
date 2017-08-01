SUMMARY = "All packages for full graphics user space"
LICENSE = "MIT"
PR = "r1"

PACKAGE_ARCH = "${MACHINE_ARCH}"
inherit packagegroup

PACKAGES = "packagegroup-core-graphics-essential"

ALLOW_EMPTY_${PN} = "1"

RDEPENDS_packagegroup-core-graphics-essential = "\
    cairo \
    dmidecode \
    flac \
    fontconfig \
    freetype \
    \
    glew \
    glog \
    gstreamer1.0 \
    gstreamer1.0-libav \
    gstreamer1.0-omx \
    gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-plugins-ugly \
    gstreamer1.0-rtsp-server \
    gstreamer-vaapi-1.0 \
    gtk+3 \
    \
    jpeg \
    \
    lame \
    ldd \
    libav \
    libdrm \
    libglu \
    libmad \
    libogg \
    libpng \
    libpng12 \
    libsoup-2.4 \
    libtheora \
    libvorbis \
    libpciaccess \
    libvpx \
    libx11 \
    libxaw7 \
    libxcb \
    libxcomposite \
    libxcursor \
    libxdamage \
    libxext \
    libxft \
    libxfont \
    libxfixes \
    libxi \
    libxinerama \
    libxkbcommon \
    libxkbfile \
    libxpm \
    libxrandr \
    libxrender \
    libxscrnsaver \
    libxshmfence \
    libxslt \
    libxt \
    libxtst \
    libxv \
    libxvmc \
    libxxf86dga \
    libxxf86misc \
    libxxf86vm \
    \
    mesa \
    mpeg2dec \
    numactl \
    \
    pango \
    speex \
    v4l-utils \
    wayland \
    weston \
    x264 \
    x11perf \
    xcb-util \
    xrandr \
    xrdb \
    xserver-xf86-config \
    xserver-xorg \
    xwit \
"
