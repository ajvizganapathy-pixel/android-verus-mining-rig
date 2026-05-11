# 📱⛏️ Android Verus Coin Mining Rig

> **A complete DIY guide to building a multi-phone Android mining rig for Verus Coin (VRSC) using recycled smartphones, custom power electronics, ESP8266 relay control, and Alexa automation.**

**By [ANJAN GANAPATHY K](https://github.com/ajvizganapathy-pixel)** | Builder: AI + Software + Embedded Hardware  
📧 ajvizganapathy@gmail.com | 🇮🇳 India

---

## 🚀 Project Overview

This project documents 3+ years of running a **36-phone Android mining rig** mining **Verus Coin (VRSC)** using Termux + ccminer on recycled Android smartphones. The rig features:

- ✅ 36 Android phones on a 3-tier metal rack
- ✅ Custom power electronics (XL4015 buck converters, MUR460 diodes)
- ✅ ESP8266 WiFi relay modules controlled via Alexa + IFTTT
- ✅ Automated charge/discharge cycling (4.5h charge / 1.5h discharge)
- ✅ Phone motherboards modded with USB-A power input
- ✅ NE555 timer module for auto power-on trigger
- ✅ Auto-start mining on boot (no screen touch needed)

---

## 📁 Repository Structure

```
android-verus-mining-rig/
│
├── README.md                        ← You are here
│
├── docs/
│   ├── 01-hardware-overview.md      ← Full rig hardware list & rack setup
│   ├── 02-motherboard-mod.md        ← Phone board USB mod + wiring guide
│   ├── 03-power-electronics.md      ← XL4015, MUR460, 20A PSU wiring
│   ├── 04-relay-alexa-control.md    ← ESP8266 relay + Alexa + IFTTT setup
│   ├── 05-termux-mining-setup.md    ← ccminer install & config in Termux
│   ├── 06-autostart-config.md       ← Auto-boot mining setup (apps + dev settings)
│   ├── 07-supported-phones.md       ← Tested phone models with notes
│   └── 08-troubleshooting.md        ← Common issues & fixes
│
├── scripts/
│   ├── install.sh                   ← One-shot Termux install script
│   ├── config.json                  ← ccminer pool config (edit wallet!)
│   ├── start.sh                     ← Mining start script
│   └── bashrc_autostart.sh          ← Auto-start snippet for bash.bashrc
│
├── apks/
│   ├── ScreenAwake_1.2.0.apk        ← Keeps screen on (required)
│   ├── AutoStartManager_5.1.apk     ← Auto-launches Termux on boot
│   └── README.md                    ← APK install instructions
│
└── images/                          ← Reference photos from the build
    └── (see docs for image refs)
```

---

## ⚡ Quick Start (Software Only)

If you just want to mine on a **single Android phone** without any hardware mod:

1. Install [Termux from F-Droid](https://f-droid.org/en/packages/com.termux/) *(not Play Store)*
2. Install APKs from the `/apks` folder
3. Copy `scripts/config.json` and edit your wallet address
4. Run `scripts/install.sh` inside Termux
5. Start mining: `~/ccminer/start.sh`

👉 Full software guide: [docs/05-termux-mining-setup.md](docs/05-termux-mining-setup.md)

---

## 🔧 Full Rig Build

For the complete 36-phone rack build with power electronics and Alexa control, follow the docs in order:

| Step | Document | Description |
|------|----------|-------------|
| 1 | [Hardware Overview](docs/01-hardware-overview.md) | Parts list, rack, PSU |
| 2 | [Motherboard Mod](docs/02-motherboard-mod.md) | USB-A mod for bare boards |
| 3 | [Power Electronics](docs/03-power-electronics.md) | XL4015, MUR460, wiring |
| 4 | [Relay & Alexa](docs/04-relay-alexa-control.md) | Auto charge cycling |
| 5 | [Termux Setup](docs/05-termux-mining-setup.md) | Software install |
| 6 | [Auto-Start](docs/06-autostart-config.md) | Boot-to-mine config |
| 7 | [Supported Phones](docs/07-supported-phones.md) | Compatible models |
| 8 | [Troubleshooting](docs/08-troubleshooting.md) | Fixes & tips |

---

## 💰 Mining Details

| Parameter | Value |
|-----------|-------|
| Coin | Verus Coin (VRSC) |
| Algorithm | VerusHash 2.1 |
| Miner | ccminer (Darktron fork) |
| Pool | [vipor.net](https://vipor.net) |
| Stratum | `sg.vipor.net:5040` |
| Wallet App | Verus Mobile (Play Store) |

> ⚠️ **Wallet Note:** The wallet address in `config.json` (`RDxVQALK7PudTe5SnQRNevqFtAfD3QstWd`) is an **example only**. Replace it with your own Verus wallet address from the Verus Mobile app.

---

## 📸 Build Photos

| Image | Description |
|-------|-------------|
| Motherboard USB mod | Phone PCB with USB-A soldered + red/black/green/white wires |
| Full rack (36 phones) | 3-tier metal shelf with power modules on side |
| Power board | XL4015 + relay modules on MDF platform |
| Bare board node | Individual board mounted vertically on MDF |

---

## ⚠️ Disclaimer

- This project is for **educational and personal use** only.
- Always comply with your local electricity and financial regulations.
- Mining profitability varies. Do your own research.
- The author is not responsible for any hardware damage.

---

## 📜 License

MIT License — Free to use, modify, and share with attribution.

---

*"Building real-world systems, one step at a time." — Anjan Ganapathy K*
