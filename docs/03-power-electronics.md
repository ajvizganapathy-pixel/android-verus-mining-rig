# ⚡ Power Electronics Guide

> XL4015 buck converter setup, 20A PSU wiring, MUR460 diode use, and per-phone power delivery.

---

## Overview

Each group of 4 phones is powered by:

```
[12V 20A PSU] → [XL4015 Buck Converter] → [4× USB-A ports] → [4× Phones]
                      ↑
              Set to 5.0–5.1V output
```

The **WiFi relay** sits between the PSU and the XL4015 input, allowing Alexa to cut power for the discharge cycle.

---

## Components Deep Dive

### 1. XL4015 Buck Converter (DC-DC Step Down)

| Spec | Value |
|------|-------|
| Input voltage | 8–36V |
| Output voltage | 1.25–32V (adjustable) |
| Max output current | **5A continuous** |
| Module part | XL4015 / LM2596 variant |
| Red LED display | Shows voltage output |

**Setting output voltage:**
1. Connect input to 12V (from PSU)
2. Connect multimeter to output terminals
3. Turn **blue trim potentiometer** clockwise = increase voltage
4. Set to exactly **5.05V** (slightly above 5V to compensate for wire drop)
5. Do this **before** connecting any phones

**Why not use a phone charger instead?**
- Chargers are rated for 1–2A per port
- XL4015 gives clean regulated 5A for 4 phones simultaneously
- Better thermal performance and efficiency

---

### 2. MUR460 Fast Recovery Diode

| Spec | Value |
|------|-------|
| Part number | MUR460 |
| Forward voltage drop | ~0.7–1.0V |
| Current rating | 4A |
| Voltage rating | 600V |
| Package | DO-201AD axial |

**Purpose:** When installed between Vbus (5V) and Vbat pad on the motherboard:
- Input: 5V (from XL4015)
- Output (after diode): ~4.0–4.2V → simulates a fully-charged battery
- Android sees "battery present and charging" → boots normally

**Orientation:** Always check the **cathode band** (silver stripe) faces the Vbat pad.

```
Vbus (5V) ──→ [Anode | MUR460 | Cathode] ──→ Vbat (~4.1V)
```

---

### 3. 20A Switching Power Supply

| Spec | Value |
|------|-------|
| Output | 12V DC |
| Current | 20A (240W) |
| Input | 100–240V AC |
| Use | Powers one full tier (12 phones) |

**Wiring:**
- AC input: Live → L, Neutral → N, Earth → GND (follow local wiring codes)
- DC output: V+ (red) → main bus, V- (black) → ground bus
- Add a **20A fuse** on the V+ line as protection

> ⚠️ **Safety:** Use proper wire gauge for 20A. Minimum 12AWG for main runs. Poor wiring = fire risk.

---

### 4. NE555 Delay Monostable Module

| Spec | Value |
|------|-------|
| Supply | 12V |
| Function | Single pulse on power-on |
| Delay range | ~0.1s – 60s (adjust trim pot) |
| Output | Momentary HIGH pulse |

**Purpose:** Triggers the phone's **power button pad** automatically when power is applied.

**Wiring:**
```
12V PSU → [NE555 Module VCC]
GND     → [NE555 Module GND]
NE555 OUT → Phone board PWR_KEY pad
```

**Setting the delay:**
- Trim pot **clockwise** = longer delay
- Set to approximately **1–2 seconds** delay
- This gives the board time to stabilize before the power pulse fires

---

## Full Per-Tier Wiring Diagram

```
                         ┌─────────────────────────────────────────┐
                         │           TIER POWER PANEL (MDF)         │
                         │                                           │
[240V AC]                │  ┌─────────┐    ┌──────────────────────┐ │
    │                    │  │ 20A PSU │    │  WiFi Relay ×4        │ │
    └──→[MAIN SWITCH]──→│  │  12V    │──→│  (ESP8266-based)      │ │
                         │  └─────────┘    └──────┬───────────────┘ │
                         │                         │ (relay output)   │
                         │              ┌──────────▼──────────────┐  │
                         │              │   XL4015 ×3 (5V/5A ea) │  │
                         │              └──┬────┬────┬────────────┘  │
                         │                 │    │    │               │
                         │              USB USB USB USB              │
                         │               P1  P2  P3  P4             │
                         │                                           │
                         │  [NE555 ×per board] → PWR_KEY of boards  │
                         │  [2× 12V Fans]      → Cooling            │
                         └─────────────────────────────────────────┘
```

---

## Charging Voltage Summary

| Phone Type | Delivery Method | Voltage at Phone |
|------------|----------------|-----------------|
| Intact phone (normal) | USB-A → USB cable | 5.0–5.1V |
| Bare board + USB mod | USB-A → board Vbus pad | 5.0V |
| Bare board Vbat line | Via MUR460 diode | ~4.0–4.2V |

---

## Tips & Warnings

- Always **set XL4015 output voltage FIRST** before connecting phones
- Use a **USB power meter** (UM25C or similar) to verify actual voltage under load
- If a phone gets **hot on the back** → check diode and verify Vbat isn't above 4.3V
- Never exceed **5.5V** on Vbus — USB controller on phone board will be damaged
- **Fuse each group of 4 phones** separately — a shorted board won't take down the whole tier

---

## Parts Sourcing (India)

| Part | Where to buy |
|------|-------------|
| XL4015 / LM2596 module | Robu.in, Amazon India, local electronics market |
| MUR460 diode | Robu.in, ElectronicsComp, local component shop |
| NE555 delay module | Amazon India (SKU 43972 as reference), Robu.in |
| 20A PSU | Amazon India, IndiaMART |
| WiFi relay (ESP8266) | Robu.in, Amazon India |

---

*Next: [Relay & Alexa Control](04-relay-alexa-control.md)*
