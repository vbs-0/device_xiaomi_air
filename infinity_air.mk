#
# Copyright (C) 2024 The Android Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Set build type BEFORE inheriting ROM config
INFINITY_BUILD_TYPE := UNOFFICIAL

# Inherit Infinity X common configuration
$(call inherit-product, vendor/infinity/config/common_full_phone.mk)

# Inherit from device.mk
$(call inherit-product, $(LOCAL_PATH)/device.mk)

# Inherit from AOSP telephony product
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Device identifier
PRODUCT_NAME := infinity_air
PRODUCT_DEVICE := air
PRODUCT_BRAND := Redmi
PRODUCT_MODEL := Redmi 13C 5G
PRODUCT_MANUFACTURER := Xiaomi

BUILD_FINGERPRINT := Redmi/air_global/air:14/UP1A.231005.007/V816.0.3.0.UMQMIXM:user/release-keys

# GMS
PRODUCT_GMS_CLIENTID_BASE := android-xiaomi
