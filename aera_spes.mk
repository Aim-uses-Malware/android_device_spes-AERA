#
#	This file is part of the OrangeFox Recovery Project
# 	Copyright (C) 2024-2026 The OrangeFox Recovery Project
#
#	OrangeFox is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	any later version.
#
#	OrangeFox is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
# 	This software is released under GPL version 3 or any later version.
#	See <http://www.gnu.org/licenses/>.
#
# 	Please maintain this if you use this script or any part of it
#

# Structure follows aera_garnet.mk. SPES values come from the spes OrangeFox
# 12.1 tree (Jashkirat); settings garnet has and SPES does not need are omitted.

AERA_MAINTAINER := yupdrugs

# Screen settings. SPES is 1080x2400 with a punch-hole camera.
AERA_UI2_ADAPTIVE_RESOLUTION := true
AERA_SCREEN_H := 2400
AERA_STATUS_H := 100
AERA_HIDE_NOTCH := 1
AERA_CLOCK_POS := 1
AERA_STATUS_INDENT_LEFT := 48
AERA_STATUS_INDENT_RIGHT := 48
AERA_ALLOW_DISABLE_NAVBAR := 0
AERA_USE_GREEN_LED := 0

# Splash image size (max 130 KB)
AERA_SPLASH_MAX_SIZE := 130

# other stuff
AERA_QUICK_BACKUP_LIST := /boot;/data;
AERA_ENABLE_LPTOOLS := 1
AERA_NO_TREBLE_COMPATIBILITY_CHECK := 1
# Size of the super partition (BOARD_SUPER_PARTITION_SIZE in BoardConfig.mk)
AERA_DYNAMIC_FULL_SIZE := 9126805504

# Not set on purpose: AERA_AB_DEVICE_WITH_RECOVERY_PARTITION. SPES is A/B but
# has no recovery partition (recovery is built into boot).

# MIUI / patching behaviour carried from the 12.1 tree
AERA_USE_MAGISKBOOT_FOR_ALL_PATCHES := 1
AERA_NO_MIUI_PATCH_WARNING := 1
AERA_DONT_PATCH_ENCRYPTED_DEVICE := 1
AERA_ADVANCED_SECURITY := 1

# ----- data format stuff (same defaults as garnet) -----
# ensure that /sdcard is bind-unmounted before f2fs data repair or format
AERA_UNBIND_SDCARD_F2FS := 1

# automatically wipe /metadata after data format
AERA_WIPE_METADATA_AFTER_DATAFORMAT := 1

# avoid MTP issues after data format
AERA_BIND_MOUNT_SDCARD_ON_FORMAT := 1

# Unmount emulated storage cleanly before rebooting or formatting.
AERA_UNMOUNT_SDCARDS_BEFORE_REBOOT := 1

# don't spam the console with loop errors
AERA_LOOP_DEVICE_ERRORS_TO_LOG := 1

# lz4 compression
AERA_USE_LZ4_COMPRESSION := 1

# build all the partition tools
AERA_ENABLE_ALL_PARTITION_TOOLS := 1

# enable the FRP addon
AERA_ENABLE_FRP_WIPE := 1

# dmctl
AERA_USE_DMCTL := 1

# SPES userdata is f2fs. Casefolding is intentionally not forced: garnet's
# userdata is casefolded, SPES shipped on Android 11 and is not known to be.
AERA_FORCE_DATA_FORMAT_F2FS := 1
AERA_DISABLE_ORS_AUTO_REBOOT := 1
AERA_USE_LOCKSCREEN_BUTTON := 1

# Kernel: left at the default (in-tree build from kernel/xiaomi/spes).
# For a prebuilt kernel set AERA_FORCE_PREBUILT_KERNEL := 1 (see BoardConfig.mk).
#AERA_FORCE_PREBUILT_KERNEL := 1

# WLAN is off until the wlan modules for the chosen kernel are in
# AERA_LOAD_VENDOR_MODULES.
#AERA_ENABLE_WLAN := 1
#
