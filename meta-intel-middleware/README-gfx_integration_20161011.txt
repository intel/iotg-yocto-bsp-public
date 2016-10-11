ssh://git-ger-6.devtools.intel.com:29418/isg_gms-libdrm
commit beba0fbb2a2e2d4b21c06c9a73572c0465040a06
Author: John Harrison <John.C.Harrison@Intel.com>
Date:   Thu Sep 1 10:34:04 2016 -0700

    drm/i915: Add wrapper for context priority interface
    
    There is an EGL extension to set execution priority per context. This
    can be implemented via the i915 per context priority parameter. This
    patch adds a wrapper to connect the two together in a way that can be
    updated as necessary without breaking one side or the other.
    
    Signed-off-by: John Harrison <John.C.Harrison@Intel.com>
    Signed-off-by: Jeff McGee <jeff.mcgee@intel.com>
    Signed-off-by: Bob Paauwe <bob.j.paauwe@intel.com>

ssh://git-ger-6.devtools.intel.com:29418/isg_gms-mesa
commit 248ba1054004a38853ee3687cf5c4c3bf7a6e300
Author: Stencel, Joanna <joanna.stencel@intel.com>
Date:   Wed Aug 17 12:02:16 2016 +0200

    egl/wayland-egl: Fix for segfault in dri2_wl_destroy_surface.
    
    Segfault occurs when destroying EGL surface attached to already destroyed
    Wayland window. The fix is to set to NULL the pointer of surface's
    native window when wl_egl_destroy_window() is called.
    
    v2: Indentation corrected.
    v3: Redundant nullifying instructions removed.
    
    Signed-off-by: Stencel, Joanna <joanna.stencel@intel.com>
    Reviewed-by: Dongwon Kim <dongwon.kim@intel.com>
    Signed-off-by: Bob Paauwe <bob.j.paauwe@intel.com>

ssh://git-ger-6.devtools.intel.com:29418/isg_gms-libva
commit 30944f6de44dc10ae873b7452238f4e7e569d061
Author: Lim Siew Hoon <siew.hoon.lim@intel.com>
Date:   Mon Sep 5 13:47:07 2016 +0800

    GMS Integration: 2016y-09m-05d-13h-47m-07s +0800

ssh://git-ger-6.devtools.intel.com:29418/isg_gms-intel-va-driver
commit 20e62bebea996a8ebbcfd8f0674660d79d617adc
Author: Lim Siew Hoon <siew.hoon.lim@intel.com>
Date:   Mon Sep 5 13:47:57 2016 +0800

    GMS Integration: 2016y-09m-05d-13h-47m-57s +0800

ssh://git-ger-6.devtools.intel.com:29418/isg_gms-sna_ddx
commit 4d1a48101684362974701906768df345a77518aa
Author: Chris Wilson <chris@chris-wilson.co.uk>
Date:   Fri Sep 2 14:13:31 2016 +0100

    sna: Add missing GT info for bxt,kbl
    
    commit c446a7ccc783e3ca00b4b15d017c6e3af66dc646
    Author: Wayne Boyer <wayne.boyer@intel.com>
    Date:   Wed Nov 18 10:39:42 2015 -0800
    
        Add Kabylake PCI IDs
    
    missed adding the GT information, leaving bxt,kbl using only generic
    acceleration.
    
    Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>

ssh://git-ger-6.devtools.intel.com:29418/isg_gms-gstreamer-vaapi
commit 3467afb464aab6d5a88586c28ac2eab6acd2295f
Author: Víctor Manuel Jáquez Leal <victorx.jaquez@intel.com>
Date:   Sat Oct 8 14:33:59 2016 +0200

    encoder: h264,h265: fix regression in offset count
    
    In commit dc35dafa a bug was introduced because I assumed that
    GST_CLOCK_TIME_NONE is zero when is -1. This patch fixes that mistake.
    
    https://bugzilla.gnome.org/show_bug.cgi?id=772259
