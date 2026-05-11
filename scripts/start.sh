#!/data/data/com.termux/files/usr/bin/bash
# ============================================================
# ccminer Start Script — Verus Coin Mining
# Place this in ~/ccminer/start.sh
# ============================================================

# Acquire wake lock to prevent Android from killing the process
termux-wake-lock 2>/dev/null

# Navigate to ccminer directory
cd "$HOME/ccminer" || exit 1

# Check if ccminer binary exists
if [ ! -f "./ccminer" ]; then
    echo "❌ ccminer binary not found!"
    echo "   Run install.sh first."
    exit 1
fi

# Check if config exists
if [ ! -f "./config.json" ]; then
    echo "❌ config.json not found!"
    echo "   Copy scripts/config.json here and edit your wallet address."
    exit 1
fi

# Check wallet address is set
if grep -q "YOUR_VERUS_WALLET_ADDRESS" ./config.json; then
    echo "⚠️  WARNING: Wallet address not set in config.json!"
    echo "   Edit config.json and replace YOUR_VERUS_WALLET_ADDRESS"
    echo "   Continuing in 5 seconds anyway..."
    sleep 5
fi

echo ""
echo "======================================"
echo "  Starting Verus Coin Mining"
echo "  Pool: sg.vipor.net:5040"
echo "  Check stats: https://vipor.net"
echo "======================================"
echo ""

# Start mining — loops automatically on disconnect
while true; do
    ./ccminer -c config.json
    echo ""
    echo "⚠️  ccminer stopped. Restarting in 10 seconds..."
    sleep 10
done
