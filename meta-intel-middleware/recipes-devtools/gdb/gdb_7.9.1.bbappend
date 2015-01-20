# Enable gdb TUI mode for UFO debugging
EXTRA_OECONF_remove = "--disable-tui"

EXTRA_OECONF += " --enable-tui"
