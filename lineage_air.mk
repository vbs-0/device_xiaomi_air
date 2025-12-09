#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from device.mk
$(call inherit-product, $(LOCAL_PATH)/device.mk)

# Inherit from LineageOS common configuration
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Device identifier
PRODUCT_NAME := lineage_air
PRODUCT_DEVICE := air
PRODUCT_BRAND := Redmi
PRODUCT_MODEL := Redmi 13C 5G
PRODUCT_MANUFACTURER := Xiaomi

# Build fingerprint
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="air-user 14 UP1A.231005.007 V816.0.3.0.UMQMIXM release-keys"

BUILD_FINGERPRINT := Redmi/air_global/air:14/UP1A.231005.007/V816.0.3.0.UMQMIXM:user/release-keys

# GMS
PRODUCT_GMS_CLIENTID_BASE := android-xiaomi
