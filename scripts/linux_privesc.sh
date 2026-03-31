#!/bin/bash
# Post-Exploitation: Linux Privilege Escalation Checker

echo "======================================"
echo "    Basic PrivEsc Enumeration         "
echo "======================================"

echo -e "\n[+] Current User Context:"
id

echo -e "\n[+] Sudo Permissions (Without Password):"
sudo -l 2>/dev/null | grep "NOPASSWD" || echo "None found."

echo -e "\n[+] Searching for SUID Binaries (Abusable via GTFOBins):"
find / -perm -4000 -type f 2>/dev/null | grep -v "/snap/" | grep -E "nmap|vim|find|bash|cp|mv|nano" || echo "No obvious SUID vectors found."

echo -e "\n[+] World-Writable Files in /etc:"
find /etc -maxdepth 1 -writable -type f 2>/dev/null

echo -e "\n[+] Cron Jobs:"
cat /etc/crontab 2>/dev/null
