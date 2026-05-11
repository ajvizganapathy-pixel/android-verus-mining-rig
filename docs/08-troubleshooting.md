# 🔧 Troubleshooting Guide

> Solutions to the most common problems encountered in this build.

---

## Software Issues

### ❌ ccminer won't compile

**Error:** `clang: command not found`  
**Fix:**
```bash
pkg install clang
```

**Error:** `sysctl.h: No such file or directory`  
**Fix:**
```bash
cp /data/data/com.termux/files/usr/include/linux/sysctl.h \
   /data/data/com.termux/files/usr/include/sys
```

**Error:** Build fails midway with memory error  
**Fix:** Phone has too little RAM. Close all other apps, try again:
```bash
cd ccminer
make clean
CXX=clang++ CC=clang ./build.sh
```

---

### ❌ ccminer runs but shows 0 H/s

**Cause:** Wrong algorithm  
**Fix:** Ensure `config.json` has:
```json
"algo": "verus"
```

**Cause:** Pool connection failing  
**Fix:** Test internet connection, try alternate pool server:
```
us.vipor.net:5040
eu.vipor.net:5040
```

---

### ❌ "Stratum connection failed"

**Cause:** Wrong URL format  
**Fix:** Use exactly:
```
stratum+tcp://sg.vipor.net:5040
```

**Cause:** Firewall blocking port 5040  
**Fix:** Try port 443 (if vipor.net supports it), or switch to mobile data to test

---

### ❌ ccminer stops after a few minutes

**Cause:** Android killing background process  
**Fix:**
1. Disable battery optimization for Termux (see [doc 06](06-autostart-config.md))
2. Acquire wake lock in Termux:
```bash
termux-wake-lock
~/ccminer/start.sh
```
3. Lock Termux in recent apps

---

### ❌ Mining not starting on boot

**Cause:** AutoStart app not configured properly  
**Fix:**
1. Reinstall AutoStartManager APK
2. Verify Termux autostart is enabled in phone's own Settings → Apps → Termux → Autostart
3. Check bash.bashrc has the start command:
```bash
cat /data/data/com.termux/files/usr/etc/bash.bashrc
```
Should contain: `cd ccminer/ && ./start.sh`

---

### ❌ Screen keeps turning off

**Fix:**
1. Open Screen Awake app → toggle ON
2. Developer Options → Stay Awake → ON
3. Settings → Display → Screen timeout → set to "Never" or maximum

---

## Hardware Issues

### ❌ Modded board won't power on

**Check 1: Vbus voltage**
- Measure between USB-A pin 1 and pin 4 with multimeter
- Should read 5.0–5.1V

**Check 2: Vbat voltage**
- Measure Vbat pad to GND
- Should read 3.9–4.2V after MUR460 diode
- If 0V: diode is backwards or dead — check polarity

**Check 3: NE555 output**
- Measure NE555 output pin when power is first applied
- Should pulse HIGH (close to 12V) for ~1 second
- If no pulse: check NE555 VCC (12V) and GND connections

**Check 4: PWR_KEY pad**
- Verify PWR_KEY pad with multimeter (continuity to power button)
- Try manually bridging PWR_KEY pad to GND for 1 second to test

---

### ❌ Phone gets very hot

**Cause:** Vbat voltage too high  
**Fix:** Recheck MUR460 diode — measure Vbat, must not exceed 4.3V

**Cause:** Too many threads  
**Fix:** Reduce threads in config.json:
```json
"threads": 4
```

**Cause:** No heatsink on SoC  
**Fix:** Add small aluminum heatsink with thermal paste to main chip

**Cause:** Inadequate airflow  
**Fix:** Reposition fans to blow directly across phone row, not just upward

---

### ❌ XL4015 output voltage drifting

**Symptom:** Voltage drops below 4.8V under load  
**Fix:**
1. Check actual current draw with USB power meter
2. If drawing >4.5A for 4 phones, add another XL4015 module (split to 2 phones per module)
3. Re-trim the potentiometer to 5.1V no-load (it will drop slightly under load)

---

### ❌ WiFi relay not responding to Alexa

**Fix:**
1. Verify relay and Alexa device are on **same 2.4GHz WiFi network** (not 5GHz)
2. Re-discover devices in Alexa app
3. Assign static IP to relay module in router settings
4. Re-enable Emulated Hue in Tasmota settings

---

### ❌ All phones on one tier went offline suddenly

**Possible cause:** PSU overcurrent trip  
**Check:**
1. Disconnect all phone loads
2. Power on PSU — does indicator LED light?
3. If yes, reconnect phones one by one to find the faulty one
4. If PSU LED is off: PSU may be dead, replace or check AC input fuse

---

## Pool / Wallet Issues

### ❌ Workers not showing on vipor.net

**Wait:** It can take up to 10 minutes for a new worker to appear  
**Check wallet:** Make sure you copied the full wallet address with no extra spaces  
**Check miner name:** The `pass` field in config.json is the worker name

### ❌ "Invalid share" messages

**Cause:** Clock skew or very slow phone  
**Fix:** Reduce threads, ensure stable internet connection

---

## Quick Diagnostic Commands

```bash
# Check CPU temperature
cat /sys/class/thermal/thermal_zone0/temp
# (divide by 1000 for Celsius, e.g. 45000 = 45°C)

# Check running processes
ps aux | grep ccminer

# Check internet connectivity
ping -c 3 sg.vipor.net

# Check Termux wake lock status
cat /proc/wakelocks 2>/dev/null || echo "check termux-wake-lock"

# Manual ccminer test run (verbose)
cd ~/ccminer && ./ccminer -c config.json --debug
```

---

*Back to: [README](../README.md)*
