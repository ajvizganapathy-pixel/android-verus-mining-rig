# 🔧 Hardware Overview

> Complete parts list and physical setup for the 36-phone Verus mining rig.

---

## 🗂️ Table of Contents
- [Rack Structure](#rack-structure)
- [Per-Rack Power Setup](#per-rack-power-setup)
- [Full Parts List](#full-parts-list)
- [Tools Required](#tools-required)
- [Layout Diagram](#layout-diagram)

---

## Rack Structure

The rig uses a **standard 3-tier metal wire shelf rack** (commonly used for storage).

| Tier | Phones | Power Supply | Notes |
|------|--------|-------------|-------|
| Top | 12 phones | 1× 20A PSU | WiFi relay panel on right side |
| Middle | 12 phones | 1× 20A PSU | WiFi relay panel on right side |
| Bottom | 12 phones | 1× 20A PSU | WiFi relay panel on right side |

- Each tier is **independent** — its own PSU, its own relay panel
- Total: **36 phones**, 3 PSUs, 3 relay panels

---

## Per-Rack Power Setup

Each tier has:

```
[20A 12V PSU]
     │
     ├──→ [XL4015 Buck Converter] → 5V/5A → [4× Phones via USB]
     │         (set to 5.1V output)
     │
     ├──→ [WiFi Relay Module ×4] → Controls charging per phone group
     │
     └──→ [Cooling Fans ×2] → 12V case fans for airflow
```

- **4 phones share one XL4015 module** (rated for 5A continuous)
- **WiFi relay** cuts power to XL4015 during discharge cycle
- **Alexa routine** triggers relay ON/OFF on schedule

---

## Full Parts List

### Power Electronics

| Component | Qty | Spec | Purpose |
|-----------|-----|------|---------|
| Switching Power Supply | 3 | 12V 20A (240W) | Main power per tier |
| XL4015 Buck Converter | 9 | 5A adjustable | Step down 12V → 5.1V per 4 phones |
| MUR460 Diode | 36+ | 4A 600V fast recovery | Mimics battery presence on bare boards |
| WiFi Relay Module | 12 | ESP8266-based, 1-channel | Charge control via Alexa |
| NE555 Delay Module | As needed | 12V monostable | Auto power-on trigger for boards |
| Cooling Fan | 6 | 12V 80mm/120mm case fan | Airflow per tier |

### Phone Hardware

| Component | Qty | Notes |
|-----------|-----|-------|
| Android Smartphones | 36 | See [supported phones](07-supported-phones.md) |
| Phone Stands / Holders | 36 | White plastic desk holders (3D print or buy) |
| USB-A Male Connector | 36 | For motherboard power mod |
| Small Heatsink | 36 | Glued to SoC area of bare boards |

### Cabling & Connectors

| Item | Notes |
|------|-------|
| Red/Black wire (18AWG) | Main power runs |
| Green/White wire (26AWG) | USB D+/D- lines |
| USB terminal blocks | Mounting USB ports to MDF base |
| Screw terminals | For all relay/buck converter connections |
| Heat shrink tubing | Wire insulation |

### Structure & Mounting

| Item | Notes |
|------|-------|
| 3-tier metal wire shelf | ~120×40×150cm |
| MDF board (per tier side panel) | Relay + buck converter mounting |
| MDF base board (per node) | Individual phone board mounting |
| M3 standoffs + screws | Board mounting |
| Cable ties | Wire management |

---

## Tools Required

- Soldering iron (fine tip, 350°C+)
- Hot glue gun
- Multimeter
- Wire stripper / cutter
- Screwdriver set
- Tweezers (for SMD work)
- USB power meter (for verifying output)
- Heat gun (for heat shrink)

---

## Layout Diagram

```
TOP VIEW OF ONE TIER:
┌─────────────────────────────────────────┐
│  [P1] [P2] [P3] [P4]  [P5] [P6] [P7] [P8]  [P9] [P10] [P11] [P12] │
│   └──XL4015──┘          └──XL4015──┘          └────XL4015────┘     │
│                                                                      │
│  [RELAY×4]  [RELAY×4]  [RELAY×4]  ← mounted on side MDF panel      │
│  [20A PSU]              [2× FANS]                                    │
└─────────────────────────────────────────────────────────────────────┘

SIDE VIEW (3 TIERS):
┌─────────────────────┐
│  TOP    [12 phones] │ ← [PSU+Relays]
├─────────────────────┤
│  MID    [12 phones] │ ← [PSU+Relays]
├─────────────────────┤
│  BOT    [12 phones] │ ← [PSU+Relays]
└─────────────────────┘
```

---

## Notes

- Keep **fans blowing across** the phone row, not just upward
- **XL4015 output voltage**: Set to exactly **5.0–5.1V** before connecting phones
- Always verify output with a **USB power meter** before plugging phones
- For **bare board nodes**: output can be slightly higher (4.2V to Vbat directly via MUR460)

---

*Next: [Motherboard Mod](02-motherboard-mod.md)*
