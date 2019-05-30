#!/usr/bin/env bash

uname
cat /proc/version

# ---------- Везде ----------
cat /etc/os-release
# ---------- В Red Hat Linux ----------
cat /etc/redhat-release
# ---------- На CentOS Linux ----------
cat /etc/centos-release
# ---------- На Fedora Linux ----------
cat /etc/fedora-release
# ---------- В Debian Linux ----------
cat /etc/debian_version
# ---------- На Ubuntu и Linux Mint ----------
cat /etc/lsb-release
# ---------- На Gentoo Linux ----------
cat /etc/gentoo-release
# ---------- На SuSE Linux ----------
cat /etc/SuSE-release


# Ubuntu
lsb_release -a
# 
# или
# 
# Open “System Settings” from the desktop main menu in Unity.
# Click on the “Details” icon under “System.”
# See version information.
