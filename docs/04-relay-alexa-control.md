# 🏠 WiFi Relay & Alexa Charge Control

> How to automate the charge/discharge cycle using ESP8266 WiFi relays, Tasmota firmware, IFTTT, and Amazon Alexa routines.

---

## Why Automate Charge/Discharge?

Android phones are not designed to stay on charge 24/7. Keeping them plugged in constantly:
- Degrades battery faster
- Causes overheating
- Reduces CPU performance (thermal throttling)

**Solution:** A scheduled charge/discharge cycle:
- ✅ **4.5 hours charging** → phone charges to ~100%
- ✅ **1.5 hours discharging** (relay off, phone runs on battery while mining)
- Repeat every 6 hours automatically

This extends battery life and keeps thermals in check.

---

## Hardware Required

| Item | Qty | Notes |
|------|-----|-------|
| ESP8266 WiFi Relay Module | 12 | 1-channel, 5V/12V coil |
| Home WiFi Router | 1 | 2.4GHz (ESP8266 only works on 2.4GHz!) |
| Amazon Echo (Alexa device) | 1 | Any model |
| Amazon account | 1 | For Alexa app + routines |
| IFTTT account | 1 | Free tier is sufficient |

---

## Step 1 — Flash Tasmota Firmware to ESP8266 Relay

The stock firmware on most WiFi relay modules uses a proprietary cloud. **Tasmota** is open-source and integrates cleanly with Alexa.

### Flash using Tasmota Web Installer (easiest):
1. Connect relay module to PC via USB-TTL adapter
2. Open Chrome browser → go to https://tasmota.github.io/install/
3. Click **Connect** → Select COM port
4. Click **Install Tasmota**
5. After flash: configure WiFi (SSID + password)
6. Note the IP address assigned to the module

### Alternative: Use ESPHome
- Works great too, but Tasmota is simpler for beginners

---

## Step 2 — Connect Relay to Alexa via Emulated Hue

Tasmota has a built-in **Emulated Hue Bridge** feature that makes Alexa see it as a Philips Hue light bulb — this gives local-only control (no cloud required).

1. In Tasmota web interface → **Configuration → Configure Other**
2. Enable **Emulated Hue** → Save
3. Open **Alexa app** → Devices → **Discover Devices**
4. Alexa will find each relay as a smart switch (e.g., "Relay 1", "Relay 2")
5. Rename them in Alexa app (e.g., "Top Rack Charger 1")

---

## Step 3 — Create Alexa Routines for Charge Cycling

In the **Alexa app → Routines → Create Routine**:

### Routine A — Start Charging (runs every 6 hours)
```
Trigger: Schedule → Every day → 06:00, 12:00, 18:00, 00:00
Action: Smart Home → Turn ON → [All relay switches]
```

### Routine B — Stop Charging (4.5 hours after start)
```
Trigger: Schedule → Every day → 10:30, 16:30, 22:30, 04:30
Action: Smart Home → Turn OFF → [All relay switches]
```

> The phone mines on battery for 1.5 hours, then charging resumes at the next cycle.

---

## Step 4 — Alternative: IFTTT Webhooks

If Emulated Hue doesn't work on your Alexa device, use IFTTT:

1. Create IFTTT account at https://ifttt.com
2. Create Applet:
   - **If:** Amazon Alexa → "Say a specific phrase" → "start charging"
   - **Then:** Webhooks → Make a web request → `http://[TASMOTA_IP]/cm?cmnd=Power%20On`
3. Repeat for "stop charging" → `Power%20Off`
4. Add IFTTT skill to Alexa

---

## Wiring the Relay to XL4015

The relay sits on the **input side** of the XL4015 (switches 12V):

```
[12V PSU V+] ──→ [Relay COM]
               [Relay NO] ──→ [XL4015 Input V+]
[12V PSU V-] ──────────────→ [XL4015 Input V-]

Relay coil: 5V from small LDO or USB port on PSU
```

When relay is **ON** (closed): power flows to XL4015 → phones charge  
When relay is **OFF** (open): XL4015 has no input → phones run on battery

---

## Monitoring

You can monitor relay status at any time:
- Open browser → `http://[TASMOTA_IP]` → Tasmota dashboard
- Or ask Alexa: *"Alexa, is Top Rack Charger 1 on?"*

### Optional: Tasmota energy monitoring
If your relay module has a **BL0937 / HLW8012 chip** (power monitoring version):
- Tasmota will show real-time Watts, Amps, kWh
- Useful for tracking mining power consumption

---

## Charge Cycle Summary

| Time | Action | Duration |
|------|--------|----------|
| 00:00 | Relays ON — Charging starts | — |
| 04:30 | Relays OFF — Battery discharge begins | 1.5h |
| 06:00 | Relays ON — Charging starts | — |
| 10:30 | Relays OFF — Battery discharge begins | 1.5h |
| 12:00 | Relays ON | — |
| 16:30 | Relays OFF | 1.5h |
| 18:00 | Relays ON | — |
| 22:30 | Relays OFF | 1.5h |

**Result:** 4 charge cycles per day, each with 4.5h charge + 1.5h discharge

---

## Troubleshooting Alexa Discovery

| Problem | Fix |
|---------|-----|
| Alexa doesn't find relay | Ensure both Alexa and relay are on **same 2.4GHz WiFi** |
| Relay keeps disconnecting | Assign **static IP** to relay in router DHCP settings |
| Emulated Hue not working | Try IFTTT Webhooks method instead |
| Wrong relay turns on | Rename devices clearly in Alexa app |

---

*Next: [Termux Mining Setup](05-termux-mining-setup.md)*
