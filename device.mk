#
# Copyright (C) 2024 The Android Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from generic mtk
# $(call inherit-product, device/mediatek/mt6835/device.mk)

# Setup custom variables
PRODUCT_DEVICE := air
PRODUCT_NAME := omni_air
PRODUCT_BRAND := Xiaomi
PRODUCT_MODEL := 23128PC33I
PRODUCT_MANUFACTURER := Xiaomi

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

# Shipping API level
PRODUCT_SHIPPING_API_LEVEL := 33

# Fastboot
PRODUCT_PACKAGES += \
    fastbootd

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/overlay

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Init
PRODUCT_PACKAGES += \
    fstab.mt6835 \
    init.mt6835.rc \
    init.mt6835.usb.rc

# Copy fstab
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/fstab.mt6835:$(TARGET_COPY_OUT_RAMDISK)/fstab.mt6835

# VINTF Manifests
DEVICE_MANIFEST_FILE := $(LOCAL_PATH)/vintf/manifest.xml
DEVICE_MATRIX_FILE := $(LOCAL_PATH)/vintf/compatibility_matrix.xml

# Init RC Files (disabled - conflicts with ROM's Soong HAL modules)
# PRODUCT_COPY_FILES += \
#     $(call find-copy-subdir-files,*,$(LOCAL_PATH)/rootdir/etc/init,$(TARGET_COPY_OUT_VENDOR)/etc/init)

# Call the proprietary setup
$(call inherit-product, vendor/xiaomi/air/air-vendor.mk)
