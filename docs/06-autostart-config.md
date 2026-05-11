# ⚙️ Auto-Start Configuration

> How to make every phone automatically start mining the moment power is applied — no manual touch required.

---

## Goal

When power is connected to a phone:
1. Phone boots Android automatically
2. Screen stays on permanently
3. Termux launches automatically
4. ccminer starts mining immediately

No human interaction needed after initial setup.

---

## Required APKs

Both APKs are included in the `/apks` folder of this repo.

| App | APK File | Purpose |
|-----|----------|---------|
| Screen Awake | `ScreenAwake_1.2.0.apk` | Keeps screen on, prevents sleep |
| AutoStart - App Manager | `AutoStartManager_5.1.apk` | Launches Termux on boot |

Install both via **sideloading** (Settings → Install unknown apps → Allow).

---

## Part A — Developer Settings

These settings must be enabled on every phone:

### 1. Enable Developer Options
- Settings → About Phone → tap **Build Number** 7 times
- "You are now a developer" message appears

### 2. Developer Options Settings

Go to Settings → Developer Options and enable/set:

| Setting | Value | Why |
|---------|-------|-----|
| Stay awake | ON | Screen stays on while charging |
| USB debugging | ON | Allows ADB if needed |
| Don't keep activities | OFF | Keep background apps alive |
| Background process limit | Standard limit | Don't restrict background |
| Window animation scale | Off (0x) | Faster UI |
| Transition animation scale | Off (0x) | Faster UI |
| Animator duration scale | Off (0x) | Faster UI |

### 3. Battery Optimization — Disable for Termux

- Settings → Battery → Battery Optimization (or App Battery Saver)
- Find **Termux** → Set to **"Not optimized"** or **"Unrestricted"**
- Repeat for **AutoStart** and **Screen Awake**

---

## Part B — Screen Awake App Setup

1. Install `ScreenAwake_1.2.0.apk`
2. Open Screen Awake
3. Toggle **"Keep screen awake"** → ON
4. Enable **"Start on boot"** option (if available in settings)
5. Grant any permissions requested

> This prevents Android from turning off the screen and throttling CPU.

---

## Part C — AutoStart App Manager Setup

1. Install `AutoStartManager_5.1.apk`
2. Open AutoStart - App Manager
3. Find **Termux** in the app list
4. Toggle Termux's **autostart** → ON
5. Confirm any permission dialogs

On some phones (especially Vivo/MIUI), you must also:
- Settings → Apps → Termux → **Auto-start** → Enable
- Settings → Battery → Termux → Allow background activity

---

## Part D — Termux Auto-Start Mining

Make sure your `~/.bashrc` or `/data/data/com.termux/files/usr/etc/bash.bashrc` has this line:

```bash
cd ccminer/ && ./start.sh
```

This makes Termux run the mining script every time it opens.

The full `bashrc_autostart.sh` snippet is in the `/scripts` folder.

---

## Part E — Boot Sequence (What Happens Automatically)

When NE555 fires the power-on pulse (or when phone is powered normally):

```
Power applied
    │
    ▼
NE555 timer fires (1–2 sec delay)
    │
    ▼
Android boots (30–60 seconds)
    │
    ▼
Screen Awake starts (via autostart)
    │
    ▼
AutoStart launches Termux
    │
    ▼
Termux opens → bash.bashrc runs
    │
    ▼
cd ccminer/ && ./start.sh
    │
    ▼
Mining begins ✅
```

Total time from power-on to mining: **~60–90 seconds**

---

## Vivo-Specific Notes

Vivo phones (FuntouchOS) have aggressive background app killing. Extra steps:

1. Settings → Battery → Background Power Management → Termux → **No restrictions**
2. Recent apps → Long-press Termux → Lock app (pin it)
3. Settings → Apps → Termux → Notifications → Allow all
4. Some Vivo models need **AutoStart** permission explicitly:
   - Settings → Battery → High background power consumption → Allow Termux

---

## MIUI (Xiaomi/Redmi) Specific Notes

1. Settings → Apps → Manage apps → Termux → **Autostart** → Enable
2. Settings → Battery & Performance → App battery saver → Termux → No restrictions
3. Security app → Permissions → Autostart → Enable Termux
4. Lock Termux in recent apps (swipe up to lock icon)

---

## Samsung One UI Specific Notes

1. Settings → Apps → Termux → Battery → **Unrestricted**
2. Settings → Device Care → Battery → Background usage limits → Never sleeping apps → Add Termux
3. Enable **Auto-restart** in Developer Options if available

---

## Verifying Everything Works

After full setup, test the complete boot sequence:

1. Power OFF the phone completely
2. Disconnect and reconnect power (or trigger NE555)
3. Wait 90 seconds
4. Check: is the screen on? Is Termux running? Is ccminer showing hashrate?
5. Go to https://vipor.net → search your wallet → confirm worker appears online

---

*Next: [Supported Phones](07-supported-phones.md)*
