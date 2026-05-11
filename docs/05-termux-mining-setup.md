# 📱 Termux Mining Setup Guide

> Step-by-step: Install ccminer in Termux on Android and start mining Verus Coin (VRSC).

---

## Prerequisites

- Android phone (any from the [supported list](07-supported-phones.md), or try your own)
- Android 7.0 or higher
- At least 2GB RAM recommended
- **Termux installed from F-Droid** (NOT Play Store — Play Store version is outdated)

---

## Step 1 — Install Termux

> ⚠️ Use F-Droid version only. The Play Store version has been deprecated and lacks key packages.

1. Download F-Droid: https://f-droid.org/
2. Install F-Droid on your phone
3. Search "Termux" in F-Droid → Install
4. Open Termux

---

## Step 2 — One-Shot Install Script

Copy the script from this repo at `scripts/install.sh`, or run each command manually:

```bash
# Update and upgrade packages
yes | pkg update && pkg upgrade -y

# Install required build tools
yes | pkg install libjansson build-essential clang binutils git -y

# Fix missing header (required for ccminer compilation)
cp /data/data/com.termux/files/usr/include/linux/sysctl.h \
   /data/data/com.termux/files/usr/include/sys

# Clone ccminer (Darktron fork — optimized for Android ARM)
git clone https://github.com/Darktron/ccminer.git

# Enter directory
cd ccminer

# Make scripts executable
chmod +x build.sh configure.sh autogen.sh start.sh
```

---

## Step 3 — Edit configure.sh

Before building, you must set the compiler to clang (default won't work on Android):

```bash
nano configure.sh
```

Find the line with `./configure` and make sure it uses `clang`:

```bash
CXX=clang++ CC=clang ./build.sh
```

Save and exit: `Ctrl+X` → `Y` → `Enter`

Then build:
```bash
CXX=clang++ CC=clang ./build.sh
```

> ⏳ Build takes 5–15 minutes depending on phone speed. This is normal.

---

## Step 4 — Configure Mining Pool

```bash
nano config.json
```

Replace the contents with:

```json
{
  "pools": [
    {
      "name": "vipor-sg",
      "url": "stratum+tcp://sg.vipor.net:5040",
      "user": "YOUR_VERUS_WALLET_ADDRESS",
      "pass": "YourMinerName",
      "algo": "verus"
    }
  ],
  "algo": "verus",
  "threads": 6
}
```

**Fields to edit:**
- `user` → Your **Verus wallet address** (get from Verus Mobile app on Play Store)
- `pass` → Any name to identify this miner (e.g., `Phone1`, `AnjanInfinix`)
- `threads` → Number of CPU threads (start with half your CPU count, increase if stable)

**Example wallet address format:**
```
RDxVQALK7PudTe5SnQRNevqFtAfD3QstWd
```
> ⚠️ This is an example address. Use your own wallet address!

**Pool options (vipor.net):**

| Server | URL | Port |
|--------|-----|------|
| Singapore | sg.vipor.net | 5040 |
| US | us.vipor.net | 5040 |
| EU | eu.vipor.net | 5040 |

Save: `Ctrl+X` → `Y` → `Enter`

---

## Step 5 — Start Mining

```bash
~/ccminer/start.sh
```

You should see output like:
```
[2024-01-01 00:00:01] Stratum connected to sg.vipor.net:5040
[2024-01-01 00:00:01] CPU T0: Verus Hashing. (nu)
[2024-01-01 00:00:01] CPU T1: Verus Hashing. (nu)
[2024-01-01 00:00:01] CPU T2: Verus Hashing. (nu)
...
[2024-01-01 00:00:15] accepted: 1/1 (100.00%), 450.23 H/s
```

---

## Step 6 — Set Auto-Start on Boot

Add the start command to your Termux bash profile:

```bash
nano ../usr/etc/bash.bashrc
```

Add this line at the end:
```bash
cd ccminer/ && ./start.sh
```

Save and exit. Now every time Termux opens, mining starts automatically.

See [Auto-Start Config](06-autostart-config.md) for the full boot-to-mine setup using the AutoStart app.

---

## Checking Your Hashrate on vipor.net

1. Go to https://vipor.net
2. Enter your wallet address in the search bar
3. You'll see your workers, hashrate, and pending balance

---

## Performance Reference

| Phone SoC | Threads | Approx Hashrate |
|-----------|---------|----------------|
| Snapdragon 450 | 6 | ~350–450 H/s |
| Snapdragon 625 | 6 | ~450–550 H/s |
| MediaTek Helio P22 | 6 | ~300–400 H/s |
| Snapdragon 665 | 6 | ~500–650 H/s |
| Snapdragon 660 | 6 | ~550–700 H/s |

> These are approximate values. Actual hashrate depends on thermal throttling and phone condition.

---

## Useful Commands

```bash
# Start mining manually
~/ccminer/start.sh

# Run in background (won't stop when Termux closes)
nohup ~/ccminer/start.sh &

# Check if ccminer is running
ps aux | grep ccminer

# Kill ccminer
pkill ccminer

# View live logs from background process
tail -f ~/ccminer/ccminer.log
```

---

*Next: [Auto-Start Configuration](06-autostart-config.md)*
