ssh://git-ger-6.devtools.intel.com:29418/isg_gms-libdrm
commit 07164bc11390edf53b921fc1e11f37763c577418
Author: Matt Roper <matthew.d.roper@intel.com>
Date:   Tue Apr 19 10:52:12 2016 -0700

    GMS Integration: 2016y-04m-19d-10h-52m-12s -0700

ssh://git-ger-6.devtools.intel.com:29418/isg_gms-mesa
commit cfb96acb813f3be212164f2ef2d6bb01b247223d
Author: Matt Roper <matthew.d.roper@intel.com>
Date:   Fri Apr 22 17:38:19 2016 -0700

    GMS Integration: 2016y-04m-22d-17h-38m-19s -0700

ssh://git-ger-6.devtools.intel.com:29418/isg_gms-libva
commit f400fde95021d2604b5c2ed95dd7496fb2a06796
Author: Lim Siew Hoon <siew.hoon.lim@intel.com>
Date:   Fri May 6 09:41:38 2016 +0800

    GMS Integration: 2016y-05m-06d-09h-41m-38s +0800

ssh://git-ger-6.devtools.intel.com:29418/isg_gms-intel-va-driver
commit 2727752d75345d7b71ec3f9917baec695131ec04
Author: Lim Siew Hoon <siew.hoon.lim@intel.com>
Date:   Fri May 6 09:33:09 2016 +0800

    GMS Integration: 2016y-05m-06d-09h-33m-09s +0800

ssh://git-ger-6.devtools.intel.com:29418/isg_gms-sna_ddx
commit 142bfdc3ee73b9272f9a1d3e041eff26a6e58abd
Author: Matt Roper <matthew.d.roper@intel.com>
Date:   Thu Apr 21 10:19:59 2016 -0700

    GMS Integration: 2016y-04m-21d-10h-19m-59s -0700

ssh://git-ger-6.devtools.intel.com:29418/isg_gms-gstreamer-vaapi
commit 43a9d34b1afa606ef51d170f1a606bc097a2d268
Author: Sun Peng <peng.p.sun@intel.com>
Date:   Fri May 6 11:56:54 2016 +0800

    Enable preview of RGB565-32 format on vaapipostproc
    
    RGB565-32 format is special format from iCameraSrc plugin,
    which has a RGB565 data placed in a 32bit contain per pixel.
    Previously use RGBx to identify the format, but always get dim
    color on the preview. This fix will convert RGB565 data to RGB888
    and place them to 32bit container, the real RGBx format.
    Using chroma type GST_VAAPI_CHROMA_TYPE_RGB16_32BPP to identify.
    
    Signed-off-by: Sun Peng <peng.p.sun@intel.com>
