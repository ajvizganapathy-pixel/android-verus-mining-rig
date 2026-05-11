# 📱 Supported Phone Models

> All Android phones confirmed working in this mining rig build. No additional research needed for these models.

---

## ✅ Confirmed Working — Full Phone (with screen/battery)

These phones run mining with Termux + ccminer using standard USB charging. No hardware mod needed.

### Vivo Models

| Model Number | Commercial Name | SoC | RAM | Notes |
|-------------|----------------|-----|-----|-------|
| Vivo 1716 | Vivo Y71 | Snapdragon 425 | 3GB | Works well, disable battery saver |
| Vivo 1726 | Vivo Y83 | Helio P22 | 4GB | Good performance |
| Vivo 1814 | Vivo V9 Youth | Snapdragon 450 | 4GB | Stable, good thermals |
| Vivo 1816 | Vivo Y81 | Helio P22 | 3GB | Works well |
| Vivo 1820 | Vivo Y83 Pro | Helio P22 | 4GB | Confirmed ×2 units |
| Vivo 1803 | Vivo Y85 | Helio P23 | 4GB | May need extra autostart config |
| Vivo 1901 | Vivo Y91 | Helio P22 | 2GB | Lower RAM — use 4 threads |
| Vivo 1904 | Vivo Y91i | Helio P22 | 2GB | Lower RAM — use 4 threads |
| Vivo 1907 | Vivo Y15 | Helio P22 | 3GB | Works well |
| Vivo 1718 | Vivo Y81i | MediaTek MT6762 | 2GB | Use 4 threads max |
| Vivo 1929 | Vivo Y19 | Helio P65 | 6GB | Best performer in Vivo lineup |
| Vivo Y17S | Vivo Y17s | Helio G85 | 4GB | Latest model, good hashrate |

### Xiaomi / Redmi Models

| Model | Commercial Name | SoC | RAM | Notes |
|-------|----------------|-----|-----|-------|
| Redmi Y3 | Redmi Y3 | Snapdragon 632 | 3GB | Excellent hashrate |
| Redmi 13C | Redmi 13C | Helio G85 | 4–6GB | Very good, modern chipset |
| Redmi 7 | Redmi 7 | Snapdragon 632 | 2–3GB | Good, 2GB version use 4 threads |
| Redmi 6A | Redmi 6A | Helio A22 | 2GB | Lower hashrate, use 4 threads |
| Redmi 6 Pro | Redmi 6 Pro | Snapdragon 625 | 3–4GB | Excellent — SD625 is efficient |

### Samsung Models

| Model | Commercial Name | SoC | RAM | Notes |
|-------|----------------|-----|-----|-------|
| SM-G965F | Galaxy S9+ | Exynos 9810 | 6GB | Highest hashrate in build! |
| SM-A305F | Galaxy A30 | Exynos 7904 | 3–4GB | Good performer |
| SM-M315F | Galaxy M31 | Exynos 9611 | 6GB | Excellent — 8 threads capable |

### Nokia Models

| Model | Commercial Name | SoC | RAM | Notes |
|-------|----------------|-----|-----|-------|
| Nokia 3.14 (TA-series) | Nokia 3.1 Plus | Helio P22 | 2–3GB | Works, use 4–6 threads |

### Huawei Models

| Model | Commercial Name | SoC | RAM | Notes |
|-------|----------------|-----|-----|-------|
| Huawei Y7 Prime 2019 | Huawei Y7 Prime | Kirin 659 | 3GB | Works — EMUI needs extra config |

---

## ✅ Confirmed Working — Bare Motherboard (with USB mod)

These board models have been successfully modded with the USB-A power mod from [doc 02](02-motherboard-mod.md).

| Phone Model | Board Label | Mod Notes |
|------------|-------------|-----------|
| Various Vivo 18xx | Multiple | Standard Vbus/Vbat/GND pads accessible |
| Xiaomi/Redmi boards | Multiple | Test points labeled on board |

> See Image 7, 8 in the repo photos for example modded boards.

---

## Thread Count Recommendations

| RAM | Recommended Threads |
|-----|-------------------|
| 2GB | 4 threads |
| 3GB | 5–6 threads |
| 4GB | 6 threads |
| 6GB+ | 6–8 threads |

> More threads = more heat. Monitor temperature with a thermal camera or check with `cat /sys/class/thermal/thermal_zone*/temp`

---

## Phones to Avoid

| Type | Reason |
|------|--------|
| Phones with locked bootloader + aggressive battery management | Hard to keep Termux alive |
| iPhones | iOS does not support Termux |
| Very old Android (<6.0) | Package compatibility issues |
| Phones with <1GB RAM | Termux + ccminer won't fit in memory |

---

## Adding a New Phone Model

If you test a phone not on this list:
1. Check if Termux installs correctly
2. Run `uname -m` in Termux — must show `aarch64` or `armv7l`
3. Try building ccminer — if it compiles, it will mine
4. Report your hashrate and open a GitHub Issue or PR to add it here!

---

*Next: [Troubleshooting](08-troubleshooting.md)*
