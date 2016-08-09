ssh://git-ger-6.devtools.intel.com:29418/isg_gms-libdrm
commit 1f081919c22b143172b87fe53a5689028d75d8b0
Author: Jon Bloomfield <jon.bloomfield@intel.com>
Date:   Mon Jun 27 13:33:15 2016 -0700

    i915: Support for bo userdata
    
    Provide a machanism for attaching and maintaining user private
    meta-data to i915 bo's.
    
    Three functions are exported:
    
    	int drm_intel_bo_create_userdata_blk(drm_intel_bo *bo,
    					     uint16_t     flags,
    					     uint32_t     bytes,
    					     const void   *data,
    					     uint32_t     *avail_bytes);
    		Allocate data block of size 'bytes', and attach to 'bo
    		If 'data' is NULL, the block is zeroed
    		If 'data' is not NULL, the block is initialized from it
    		'flags' controls how the data can be used
    		The original size of the userdata block is return in
    		avail_bytes.
    
    	int drm_intel_bo_set_userdata_blk(drm_intel_bo *bo,
    					  uint32_t     offset,
    					  uint32_t     bytes,
    					  const void   *data,
    					  uint32_t     *avail_bytes);
    		Copy 'bytes' of data from 'data', to the block already attached
    		to 'bo', starting at byte 'offset' of the target block.
    		The size of the allocated userdata block is return in
    		avail_bytes
    
    	int drm_intel_bo_get_userdata_blk(drm_intel_bo *bo,
    					  uint32_t     offset,
    					  uint32_t     bytes,
            	                          void          *data,
    					  uint32_t     *avail_bytes);
    		Extract 'bytes' of data from the block already attached to 'bo',
    		starting from byte 'offset' of the source block.
    		The size of the allocated userdata block is return in
    		avail_bytes
    
    Issue: GMINL-5533
    Signed-off-by: Jon Bloomfield<jon.bloomfield@intel.com>
    Reviewed-on: https://android.intel.com/320458
    Reviewed-by: Barbalho, Rafael <rafael.barbalho@intel.com>
    Tested-by: Lee, Chang-joon <chang-joon.lee@intel.com>
    Signed-off-by: Jeff McGee <jeff.mcgee@intel.com>
    Signed-off-by: Matt Roper <matthew.d.roper@intel.com>

ssh://git-ger-6.devtools.intel.com:29418/isg_gms-mesa
commit f10191b01c64345b7d813d8c0f355267d06bbe21
Author: Plamena Manolova <plamena.manolova@intel.com>
Date:   Thu May 12 18:21:38 2016 +0100

    egl: Add OpenGL_ES to API string regardless of GLES version
    
    According to the EGL specifications eglQueryString(EGL_CLIENT_APIS)
    should return a string containing a combination of "OpenGL", "OpenGL_ES"
    and "OpenVG", any other values would be considered invalid. Due to this
    when the API string is constructed, the version of GLES should be
    disregarded and "OpenGL_ES" should be attached once instead of
    "OpenGL_ES2" and "OpenGL_ES3".
    
    Fixes:
    dEQP-EGL.functional.negative_api* and
    dEQP-EGL.functional.query_context.simple.query_api
    
    Signed-off-by: Plamena Manolova <plamena.manolova@intel.com>
    Reviewed-by: Matt Turner <mattst88@gmail.com>
    Reviewed-by: Ben Widawsky <ben@bwidawsk.net>
    (cherry picked from commit 21edd24c0de903a12a92e969b78d3a928b9ed50c)
    Signed-off-by: Matt Roper <matthew.d.roper@intel.com>

ssh://git-ger-6.devtools.intel.com:29418/isg_gms-libva
commit e6c3e2bd3dde978d506ff1ab5773c1462f3313bc
Author: Tobias Stoeckmann <tobias@stoeckmann.org>
Date:   Sat Jun 25 20:08:31 2016 +0200

    Properly terminate parsed environment values with '\0'.
    
    The function strncpy() does not guarantee to nul terminate the
    destination. In most cases, this cannot be triggered, but it is also
    used to parse user environment variables. These are allowed to be longer
    than 1023 characters, effectively resulting in an unterminated string.
    
    I've adjusted other places as well, because it won't hurt.
    
    https://bugs.freedesktop.org/show_bug.cgi?id=96677

ssh://git-ger-6.devtools.intel.com:29418/isg_gms-intel-va-driver
commit fcae5333b8b46bbf7372ef0ce604de01fd3c9cf6
Author: Xiang, Haihao <haihao.xiang@intel.com>
Date:   Mon Jul 25 16:53:08 2016 +0800

    Encode: Set cost for MODE_CHROMA_INTRA/MODE_REFID_COST
    
    This fixes the remaining issues mentioned in https://bugs.freedesktop.org/show_bug.cgi?id=96703
    after applying commit 3699c14
    
    On GEN75+, driver copies vme_context->vme_state_message to VME kernel curbe buffer and
    VME kernel uses the data in curbe buffer to initialize VME message payload.
    vme_context->vme_state_message is set up in intel_vme_update_mbmv_cost(), which doesn't
    set all costs for used modes in VME kernels. The uninitialized mode cost will result in
    difference in VME output. Thanks for Elaine's finding that the issue disappears after
    initializing VME state message buffer with zeros.
    
    Signed-off-by: Elaine Wang <elaine.wang@intel.com>
    Signed-off-by: Xiang, Haihao <haihao.xiang@intel.com>
    Reviewed-by: Sean V Kelley <seanvk@posteo.de>
    Tested-by: Mingruo Sun <mingruo.sun@intel.com>

ssh://git-ger-6.devtools.intel.com:29418/isg_gms-sna_ddx
commit 142bfdc3ee73b9272f9a1d3e041eff26a6e58abd
Author: Matt Roper <matthew.d.roper@intel.com>
Date:   Thu Apr 21 10:19:59 2016 -0700

    GMS Integration: 2016y-04m-21d-10h-19m-59s -0700

ssh://git-ger-6.devtools.intel.com:29418/isg_gms-gstreamer-vaapi
commit 879eb9b52a7f7309c20aac4f1ada51a815483bbf
Author: Lim Siew Hoon <siew.hoon.lim@intel.com>
Date:   Wed Jul 27 16:38:39 2016 +0800

    GMS Integration: 2016y-07m-27d-16h-38m-39s +0800
