# 📦 APKs — Installation Guide

This folder contains the two Android APKs required for automatic boot-to-mine operation.

---

## Included APKs

| File | App Name | Version | Purpose |
|------|----------|---------|---------|
| `ScreenAwake_1.2.0.apk` | Screen Awake | 1.2.0 | Keeps screen on permanently |
| `AutoStartManager_5.1.apk` | AutoStart - App Manager | 5.1 | Launches Termux on boot |

---

## How to Install (Sideloading)

### Step 1 — Allow Unknown Sources

On Android 8.0+:
1. Settings → Apps → (find your file manager or browser)
2. Tap "Install unknown apps" → Allow

On Android 7 and below:
1. Settings → Security → Unknown sources → Enable

### Step 2 — Install Screen Awake

1. Open your file manager
2. Navigate to where you saved `ScreenAwake_1.2.0.apk`
3. Tap it → Install → Open
4. Toggle "Keep Screen Awake" → **ON**
5. Enable "Start on boot" if the option is visible

### Step 3 — Install AutoStart Manager

1. Open your file manager
2. Tap `AutoStartManager_5.1.apk` → Install → Open
3. Find **Termux** in the app list
4. Toggle Termux autostart → **ON**
5. Grant any permissions requested (especially "Draw over other apps" if asked)

---

## Additional Manual Steps (Required!)

These steps are needed in addition to the APKs:

### Battery Optimization (ALL phone brands)
- Settings → Battery → Battery Optimization
- Find Termux → Select "Don't optimize" or "Unrestricted"

### Vivo / FuntouchOS
- Settings → Battery → Background power management → Termux → No restrictions
- Settings → Apps → Termux → Autostart → Enable

### Xiaomi / MIUI / HyperOS
- Security app → Autostart → Find Termux → Enable
- Settings → Battery & Performance → App battery saver → Termux → No restrictions

### Samsung One UI
- Settings → Device Care → Battery → More battery settings
- Put Termux in "Never sleeping apps" list

---

## After Both APKs Are Installed

Verify the full chain works:

1. Make sure `~/ccminer/start.sh` exists and ccminer is built
2. Make sure bash.bashrc has `cd ccminer/ && ./start.sh`
3. Power off the phone
4. Power it back on
5. Wait 90 seconds → mining should be running

---

## Source / Original Apps

- **Screen Awake**: Available on APKCombo and Google Play Store
- **AutoStart - App Manager**: Available on APKCombo and Google Play Store

> The APKs in this repo are included for convenience so you can set up phones without internet access. If you prefer, download from the Play Store directly.
