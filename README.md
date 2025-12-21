# Device Tree for Xiaomi Redmi 13C 5G (air)

## Specifications

| Feature | Specification |
|---------|---------------|
| **Codename** | air |
| **Model** | 23128PC33I |
| **Chipset** | MediaTek Dimensity 6100+ (MT6835) |
| **Architecture** | ARM64 (Cortex-A55) |
| **Partitioning** | A/B with Dynamic Partitions |
| **Boot Header** | v4 (GKI Compliant) |

## Features

- ✅ Prebuilt kernel from stock ROM
- ✅ Complete VINTF manifests
- ✅ 112 init RC scripts
- ✅ Product overlays
- ✅ IMS/VoLTE support

## Build Instructions

```bash
# Clone to your ROM source
git clone https://github.com/YOUR_USERNAME/device_xiaomi_air device/xiaomi/air
git clone https://github.com/YOUR_USERNAME/vendor_xiaomi_air vendor/xiaomi/air

# Setup environment
source build/envsetup.sh
lunch omni_air-userdebug

# Build
mka bacon
```

## Credits

**Created by:** vbs ND  
**Telegram:** [@vbs_1](https://t.me/vbs_1)

## License

```
Copyright (C) 2024 The Android Open Source Project

SPDX-License-Identifier: Apache-2.0
```
