# Device Tree for Xiaomi Redmi 13C 5G (air)

Build files for the **Xiaomi Redmi 13C 5G / POCO M6 5G** — codename `air`, MediaTek Dimensity 6100+ (MT6835). Prebuilt kernel, VINTF manifests, 112 init scripts, product overlays and IMS/VoLTE support, set up for an OmniROM-style build.

## Specifications

| Feature | Specification |
|---|---|
| Codename | `air` |
| Model | 23128PC33I |
| Chipset | MediaTek Dimensity 6100+ (MT6835) |
| Architecture | ARM64 (Cortex-A55) |
| Partitioning | A/B with dynamic partitions |
| Boot header | v4 (GKI compliant) |
| Kernel base | `0x40078000`, page size 2048 |

## What is in the tree

| Path | Files | What |
|---|---|---|
| `prebuilt/` | 3 | `Image` (25 MB kernel), `dtbo.img`, `init_boot.img` |
| `rootdir/` | 113 | init scripts |
| `overlay/` | 90 | resource overlays |
| `vintf/` | 2 | manifest and compatibility matrix |
| `proprietary/` | — | populated by the extract scripts |
| `BoardConfig.mk`, `device.mk`, `AndroidProducts.mk` | | the build itself |
| `extract-files.sh`, `extract_blobs.ps1`, `generate_blob_list.ps1` | | blob extraction |

## Dependencies

All three repositories are needed:

```sh
git clone https://github.com/vbs-0/device_xiaomi_air device/xiaomi/air
git clone https://github.com/vbs-0/vendor_xiaomi_air vendor/xiaomi/air
git clone https://github.com/vbs-0/air-kernel          kernel/xiaomi/air   # kernel images, if you need them
```

`device.mk` inherits `vendor/xiaomi/air/air-vendor.mk`, so the vendor tree must be in place before you build.

## Build

```sh
source build/envsetup.sh
lunch omni_air-userdebug          # also: omni_air-user, omni_air-eng
mka bacon
```

The kernel comes from `prebuilt/Image` (`TARGET_PREBUILT_KERNEL` in `BoardConfig.mk`), so no kernel compilation is required. To swap in a different kernel, replace that file — see the `air-kernel` repository for the stock `Image.lz4`, `dtb` and `dtbo`.

## Re-extracting blobs

From a stock ROM dump:

```sh
./extract-files.sh          # Linux/macOS
```

On Windows use `extract_blobs.ps1` (reads `proprietary-files.txt`) and `generate_blob_list.ps1`. The output goes into `proprietary/` and is normally pushed to the `vendor_xiaomi_air` repository.

## Notes

- `BoardConfig.mk` expects the device at `device/xiaomi/air`; the `DEVICE_PATH` variable at the top of the file is the only place that has to change if you use another layout.
- The MediaTek common tree inherit in `device.mk` is commented out (`device/mediatek/mt6835/device.mk`), so the tree does not depend on a separate MTK common repository.
- Keep a copy of the stock boot and dtbo images before flashing anything built here.

## Credits

Created by vbs ND — Telegram [@vbs_1](https://t.me/vbs_1)

## License

```
Copyright (C) 2024 The Android Open Source Project

SPDX-License-Identifier: Apache-2.0
```

The licence covers this tree only; the blobs in `vendor_xiaomi_air` remain Xiaomi/MediaTek proprietary code.
