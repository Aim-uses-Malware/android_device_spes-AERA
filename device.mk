#
# Copyright (C) 2021 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#
#	Parts of this file follow the garnet tree
#	(OrangeFox Recovery Project, GPL v3 or any later version)
#

# include (not inherit-product) the common settings - works better with device-specific files
-include $(COMMON_PATH)/device-common.mk

# Settings garnet gets from sm84xx-common/device-common.mk. SPES has no common
# tree, so the ones that apply to bengal are set here directly.
QCOM_BOARD_PLATFORMS += $(PRODUCT_PLATFORM)
RELAX_USES_LIBRARY_CHECK := true

AERA_DEFAULT_LANGUAGE     := en
AERA_USE_TOOLBOX          := true
AERA_INCLUDE_NTFS_3G      := true
AERA_INCLUDE_REPACKTOOLS  := true
AERA_INCLUDE_RESETPROP    := true
AERA_INCLUDE_LIBRESETPROP := true
AERA_EXTRA_LANGUAGES      := true
AERA_EXCLUDE_APEX         := true
AERA_INCLUDE_FASTBOOTD    := true
AERA_EXCLUDE_DEFAULT_USB_INIT := true
AERA_INCLUDE_LOGCAT       := true

# OEM otacert
PRODUCT_EXTRA_RECOVERY_KEYS += \
    vendor/recovery/security/miui

# Enable updating of APEXes
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# Enable virtual A/B OTA
# TODO(verify): garnet uses virtual_ab_ota/launch_with_vendor_ramdisk.mk. SPES
# shipped on Android 11, so this keeps the plain include the 12.1 tree used.
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)

# Installs gsi keys into ramdisk, to boot a developer GSI with verified boot.
$(call inherit-product, $(SRC_TARGET_DIR)/product/developer_gsi_keys.mk)

# Enable project quotas and casefolding for emulated storage without sdcardfs
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# API
# PRODUCT_TARGET_VNDK_VERSION := 30 was set in the 12.1 tree. VNDK handling
# changed in newer branches, so it is left out; re-add if the build asks for it.
PRODUCT_SHIPPING_API_LEVEL := 30

# Boot animation
TARGET_SCREEN_HEIGHT := 2400
TARGET_SCREEN_WIDTH := 1080

# Boot control
PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-impl-qti \
    android.hardware.boot@1.2-impl-qti.recovery \
    android.hardware.boot@1.2-service

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_BUILD_SUPER_PARTITION := false
ENABLE_VIRTUAL_AB := true

# f2fs utilities
PRODUCT_PACKAGES += \
    sg_write_buffer \
    f2fs_io \
    check_f2fs

# Fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.1-impl-mock \
    fastbootd

# FUSE passthrough
PRODUCT_SYSTEM_PROPERTIES += \
    persist.sys.fuse.passthrough.enable=true

# Init scripts
# init.recovery.qcom.rc is installed by the recovery/root copy below. There are
# no "init.recovery.qcom.sh" / "init.recovery.qcom.rc" modules in the AERA
# sources (garnet does not list them either), so naming them in PRODUCT_PACKAGES
# only produced missing-module errors.

# Update engine
PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier

PRODUCT_PACKAGES_DEBUG += \
    update_engine_client

# Decryption (FBE with wrapped keys + metadata encryption, see recovery.fstab)
PRODUCT_PACKAGES += \
    qcom_decrypt \
    qcom_decrypt_fbe

AERA_INCLUDE_CRYPTO := true
AERA_INCLUDE_CRYPTO_FBE := true
AERA_INCLUDE_FBE_METADATA_DECRYPT := true
BOARD_USES_QCOM_FBE_DECRYPTION := true

# The PLATFORM_VERSION / security-patch overrides live in BoardConfig.mk (same
# place as garnet's BoardConfigCommon.mk).

ALLOW_MISSING_DEPENDENCIES := true

# clear this, so that the device-specific recovery/root/ folder is included automatically by the build system
# requires including, rather than inheriting the common settings
TARGET_RECOVERY_DEVICE_DIRS :=

# copy recovery/root/ from the device directory
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(DEVICE_PATH)/recovery/root/,$(TARGET_COPY_OUT_RECOVERY)/root/)

# AERA-specific settings
$(call inherit-product, $(DEVICE_PATH)/aera_spes.mk)

# Optional AERA extras that garnet enables. Left out until the base boots.
# TODO(audio): aera-audio-bridge needs SPES audio files (garnet has an audio/ dir).
#PRODUCT_PACKAGES += \
#    aera-audio-bridge \
#    aera-browser-jail

# Soong namespaces
# TODO(deps): hardware/qcom-caf/bootctrl and
# vendor/qcom/opensource/commonsys-intf/display must exist in the synced
# source tree (check with ls). If not, add them to your local manifest.
PRODUCT_SOONG_NAMESPACES += \
    $(DEVICE_PATH) \
    hardware/qcom-caf/bootctrl \
    vendor/qcom/opensource/commonsys-intf/display
#
