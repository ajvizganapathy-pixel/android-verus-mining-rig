#!/data/data/com.termux/files/usr/bin/bash
# ============================================================
# Android Verus Coin Mining Rig — Termux Install Script
# Author: ANJAN GANAPATHY K (ajvizganapathy-pixel)
# GitHub: https://github.com/ajvizganapathy-pixel
# ============================================================

echo ""
echo "====================================================="
echo "  Android Verus Mining Rig — Auto Installer"
echo "  By ANJAN GANAPATHY K"
echo "====================================================="
echo ""

# Step 1: Update packages
echo "[1/6] Updating Termux packages..."
yes | pkg update && pkg upgrade -y
echo "✅ Packages updated."
echo ""

# Step 2: Install dependencies
echo "[2/6] Installing build dependencies..."
yes | pkg install libjansson build-essential clang binutils git -y
echo "✅ Dependencies installed."
echo ""

# Step 3: Fix missing sysctl.h header
echo "[3/6] Fixing sysctl.h header..."
cp /data/data/com.termux/files/usr/include/linux/sysctl.h \
   /data/data/com.termux/files/usr/include/sys 2>/dev/null
if [ $? -eq 0 ]; then
    echo "✅ sysctl.h copied."
else
    echo "⚠️  sysctl.h already in place or not needed — continuing."
fi
echo ""

# Step 4: Clone ccminer
echo "[4/6] Cloning ccminer (Darktron fork)..."
if [ -d "$HOME/ccminer" ]; then
    echo "⚠️  ccminer directory already exists. Pulling latest..."
    cd "$HOME/ccminer" && git pull
else
    git clone https://github.com/Darktron/ccminer.git "$HOME/ccminer"
fi
echo "✅ ccminer cloned."
echo ""

# Step 5: Prepare build
echo "[5/6] Preparing build scripts..."
cd "$HOME/ccminer"
chmod +x build.sh configure.sh autogen.sh start.sh 2>/dev/null

# Patch configure.sh to use clang
sed -i 's/\.\/configure/CXX=clang++ CC=clang \.\/configure/g' configure.sh 2>/dev/null

echo "✅ Build scripts ready."
echo ""

# Step 6: Build ccminer
echo "[6/6] Building ccminer (this takes 5–15 minutes)..."
echo "      Please wait..."
echo ""

cd "$HOME/ccminer"
CXX=clang++ CC=clang ./build.sh

if [ -f "$HOME/ccminer/ccminer" ]; then
    echo ""
    echo "✅✅✅ ccminer built successfully!"
    echo ""
    echo "====================================================="
    echo "  NEXT STEPS:"
    echo "====================================================="
    echo ""
    echo "  1. Edit your config.json:"
    echo "     nano ~/ccminer/config.json"
    echo ""
    echo "  2. Replace 'YOUR_VERUS_WALLET_ADDRESS' with your"
    echo "     actual wallet address from the Verus Mobile app"
    echo ""
    echo "  3. Start mining:"
    echo "     ~/ccminer/start.sh"
    echo ""
    echo "  4. Check your stats at:"
    echo "     https://vipor.net"
    echo ""
    echo "====================================================="
    echo ""
    
    # Auto-install config.json if it doesn't exist
    if [ ! -f "$HOME/ccminer/config.json" ]; then
        echo "Installing default config.json..."
        cat > "$HOME/ccminer/config.json" << 'EOF'
{
  "pools": [
    {
      "name": "vipor-sg",
      "url": "stratum+tcp://sg.vipor.net:5040",
      "user": "YOUR_VERUS_WALLET_ADDRESS",
      "pass": "MyAndroidMiner",
      "algo": "verus"
    }
  ],
  "algo": "verus",
  "threads": 6
}
EOF
        echo "✅ Default config.json created — edit it now!"
        echo "   nano ~/ccminer/config.json"
    fi
    
    # Set up auto-start in bash.bashrc
    BASHRC="/data/data/com.termux/files/usr/etc/bash.bashrc"
    if ! grep -q "ccminer" "$BASHRC" 2>/dev/null; then
        echo "" >> "$BASHRC"
        echo "# Auto-start mining — added by install.sh" >> "$BASHRC"
        echo "cd ccminer/ && ./start.sh" >> "$BASHRC"
        echo "✅ Auto-start added to bash.bashrc"
    else
        echo "⚠️  Auto-start already in bash.bashrc — skipping."
    fi

else
    echo ""
    echo "❌ Build FAILED. See error messages above."
    echo ""
    echo "Common fixes:"
    echo "  - Run: pkg install clang build-essential"
    echo "  - Ensure you have enough storage space"
    echo "  - Try: make clean && CXX=clang++ CC=clang ./build.sh"
    echo ""
fi
