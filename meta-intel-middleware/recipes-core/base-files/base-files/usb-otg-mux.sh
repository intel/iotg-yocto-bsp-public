#!/bin/sh

if [ -e /sys/bus/platform/devices/intel-mux-drcfg/portmux.0/state ]; then
    echo host > /sys/bus/platform/devices/intel-mux-drcfg/portmux.0/state
fi
