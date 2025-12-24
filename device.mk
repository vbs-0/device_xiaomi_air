#
# Copyright (C) 2024 The Android Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products (CORRECT ORDER for Infinity X)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Overlays (MINIMAL - only device-specific)
DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/overlay

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Fastboot
PRODUCT_PACKAGES += \
    fastbootd

# Init
PRODUCT_PACKAGES += \
    fstab.mt6835

# Ramdisk (GKI mode)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/fstab.mt6835:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/fstab.mt6835 \
    $(LOCAL_PATH)/rootdir/etc/fstab.mt6835:$(TARGET_COPY_OUT_RECOVERY)/root/first_stage_ramdisk/fstab.mt6835

# VINTF
DEVICE_MANIFEST_FILE := $(LOCAL_PATH)/vintf/manifest.xml
DEVICE_MATRIX_FILE := $(LOCAL_PATH)/vintf/compatibility_matrix.xml

# Vendor (MUST BE LAST)
$(call inherit-product, vendor/xiaomi/air/air-vendor.mk)
