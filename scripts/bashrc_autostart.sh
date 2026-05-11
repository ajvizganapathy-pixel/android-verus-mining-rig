#!/data/data/com.termux/files/usr/bin/bash
# ============================================================
# bash.bashrc Auto-Start Snippet
# 
# ADD THIS to: /data/data/com.termux/files/usr/etc/bash.bashrc
#
# To add automatically, run:
#   echo 'cd ccminer/ && ./start.sh' >> /data/data/com.termux/files/usr/etc/bash.bashrc
#
# To add manually:
#   nano /data/data/com.termux/files/usr/etc/bash.bashrc
#   (add the line below at the end of the file)
# ============================================================

# ---- ADD THIS LINE TO bash.bashrc ----
cd ccminer/ && ./start.sh
# ---- END OF LINE TO ADD ----

# ============================================================
# What this does:
#   Every time Termux opens (including on auto-launch at boot),
#   it immediately changes to the ccminer directory and runs
#   the start.sh script, which begins mining automatically.
#
# To REMOVE auto-start temporarily:
#   nano /data/data/com.termux/files/usr/etc/bash.bashrc
#   Delete or comment out the "cd ccminer/" line
#
# To check current bash.bashrc contents:
#   cat /data/data/com.termux/files/usr/etc/bash.bashrc
# ============================================================
