# 🔌 Phone Motherboard Modification Guide

> How to power a bare Android phone motherboard using a USB-A connector, with MUR460 diode to mimic battery presence.

---

## ⚠️ Warning

This mod involves working on **live PCB traces** and soldering directly to motherboard pads.  
- Work with power **OFF** always when soldering  
- Use a **fine-tip soldering iron at 320–350°C**  
- One wrong solder bridge can permanently damage the board  
- Recommended for people with **basic soldering experience**

---

## 🧠 Why This Mod?

When a phone motherboard is removed from its shell:
- The original USB Type-C / Micro-USB port is often broken or inaccessible
- The battery connector is missing
- Android will **refuse to boot** without a battery present

**Solution:**
1. Solder a **USB-A male connector** directly to the board's power/data pads
2. Use a **MUR460 fast-recovery diode** to mimic a battery's presence on the Vbat line
3. Use a **4.7kΩ resistor** on D+ line (some boards need this to detect charger)
4. Trigger power-on via the **PWM/power-button pad** using a **NE555 timer module**

---

## 📌 Required Connections

| USB-A Pin | Wire Color | Board Point | Notes |
|-----------|-----------|-------------|-------|
| Pin 1 (VCC) | Red | Vbus pad | 5V supply input |
| Pin 4 (GND) | Black | GND pad | Ground |
| Pin 2 (D-) | White | D- pad | USB data minus |
| Pin 3 (D+) | Green | D+ pad (via 4.7kΩ) | USB data plus |

### Additional Connections

| Component | Connection | Purpose |
|-----------|-----------|---------|
| MUR460 diode | Anode → Vbus, Cathode → Vbat pad | Mimics battery voltage |
| 4.7kΩ resistor | Vbus → D+ pad | Charger handshake |
| NE555 output | → Power button (PWM) pad | Auto power-on |

---

## 🗺️ Finding the Pads

### General Method
1. Search your board's model number + "schematic" or "test point" online
2. Look for labeled test points: **VBAT, VBUS, GND, D+, D-, PWR_KEY**
3. Use a **multimeter in continuity mode** to trace from known points (USB port pins, battery connector)

### Reference (from build images)
The image `Image 17` in this repo shows:
- **JUMPER** point (orange box) — where D+/D- data lines connect
- **RESISTOR 4K5** location — R0010 component near jumper
- **PSU 4V** label — shows where + and - supply connects to the board
- Use **4V–4.2V** on the Vbat line (not 5V directly!)

```
Board Schematic Reference:
                    ┌─────────────┐
 USB-A Pin1 (5V) ──→│ MUR460 Diode│──→ Vbat pad (4.2V after diode drop)
                    └─────────────┘
                          │
 USB-A Pin1 (5V) ─────────→ Vbus pad
                          │
                    [4.7kΩ resistor]
                          │
 USB-A Pin3 (D+) ─────────→ D+ pad
                          
 USB-A Pin2 (D-) ─────────→ D- pad

 USB-A Pin4 (GND) ────────→ GND pad

 NE555 output ────────────→ PWR_KEY pad (momentary trigger)
```

---

## 🛠️ Step-by-Step Soldering

### Step 1 — Identify and clean the pads
- Use a **flux pen** on the target pads
- If pads are oxidized, lightly scratch with a scalpel

### Step 2 — Tin the wires
- Pre-tin all 4 wires (red, black, green, white) — 2–3mm bare end

### Step 3 — Solder VCC and GND first
- Solder **red wire** to **Vbus pad**
- Solder **black wire** to **GND pad**
- Test with multimeter: should read ~5V between red and black when powered

### Step 4 — Install MUR460 diode
- Solder **anode** to Vbus (same point as red wire)
- Solder **cathode** to **Vbat pad**
- The diode drops ~0.7–1V, giving ~4.0–4.2V to Vbat — safe for most Android boards

### Step 5 — Install 4.7kΩ resistor
- Solder resistor between **Vbus** and **D+ pad**
- This is the charger identification resistor (tells Android "charger connected")

### Step 6 — Solder D+/D- data lines
- **Green wire** → D+ pad (after resistor junction)
- **White wire** → D- pad

### Step 7 — NE555 power trigger
- Connect **NE555 module output** to **PWR_KEY pad**
- Set NE555 delay to ~1–2 seconds (adjust trim pot)
- When power is applied, NE555 fires a pulse → phone turns on automatically

### Step 8 — Add heatsink
- Apply thermal paste or thermal pad to the main SoC (large chip under shield)
- Glue a small aluminum heatsink on top

---

## ✅ Testing the Modded Board

1. Set XL4015 output to **5.0V** before connecting
2. Connect USB-A to your XL4015 output
3. Board should power on within 1–2 seconds (NE555 pulse)
4. Android should boot fully
5. Verify in Android Settings → About Phone → Battery: should show "Charging"

### If it doesn't boot:
- Check Vbat pad voltage — should be 3.9–4.2V
- Verify D+/D- connections (needed for Android to accept USB power)
- Increase NE555 delay slightly
- Try bridging PWR_KEY pad to GND manually (with a wire) to test

---

## 📷 Photos Reference

| Image # | What it shows |
|---------|--------------|
| Image 1 | Completed mod — USB-A soldered to board, wires visible |
| Image 7 | Back of modded board — heatsink + copper coil antenna |
| Image 8 | Front of modded board — label "COMPLETE SOLUTION OF EMMC LABLE" |
| Image 17 | Schematic reference — JUMPER, RESISTOR 4K5, PSU 4V labels |

---

## 🔁 Supported Board Types

This mod works on any Android phone motherboard that has accessible:
- Vbus / Vbat / GND test points
- D+ / D- test points  
- PWR_KEY pad

See [Supported Phones](07-supported-phones.md) for confirmed working models.

---

*Next: [Power Electronics](03-power-electronics.md)*
