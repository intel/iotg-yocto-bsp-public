#!/bin/sh

if test -z "$XDG_RUNTIME_DIR"; then
	export XDG_RUNTIME_DIR=/run/$USER/temp
	mkdir --parents $XDG_RUNTIME_DIR
	chmod 0700 $XDG_RUNTIME_DIR
fi
